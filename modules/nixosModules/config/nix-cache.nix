{ ... }:
{
  flake.nixosModules.nix-cache =
    { ... }:
    {
      nix.settings = {
        substituters = [
          "https://packages.itzemoji.com"
        ];
        trusted-public-keys = [
          "packages.itzemoji.com:AnGnY4m1zpWTt7B/lI+5ihAL0r0SR5pmsevZtJTexhQ="
        ];
      };
    };
}
