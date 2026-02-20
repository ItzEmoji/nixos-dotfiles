{ ... }:
{
  flake.nixosModules.kmscon =
    { pkgs, ... }:
    {
      services.kmscon = {
        enable = true;
        hwRender = true;
        useXkbConfig = true;
        fonts = [
          {
            name = "JetBrains Mono Nerd Font";
            package = pkgs.nerd-fonts.jetbrains-mono;
          }
        ];
      };
    };
}
