{ ... }:
{
  flake.nixosModules.base-system =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Networking
      networking.networkmanager.enable = true;

      # Timezone & Locale
      time.timeZone = "Europe/Zurich";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "C.UTF-8/UTF-8"
      ];
      # Nix settings
      nixpkgs.config.allowUnfree = true;
      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        require-sigs = true;
        fallback = true;
      };

      system.stateVersion = "25.05";
    };
}
