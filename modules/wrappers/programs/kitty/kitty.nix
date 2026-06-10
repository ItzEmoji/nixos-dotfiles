{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  flake.wrappers.kitty =
    { wlib, pkgs, ... }:

    let
      kittyConf = pkgs.writeText "kitty.conf" (builtins.readFile ./kitty.conf);
    in
    {
      imports = [ wlib.modules.default ];

      config.package = pkgs.kitty;

      config.flags = {
        "--config" = kittyConf;
      };
    };
}
