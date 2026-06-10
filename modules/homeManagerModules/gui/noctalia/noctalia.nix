{ ... }:
{
  flake.homeManagerModules.noctalia =
    { pkgs, inputs, ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
      };
      home.file.".config/noctalia".source = ./conf;
    };
}
