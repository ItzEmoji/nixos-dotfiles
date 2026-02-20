{ ... }:
{
  flake.nixosModules.nvidia =
    { ... }:
    {
      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
      };

      services.xserver.videoDrivers = [ "nvidia" ];
    };
}
