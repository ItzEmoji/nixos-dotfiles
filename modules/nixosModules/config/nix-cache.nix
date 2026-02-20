{ ... }:
{
  flake.nixosModules.nix-cache =
    { ... }:
    {
      nix.settings = {
        substituters = [
          "https://cache.itzemoji.com/nix"
        ];
        trusted-public-keys = [
          "nix:U22mA6l/Br6W9STnaHWO2LPvUCNVuh1yTEIlTCtjtkg="
        ];
      };
    };
}
