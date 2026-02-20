{ lib, inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];
  options.flake.homeManagerModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
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
