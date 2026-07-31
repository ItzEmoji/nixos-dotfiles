import { describe, test, expect } from 'bun:test';
const {
  findMatchingClose,
  extractConfigRows,
  findModuleAssignments,
} = require('./nix-config-parser');

describe('findMatchingClose', () => {
  test('matches simple braces', () => {
    const text = '{ a = 1; }';
    expect(findMatchingClose(text, 0)).toBe(text.length - 1);
  });

  test('skips braces inside double-quoted strings', () => {
    const text = '{ a = "}"; }';
    expect(findMatchingClose(text, 0)).toBe(text.length - 1);
  });

  test('skips braces inside indented strings, including ${...} interpolation', () => {
    const text = [
      "{ a = ''",
      "  ${config.home.homeDirectory}/dotfiles",
      "''; }",
    ].join('\n');
    expect(findMatchingClose(text, 0)).toBe(text.length - 1);
  });
});

describe('extractConfigRows', () => {
  test('flattens a simple dotted assignment', () => {
    const body = 'services.tailscale.enable = true;';
    expect(extractConfigRows(body)).toEqual([
      { path: 'services.tailscale.enable', value: 'true' },
    ]);
  });

  test('expands a nested attrset literal into multiple rows', () => {
    const body = [
      'nix.settings = {',
      '  require-sigs = true;',
      '  fallback = true;',
      '};',
    ].join('\n');
    expect(extractConfigRows(body)).toEqual([
      { path: 'nix.settings.require-sigs', value: 'true' },
      { path: 'nix.settings.fallback', value: 'true' },
    ]);
  });

  test('skips the imports key', () => {
    const body = [
      'imports = [ inputs.home-manager.nixosModules.home-manager ];',
      'home-manager.useGlobalPkgs = true;',
    ].join('\n');
    expect(extractConfigRows(body)).toEqual([
      { path: 'home-manager.useGlobalPkgs', value: 'true' },
    ]);
  });

  test('treats a package list as one leaf row, not recursed', () => {
    const body = [
      'home.packages = with pkgs; [',
      '  btop',
      '  jq',
      '];',
    ].join('\n');
    expect(extractConfigRows(body)).toEqual([
      { path: 'home.packages', value: 'with pkgs; [ btop jq ]' },
    ]);
  });

  test('handles quoted attribute keys', () => {
    const body = [
      'config.flags = {',
      '  "--style" = "plain";',
      '  "--paging" = "never";',
      '};',
    ].join('\n');
    expect(extractConfigRows(body)).toEqual([
      { path: 'config.flags."--style"', value: '"plain"' },
      { path: 'config.flags."--paging"', value: '"never"' },
    ]);
  });

  test('caps recursion at maxDepth, collapsing deeper attrsets into a blob row', () => {
    const body = [
      'a = {',
      '  b = {',
      '    c = {',
      '      d = {',
      '        e = { f = 1; };',
      '      };',
      '    };',
      '  };',
      '};',
    ].join('\n');
    expect(extractConfigRows(body, { maxDepth: 4 })).toEqual([
      { path: 'a.b.c.d.e', value: '{ f = 1; }' },
    ]);
  });

  test('does not recurse into a let-in value, and correctly finds the real terminator past the let binding\'s own semicolon (the Rofi theme pattern)', () => {
    const body = [
      'theme =',
      '  let',
      '    inherit (config.lib.formats.rasi) mkLiteral;',
      '  in',
      '  {',
      '    "*" = { font = "JetBrains Mono 11"; };',
      '  };',
      'extraConfig.terminal = "kitty";',
    ].join('\n');
    const rows = extractConfigRows(body);
    expect(rows).toHaveLength(2);
    expect(rows[0].path).toBe('theme');
    expect(rows[0].value).toContain('mkLiteral');
    expect(rows[0].value).toContain('"*"');
    expect(rows[1]).toEqual({ path: 'extraConfig.terminal', value: '"kitty"' });
  });

  test('does not break on a multi-line initContent-style string using the \'\'$ literal-dollar escape (real zsh.nix pattern)', () => {
    // Matches the real source in modules/homeManagerModules/cli/zsh/zsh.nix:66
    // exactly: `''$` escapes a literal `$` so the zsh parameter expansion
    // `${(s.:.)LS_COLORS}` is emitted literally instead of triggering Nix
    // interpolation. There is no trailing `''` before the closing `"` — that
    // would be a different (invalid) construct.
    const body = [
      "programs.zsh.initContent = ''",
      "  zstyle ':completion:*' list-colors \"''${(s.:.)LS_COLORS}\"",
      "'';",
      'programs.zsh.enableCompletion = true;',
    ].join('\n');
    const rows = extractConfigRows(body);
    expect(rows.map((r) => r.path)).toEqual([
      'programs.zsh.initContent',
      'programs.zsh.enableCompletion',
    ]);
  });

  test('surfaces an inherit-only nested attrset as a visible blob row instead of dropping it (real home-manager.nix pattern)', () => {
    // Matches modules/nixosModules/config/home-manager.nix and
    // modules/homeManagerModules/base.nix: an `extraSpecialArgs` attrset
    // whose only statement is `inherit ...;`, which has no `=` and so can't
    // be parsed as `key = value;`. Previously this silently produced zero
    // rows for the entire nested attrset; it must now show up somehow.
    const body = [
      'home-manager = {',
      '  useGlobalPkgs = true;',
      '  extraSpecialArgs = { inherit inputs self; };',
      '};',
    ].join('\n');
    const rows = extractConfigRows(body);
    expect(rows).toContainEqual({ path: 'home-manager.useGlobalPkgs', value: 'true' });
    const unparsedRow = rows.find((r) => r.path.startsWith('home-manager.extraSpecialArgs'));
    expect(unparsedRow).toBeDefined();
    expect(unparsedRow.path).toBe('home-manager.extraSpecialArgs.<unparsed>');
    expect(unparsedRow.value).toContain('inherit inputs self;');
  });

  test('surfaces a top-level inherit statement as a visible blob row rather than dropping everything after it', () => {
    // The review's hypothetical worst case: an `inherit` line near the top
    // of an attrset must not silently swallow every entry that follows it.
    const body = [
      'inherit (pkgs) foo;',
      'services.tailscale.enable = true;',
    ].join('\n');
    const rows = extractConfigRows(body);
    expect(rows).toHaveLength(1);
    expect(rows[0].path).toBe('<unparsed>');
    expect(rows[0].value).toContain('inherit (pkgs) foo;');
  });
});

describe('findModuleAssignments', () => {
  test('finds a plain nixosModules registration', () => {
    const file = [
      '{ ... }:',
      '{',
      '  flake.nixosModules.tailscale =',
      '    { ... }:',
      '    {',
      '      services.tailscale.enable = true;',
      '    };',
      '}',
    ].join('\n');
    const found = findModuleAssignments(file);
    expect(found).toHaveLength(1);
    expect(found[0].registry).toBe('nixosModules');
    expect(found[0].name).toBe('tailscale');
    expect(extractConfigRows(found[0].bodyText)).toEqual([
      { path: 'services.tailscale.enable', value: 'true' },
    ]);
  });

  test('finds multiple registrations across registries in one file', () => {
    const file = [
      '{ ... }:',
      '{',
      '  flake.nixosModules.packages-global =',
      '    { pkgs, ... }:',
      '    {',
      '      environment.systemPackages = [ pkgs.git ];',
      '    };',
      '  flake.homeManagerModules.packages-global =',
      '    { pkgs, ... }:',
      '    {',
      '      home.packages = [ pkgs.btop ];',
      '    };',
      '}',
    ].join('\n');
    const found = findModuleAssignments(file);
    expect(found).toHaveLength(2);
    expect(found.map((f) => f.registry)).toEqual(['nixosModules', 'homeManagerModules']);
  });

  test('unwraps a let-in body (the wrapper-module pattern)', () => {
    const file = [
      '{ inputs, ... }:',
      '{',
      '  flake.wrappers.tmux =',
      '    { wlib, pkgs, ... }:',
      '    let',
      '      tmuxConf = pkgs.writeText "tmux.conf" (builtins.readFile ./tmux.conf);',
      '    in',
      '    {',
      '      imports = [ wlib.modules.default ];',
      '      config.package = pkgs.tmux;',
      '      config.flags = {',
      '        "-f" = tmuxConf;',
      '      };',
      '    };',
      '}',
    ].join('\n');
    const found = findModuleAssignments(file);
    expect(found).toHaveLength(1);
    expect(found[0].registry).toBe('wrappers');
    expect(found[0].name).toBe('tmux');
    expect(extractConfigRows(found[0].bodyText)).toEqual([
      { path: 'config.package', value: 'pkgs.tmux' },
      { path: 'config.flags."-f"', value: 'tmuxConf' },
    ]);
  });

  test('records a registration with bodyText: null instead of silently dropping it when the RHS is not a recognizable "{ args }: { body }" lambda', () => {
    const file = [
      '{ ... }:',
      '{',
      '  flake.nixosModules.aliased = someExistingBinding;',
      '}',
    ].join('\n');
    const found = findModuleAssignments(file);
    expect(found).toHaveLength(1);
    expect(found[0].registry).toBe('nixosModules');
    expect(found[0].name).toBe('aliased');
    expect(found[0].bodyText).toBeNull();
  });
});
