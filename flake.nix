{
  description = "This is my NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";
    nvim.url = "github:ItzEmoji/nvim";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    mango.url = "github:DreamMaoMao/mango";
    mango.inputs.nixpkgs.follows = "nixpkgs";
  };
outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.cyril-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          inputs.mango.nixosModules.mango
          stylix.nixosModules.stylix
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cyril = {
              imports = [
                ./home.nix
                ./config/desktop/stylix/stylix-home-manager.nix
                ./config/desktop/desktop.nix
                ./config/cli/cli.nix
                ./config/programs/programs.nix
                inputs.spicetify-nix.homeManagerModules.default
              ];
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
      homeConfigurations.cyril = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home.nix

          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
}

