[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)
# ❄️ Cyril's NixOS Dotfiles

This repository contains my personal NixOS configuration, managed entirely with [Nix Flakes](https://nixos.wiki/wiki/Flakes). 




## 🚀 Installation

Follow these steps to install and apply this configuration to your system.

#### 1. Clone the Repository

First, clone the repository to your local machine and change into the new directory.

```bash
git clone [https://github.com/ItzEmoji/nixos-dotfiles.git](https://github.com/ItzEmoji/nixos-dotfiles.git)
cd nixos-dotfiles
```

#### 2. Build Your System
Then, apply the configuration to your system. This command will build the new NixOS generation from the flake and switch to it immediately.

```bash
sudo nixos-rebuild switch --flake .#cyril-nixos
```
Your system is now configured! Reboot if necessary for all changes to take effect.


