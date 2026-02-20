{ ... }:
{
  flake.nixosModules.xkb = { ... }: {
    services.xserver.xkb.layout = "ch";
  };
}
