{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];
    flake.wrappers.bat =
       { wlib, pkgs, ... }:
       {
         imports = [ wlib.modules.default ];

          config.package = pkgs.bat;

          config.flags = {
            "--style" = "plain";
            "--paging" = "never";
            "--theme" = "Catppuccin Mocha";
          };
      };
}
