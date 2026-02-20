{ ... }:
{
  flake.homeManagerModules.kitty =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.kitty = {
        enable = true;
        settings = {
          font_family = "JetBrainsMono Nerd Font Mono";
          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";

          foreground = "#C0CAF5";
          background = "#1A1B26";
          cursor = "#C0CAF5";
          cursor_text_color = "#45475a";

          color0 = "#414868";
          color1 = "#F7768E";
          color2 = "#9ECE6A";
          color3 = "#E0AF68";
          color4 = "7AA2F7";
          color5 = "#BB9AF7";
          color6 = "#7DCFFF";
          color7 = "#A9B1D6";
          color8 = "#414868";
          color9 = "#F7768E";
          color10 = "#9ECE6A";
          color11 = "#E0AF68";
          color12 = "#7AA2F7";
          color13 = "#BB9AF7";
          color14 = "#7DCFFF";
          color15 = "#C0CAF5";
        };
      };
    };
}
