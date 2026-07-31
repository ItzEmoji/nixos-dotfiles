---
title: Wrappers & Packages
sidebar_position: 4
---

import CodeBlock from '@theme/CodeBlock';
import Bat from '!!raw-loader!../../../modules/wrappers/cli/bat/bat.nix';
import WrapperOhMyPosh from '!!raw-loader!../../../modules/wrappers/cli/oh-my-posh/oh-my-posh.nix';
import Tmux from '!!raw-loader!../../../modules/wrappers/cli/tmux/tmux.nix';
import Alacritty from '!!raw-loader!../../../modules/wrappers/programs/alacritty/alacritty.nix';
import Foot from '!!raw-loader!../../../modules/wrappers/programs/foot/foot.nix';
import Kitty from '!!raw-loader!../../../modules/wrappers/programs/kitty/kitty.nix';
import Rio from '!!raw-loader!../../../modules/wrappers/programs/rio/rio.nix';
import Wezterm from '!!raw-loader!../../../modules/wrappers/programs/wezterm/wezterm.nix';
import Global from '!!raw-loader!../../../modules/packages/global.nix';
import CyrilNixos from '!!raw-loader!../../../modules/packages/cyril-nixos.nix';
import Wsl from '!!raw-loader!../../../modules/packages/wsl.nix';

# Wrappers & Packages

## Wrappers

Wrappers use [BirdeeHub/nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules)
(`inputs.wrappers`) to build a package that always launches with a fixed config
file/flags/env baked in, published under `self.packages.<system>.<name>` and
`self.wrappers.<name>` for reuse elsewhere in this repo (e.g. `zsh`'s `bat`/`tmux`
aliases in [Home Manager Modules](/modules/home-manager)).

### bat

Wraps `bat` with `--style plain --paging never --theme "Catppuccin Mocha"` baked in.

<CodeBlock language="nix" title="modules/wrappers/cli/bat/bat.nix">{Bat}</CodeBlock>

### oh-my-posh

Wraps `oh-my-posh` using the wrapper library's built-in oh-my-posh module, pointed at a
checked-in `config.toml`.

<CodeBlock language="nix" title="modules/wrappers/cli/oh-my-posh/oh-my-posh.nix">{WrapperOhMyPosh}</CodeBlock>

### tmux

Wraps `tmux` to always load a checked-in `tmux.conf` via `-f`.

<CodeBlock language="nix" title="modules/wrappers/cli/tmux/tmux.nix">{Tmux}</CodeBlock>

### alacritty

Wraps `alacritty` to always load a checked-in `alacritty.toml` via `--config-file`.

<CodeBlock language="nix" title="modules/wrappers/programs/alacritty/alacritty.nix">{Alacritty}</CodeBlock>

### foot

Wraps `foot` to always load a checked-in `foot.ini` via `--config`.

<CodeBlock language="nix" title="modules/wrappers/programs/foot/foot.nix">{Foot}</CodeBlock>

### kitty

Wraps `kitty` to always load a checked-in `kitty.conf` via `--config`.

<CodeBlock language="nix" title="modules/wrappers/programs/kitty/kitty.nix">{Kitty}</CodeBlock>

### rio

Wraps `rio`, pointing the `RIO_CONFIG_HOME` environment variable at a directory
containing a checked-in `config.toml`.

<CodeBlock language="nix" title="modules/wrappers/programs/rio/rio.nix">{Rio}</CodeBlock>

### wezterm

Wraps `wezterm` to always load a checked-in `wezterm.lua` via `--config-file`.

<CodeBlock language="nix" title="modules/wrappers/programs/wezterm/wezterm.nix">{Wezterm}</CodeBlock>

## Packages

Package lists are split by scope — `global` (every host), plus one file per host that
adds to it.

### global

System packages: `vim`, the `tmux`/`bat` wrappers, `git`, `wget`, `file`, `zsh`,
`nix-alien`; plus `programs.zsh.enable` and `programs.nix-ld.enable`. Home packages:
`btop`, the `tmux`/`bat` wrappers, `jq`, `ripgrep`, `cmatrix`, `bash`, `cava`, `pipes`,
`nil`, `nixfmt`, `nodejs`, `eza`, `gcc`, `git`, `gnumake`, `nixd`,
`lua-language-server`, `gh`, `opencode`, `gemini-cli`.

<CodeBlock language="nix" title="modules/packages/global.nix">{Global}</CodeBlock>

### cyril-nixos

Adds `nix-alien`, this repo's `rio` wrapper package, and `wireshark` system-wide
(plus enabling `programs.wireshark` and `programs.wayvnc`). Home packages: `devbox`,
`cachix`, `obs-studio`, `vesktop`, `vivaldi`.

<CodeBlock language="nix" title="modules/packages/cyril-nixos.nix">{CyrilNixos}</CodeBlock>

### wsl

Minimal system packages (`gnumake`, `gcc`, `ncurses`, `fastfetch`, the `tmux`/`bat`
wrappers); home packages are just the `tmux`/`bat` wrappers.

<CodeBlock language="nix" title="modules/packages/wsl.nix">{Wsl}</CodeBlock>
