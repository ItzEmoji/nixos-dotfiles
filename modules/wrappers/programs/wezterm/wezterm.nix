{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  flake.wrappers.wezterm =
    { wlib, pkgs, ... }:

    let
      weztermConf = pkgs.writeText "wezterm.lua" (builtins.readFile ./wezterm.lua);
    in
    {
      imports = [ wlib.modules.default ];

      config.package = pkgs.wezterm;

      config.flags = {
        "--config-file" = weztermConf;
      };
    };
}
