{ ... }:
{
  flake.homeManagerModules.home =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    {
      home.username = lib.mkDefault "cyril";
      home.homeDirectory = lib.mkDefault "/home/cyril";
      home.stateVersion = "25.05";
      home.sessionVariables = {
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
      };
      home.language.base = "en_US.UTF-8";
    };
  flake.nixosModules.home-manager =
    { inputs, ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
