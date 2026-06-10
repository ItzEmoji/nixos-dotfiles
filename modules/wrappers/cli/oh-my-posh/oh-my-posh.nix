{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  flake.wrappers.oh-my-posh =
    { wlib, pkgs, ... }:

    {
      imports = [ wlib.wrapperModules.oh-my-posh ];
      config.configFile = ./config.toml;
    };
}
