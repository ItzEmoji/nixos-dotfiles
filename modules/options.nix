{ lib, inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];
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

  config = {
    perSystem =
      { pkgs, ... }:
      {
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.nixfmt.enable = true;
        };
      };
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
