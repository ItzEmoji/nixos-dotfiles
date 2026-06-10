local wezterm = require 'wezterm'

return {
  default_prog = { 'zsh' },
  font = wezterm.font('JetBrainsMono Nerd Font'),
  font_size = 11.25,
  
  default_cursor_style = 'BlinkingBlock',
  

  colors = {
    background = '#282828',
    foreground = '#EBDBB2',
    cursor_bg  = '#EBDBB2',
    cursor_fg  = '#282828',
    cursor_border = '#EBDBB2',

    ansi = {
      '#282828', -- Normal Black
      '#CC241D', -- Normal Red
      '#98971A', -- Normal Green
      '#D79921', -- Normal Yellow
      '#458588', -- Normal Blue
      '#B16286', -- Normal Magenta
      '#689D6A', -- Normal Cyan
      '#A89984', -- Normal White
    },
    brights = {
      '#928374', -- Bright Black
      '#FB4934', -- Bright Red
      '#B8BB26', -- Bright Green
      '#FABD2F', -- Bright Yellow
      '#83A598', -- Bright Blue
      '#D3869B', -- Bright Magenta
      '#8EC07C', -- Bright Cyan
      '#EBDBB2', -- Bright White
    },
  },
}
