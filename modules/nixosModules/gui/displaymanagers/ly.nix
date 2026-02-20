{ ... }:
{
  flake.nixosModules.ly =
    { ... }:
    {
      services.displayManager.ly = {
        enable = true;
        x11Support = true;
      };
    };
}
