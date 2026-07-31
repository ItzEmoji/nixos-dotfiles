{ ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      lib = pkgs.lib;
      # A standalone mirror of the option declared in modules/options.nix, used only to
      # feed the docs pipeline below (kept isolated from the real flake-parts evaluation).
      docsOptionsModule = {
        options.flake.homeManagerModules = lib.mkOption {
          type = lib.types.lazyAttrsOf lib.types.raw;
          default = { };
          description = ''
            Registry of home-manager modules published by this flake, keyed by name
            (e.g. `zsh`, `hypr`, `noctalia`). Each host's user config
            (`modules/hosts/*/user-cyril.nix`) imports the entries it needs from
            `self.homeManagerModules.<name>`.
          '';
        };
      };
      evaluated = lib.evalModules { modules = [ docsOptionsModule ]; };
      optionsDoc = pkgs.nixosOptionsDoc { options = evaluated.options; };
    in
    {
      packages.docsOptionsJSON = optionsDoc.optionsJSON;
    };
}
