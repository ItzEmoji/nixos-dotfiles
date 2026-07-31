---
id: intro
slug: /
sidebar_position: 1
title: Introduction
---

# Cyril's NixOS Dotfiles

This is the documentation for [ItzEmoji/nixos-dotfiles](https://github.com/ItzEmoji/nixos-dotfiles),
a personal NixOS configuration managed entirely with [Nix Flakes](https://nixos.wiki/wiki/Flakes)
and [flake-parts](https://flake.parts/).

## Installation

Clone the repository and switch to it with `nixos-rebuild`:

```bash
git clone https://github.com/ItzEmoji/nixos-dotfiles.git
cd nixos-dotfiles
sudo nixos-rebuild switch --flake .#cyril-nixos
```

Two hosts are defined in this flake:

- **`cyril-nixos`** — the primary desktop machine (Hyprland/Plasma, NVIDIA, full desktop stack).
- **`wsl`** — a minimal CLI-only environment for Windows Subsystem for Linux.

See [Hosts](/hosts/cyril-nixos) for what each one actually configures, or jump straight to the
[module reference](/modules/nixos-system) to see what every individual module sets.

## How this documentation is organized

- **[Architecture](/architecture)** — the flake-parts + `import-tree` module-registry pattern
  used throughout this repo.
- **[Hosts](/hosts/cyril-nixos)** — what each `nixosConfigurations.*` entry composes.
- **Module reference** — one page per module category (NixOS system, NixOS desktop,
  home-manager, wrappers/packages), each with the real source embedded.
- **[Reference → Options](/reference/options)** — auto-generated from any formally declared
  Nix options in this repo via [`ndg`](https://github.com/feel-co/ndg). Regenerate with
  `./scripts/gen-options.sh`.
- **[Releases](/releases)** — the project's changelog.
