{ ... }:
{
  flake.homeManagerModules.oh-my-posh =
    {
      config,
      pkgs,
      self,
      ...
    }:
    {
      programs.oh-my-posh = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.oh-my-posh;
      };
    };
}
