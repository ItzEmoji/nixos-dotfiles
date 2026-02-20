{ ... }:
{
  flake.homeManagerModules.quickshell =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        quickshell
      ];
    };
}
