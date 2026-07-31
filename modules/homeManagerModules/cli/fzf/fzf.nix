{ ... }:
{
  flake.homeManagerModules.fzf =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.fzf = {
        enable = true;
        historyWidget.command = "";
      };
    };
}
