{ inputs, self, ... }:
{
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs self; };
    modules = [
      self.nixosModules.wsl
      self.nixosModules.packages-global
      self.nixosModules.packages-wsl
      self.nixosModules.home-manager
      self.nixosModules.wsl-cyril
      {
        networking.hostName = "cyril-wsl";
      }
    ];
  };
}
