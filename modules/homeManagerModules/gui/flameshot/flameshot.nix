{ ... }:
{
  flake.homeManagerModules.flameshot =
    {
      config,
      pkgs,
      ...
    }:
    {
      services.flameshot.enable = true;
      services.flameshot.settings = {
        General = {
          showStartupLaunchMessage = false;
          disabledTrayIcon = true;
        };
      };
    };
}
