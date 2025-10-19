{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
     zinit
     eza
     bat
     zsh
     unimatrix    
     zinit
     eza
     bat
     gh
     unimatrix
     fastfetch
   ];
  programs.zsh = {
    enable = true;
    history = {
      size = 5000;
      share = true;
      append = true;
      ignoreSpace = true;
    };
    shellAliases = {
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      vim = "nvim";
      c = "clear";
      cat = "bat";
      run = "nix-alien-ld";
      neofetch = "fastfetch";
      e = "exit";
      y = "yazi";
      matrix = "unimatrix";
      nrs = "nh os switch ~/dotfiles/ -H cyril-nixos";
    };
    sessionVariables = {
      EDITOR = "nvim";
      LANG = "C";
      BAT_THEME = "Catpppuccin Frappe";
      NH_FLAKE="${config.home.homeDirectory}/dotfiles";
      ZELLIJ_CONFIG_DIR = "${config.home.homeDirectory}/.config/zellij/";
      FZF_CTRL_T_OPTS = "--preview 'bat -n --color=always --line-range :500 {}'";
      FZF_ALT_C_OPTS = "--preview 'eza --tree --color=always {} | head -200'";
    };

  };
  home.sessionPath = [
    "${config.home.homeDirectory}/.npm/global/bin"
  ];
  programs.zsh.initContent = ''

    # Source zinit from its Nix store path
    source "${pkgs.zinit}/share/zinit/zinit.zsh"

    # Add in zsh plugins
    zinit light zsh-users/zsh-syntax-highlighting
    zinit ice atload="zicompinit"
    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-autosuggestions
    zinit light Aloxaf/fzf-tab

   # Add in snippets
   zinit snippet OMZP::command-not-found

   # These create small init scripts in your home dir for speed
    # zinit ice as"program" from"gh-r" atinit"zoxide init --cmd cd zsh >| ~/.zoxide.zsh"
    # zinit light "ajeetdsouza/zoxide"
    # zinit ice as"program" from"gh-r" atpull"oh-my-posh init zsh --config ~/.config/oh-my-posh/base.toml >| ~/.oh-my-posh.zsh"
    # zinit light "JanDeDobbeleer/oh-my-posh"
    # zinit ice as"program" from"gh-r" atinit"atuin init zsh >| ~/.atuin.zsh"
    # zinit light "atuinsh/atuin"
    # Load completions
    zinit cdreplay -q

    # Keybindings
    bindkey -e
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward
    bindkey '^[w' kill-region

    # Completion styling
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

    # Custom FZF function from your zshrc
    _fzf_comprun(){
       local command=$1
       shift
       case "$command" in
          cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
          export)       fzf --preview "eval 'echo \$' {}"          "$@" ;;
          ssh)          fzf --preview 'dig {}' "$@" ;;
          *)            fzf --preview "--preview 'bat -n --color=always --line-range : 500 {}'" "$@" ;;
       esac
    }
  '';
    
}
