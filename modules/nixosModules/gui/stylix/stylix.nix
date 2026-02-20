{ ... }:
{
  flake.nixosModules.stylix =
    {
      config,
      pkgs,
      inputs,
      ...
    }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        autoEnable = false;
      };
    };
}
