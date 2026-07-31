[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)
# ❄️ Cyril's NixOS Dotfiles

This repository contains my personal NixOS configuration, managed entirely with [Nix Flakes](https://nixos.wiki/wiki/Flakes).

**Full documentation, including a per-module reference, lives at
[docs.itzemoji.com](https://docs.itzemoji.com).**

## 🚀 Quick install

```bash
git clone https://github.com/ItzEmoji/nixos-dotfiles.git
cd nixos-dotfiles
sudo nixos-rebuild switch --flake .#cyril-nixos
```

See [docs.itzemoji.com](https://docs.itzemoji.com) for what each host and module
actually configures.
