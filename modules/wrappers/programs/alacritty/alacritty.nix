{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  flake.wrappers.alacritty =
    { wlib, pkgs, ... }:

    let
      alacrittyConf = pkgs.writeText "alacritty.toml" (builtins.readFile ./alacritty.toml);
    in
    {
      imports = [ wlib.modules.default ];

      config.package = pkgs.alacritty;

      config.flags = {
        "--config-file" = alacrittyConf;
      };
    };
}
