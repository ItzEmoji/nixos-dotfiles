{ ... }:
{
  flake.homeManagerModules.atuin =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.atuin = {
        enable = true;
        enableZshIntegration = true;
        settings = builtins.fromTOML (builtins.readFile ./config.toml);
      };
    };
}
