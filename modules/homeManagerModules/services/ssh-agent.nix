{ ... }:
{
  flake.homeManagerModules.ssh-agent =
    { ... }:
    {
      services.ssh-agent = {
        enable = true;
      };
    };
}
