{ ... }:
{
  flake.nixosModules.audio =
    { ... }:
    {
      services.pulseaudio.enable = true;
      services.pipewire.enable = false;
    };
}
