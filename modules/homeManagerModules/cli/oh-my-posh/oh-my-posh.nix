{ ... }:
{
  flake.homeManagerModules.oh-my-posh =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.oh-my-posh = {
        enable = true;
        settings = builtins.fromJSON (builtins.readFile ./config.json);
      };
    };
}
