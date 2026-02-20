{ ... }:
{
  flake.nixosModules.wsl =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    {
      imports = [
        inputs.nixos-wsl.nixosModules.default
      ];

      wsl = {
        enable = true;
        defaultUser = "cyril";
        interop.register = true;
        docker-desktop.enable = true;
      };

      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      programs.ssh.startAgent = true;
      programs.zsh.enable = true;

      users.users.cyril = {
        shell = pkgs.zsh;
      };

      system.stateVersion = "25.05";
    };
}
