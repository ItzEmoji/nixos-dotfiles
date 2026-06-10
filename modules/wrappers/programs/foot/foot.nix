{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  flake.wrappers.foot =
    { wlib, pkgs, ... }:

    let
      footConf = pkgs.writeText "foot.ini" (builtins.readFile ./foot.ini);
    in
    {
      imports = [ wlib.modules.default ];

      config.package = pkgs.foot;

      config.flags = {
        "--config" = footConf;
      };
    };
}
