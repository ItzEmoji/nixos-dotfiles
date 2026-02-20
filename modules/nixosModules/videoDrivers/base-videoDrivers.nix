{ ... }:
{
  flake.nixosModules.base-videoDrivers =
    { ... }:
    {
      hardware.graphics.enable = true;
    };
}
