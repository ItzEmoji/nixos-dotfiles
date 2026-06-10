{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  flake.wrappers.rio =
    { wlib, pkgs, ... }:

    let
      rioConfDir = pkgs.writeTextDir "config.toml" (builtins.readFile ./config.toml);
    in
    {
      imports = [ wlib.modules.default ];

      config.package = pkgs.rio;

      config.env = {
        "RIO_CONFIG_HOME" = "${rioConfDir}";
      };
    };
}
