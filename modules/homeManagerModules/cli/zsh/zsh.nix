{ ... }:
{
  flake.homeManagerModules.zsh =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        zinit
        eza
        zsh
        unimatrix
        gh
        fastfetch
      ];
      programs.zsh = {
        enable = true;
        shellAliases = {
          vim = "nvim";
          c = "clear";
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
          NH_FLAKE = "${config.home.homeDirectory}/dotfiles";
          FZF_CTRL_T_OPTS = "--preview 'bat -n --color=always --line-range :500 {}'";
          FZF_ALT_C_OPTS = "--preview 'eza --tree --color=always {} | head -200'";
        };
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        plugins = [
          {
            name = "fzf-tab";
            src = pkgs.zsh-fzf-tab;
            file = "share/fzf-tab/fzf-tab.plugin.zsh";
          }
          {
            name = "zsh-autosuggestions";
            src = pkgs.zsh-autosuggestions;
            file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
          }
        ];
      };
      programs.nix-index.enable = true;
      programs.dircolors.enable = true;
      home.sessionPath = [
        "${config.home.homeDirectory}/.npm/global/bin"
      ];
      programs.zsh.initContent = ''
          # Keybindings
          
          bindkey -e
          bindkey '^p' history-search-backward
          bindkey '^n' history-search-forward
          bindkey '^[w' kill-region
          # fzf-tab zstyles for your bat/eza previews
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:*:*' fzf-preview 'if [ -d $realpath ]; then eza --tree --color=always $realpath | head -200; elif [ -f $realpath ]; then bat -n --color=always --line-range :500 $realpath; else echo $realpath; fi'
          _fzf_comprun(){
             local command=$1
             shift
             case "$command" in
                cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
                export)       fzf --preview "eval 'echo \$' {}"          "$@" ;;
                ssh)          fzf --preview 'dig {}' "$@" ;;
                *)            fzf --preview 'bat -n --color=always --line-range :500 {}' "$@" ;;
             esac
          }
      '';
    };
}
