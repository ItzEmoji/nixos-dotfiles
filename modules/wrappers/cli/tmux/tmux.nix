{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  flake.wrappers.tmux =
    { wlib, pkgs, ... }:

    let
      tmuxConf = pkgs.writeText "tmux.conf" (builtins.readFile ./tmux.conf);
    in
    {
      imports = [ wlib.modules.default ];

      config.package = pkgs.tmux;

      config.flags = {
        "-f" = tmuxConf;
      };
    };
}
