---
title: Home Manager
sidebar_position: 3
---

import CodeBlock from '@theme/CodeBlock';
import Base from '!!raw-loader!../../../modules/homeManagerModules/base.nix';
import Atuin from '!!raw-loader!../../../modules/homeManagerModules/cli/atuin/atuin.nix';
import Fastfetch from '!!raw-loader!../../../modules/homeManagerModules/cli/fastfetch/fastfetch.nix';
import Fzf from '!!raw-loader!../../../modules/homeManagerModules/cli/fzf/fzf.nix';
import OhMyPosh from '!!raw-loader!../../../modules/homeManagerModules/cli/oh-my-posh/oh-my-posh.nix';
import Zoxide from '!!raw-loader!../../../modules/homeManagerModules/cli/zoxide/zoxide.nix';
import Zsh from '!!raw-loader!../../../modules/homeManagerModules/cli/zsh/zsh.nix';
import Dunst from '!!raw-loader!../../../modules/homeManagerModules/gui/dunst/dunst.nix';
import Flameshot from '!!raw-loader!../../../modules/homeManagerModules/gui/flameshot/flameshot.nix';
import Hypr from '!!raw-loader!../../../modules/homeManagerModules/gui/hypr/hypr.nix';
import Mango from '!!raw-loader!../../../modules/homeManagerModules/gui/mango/mango.nix';
import Noctalia from '!!raw-loader!../../../modules/homeManagerModules/gui/noctalia/noctalia.nix';
import Quickshell from '!!raw-loader!../../../modules/homeManagerModules/gui/quickshell/quickshell.nix';
import Rofi from '!!raw-loader!../../../modules/homeManagerModules/gui/rofi/rofi.nix';
import StylixHm from '!!raw-loader!../../../modules/homeManagerModules/gui/stylix/stylix-hm.nix';
import Waybar from '!!raw-loader!../../../modules/homeManagerModules/gui/waybar/waybar.nix';
import SshAgent from '!!raw-loader!../../../modules/homeManagerModules/services/ssh-agent.nix';

# Home Manager Modules

`self.homeManagerModules.*` entries — per-user configuration and dotfiles.

:::info Duplicate registration
`modules/homeManagerModules/base.nix` also registers `flake.nixosModules.home-manager`,
alongside [NixOS — System](/modules/nixos-system)'s
`modules/nixosModules/config/home-manager.nix` — but the two are **not** identical:
the `config/home-manager.nix` version additionally imports the upstream
`inputs.home-manager.nixosModules.home-manager` module and passes `self` through
`extraSpecialArgs`, while the `base.nix` version does neither. Don't remove one
assuming it's a safe-to-delete duplicate.
:::

## home (base)

Sets `home.username`/`home.homeDirectory` defaults to `cyril`, `home.stateVersion =
"25.05"`, and `en_US.UTF-8` session locale variables. Every host's user config starts
from this module.

<CodeBlock language="nix" title="modules/homeManagerModules/base.nix">{Base}</CodeBlock>

## atuin

Shell history sync/search, with zsh integration; settings are loaded from a checked-in
`config.toml`.

<CodeBlock language="nix" title="modules/homeManagerModules/cli/atuin/atuin.nix">{Atuin}</CodeBlock>

## fastfetch

System-info fetch tool — installs its `config.jsonc` and the package.

<CodeBlock language="nix" title="modules/homeManagerModules/cli/fastfetch/fastfetch.nix">{Fastfetch}</CodeBlock>

## fzf

Fuzzy finder; the `historyWidget` binding is deliberately disabled (freeing that key
for Atuin).

<CodeBlock language="nix" title="modules/homeManagerModules/cli/fzf/fzf.nix">{Fzf}</CodeBlock>

## oh-my-posh

Shell prompt theming, using this repo's own wrapped `oh-my-posh` package — see
[Wrappers & Packages](/modules/wrappers-and-packages).

<CodeBlock language="nix" title="modules/homeManagerModules/cli/oh-my-posh/oh-my-posh.nix">{OhMyPosh}</CodeBlock>

## zoxide

A smarter `cd`, with zsh integration.

<CodeBlock language="nix" title="modules/homeManagerModules/cli/zoxide/zoxide.nix">{Zoxide}</CodeBlock>

## zsh

The main shell: `zinit`, `eza`, `unimatrix`, `gh`, and `fastfetch` packages; aliases
like `vim → nvim` and `nrs → nh os switch ~/dotfiles/ -H cyril-nixos`; `EDITOR=nvim`;
the `fzf-tab` and `zsh-autosuggestions` plugins; `nix-index` and `dircolors`; and custom
keybindings (emacs mode, `Ctrl+P`/`Ctrl+N` history search) with `bat`/`eza`-powered
fzf-tab previews.

<CodeBlock language="nix" title="modules/homeManagerModules/cli/zsh/zsh.nix">{Zsh}</CodeBlock>

## dunst

Notification daemon — ships a config directory and the package.

<CodeBlock language="nix" title="modules/homeManagerModules/gui/dunst/dunst.nix">{Dunst}</CodeBlock>

## flameshot

Screenshot tool run as a user service; tray icon disabled, startup message suppressed.

<CodeBlock language="nix" title="modules/homeManagerModules/gui/flameshot/flameshot.nix">{Flameshot}</CodeBlock>

## hypr

Ships the actual Hyprland user configuration (Lua config + a `conf` directory) as
dotfiles — this is the real window-manager config, distinct from
`nixosModules.hyprland` (see [NixOS — Desktop](/modules/nixos-desktop)) which only
flips the system-level enable switch.

<CodeBlock language="nix" title="modules/homeManagerModules/gui/hypr/hypr.nix">{Hypr}</CodeBlock>

## mango

Ships a `mango` config directory as dotfiles.

<CodeBlock language="nix" title="modules/homeManagerModules/gui/mango/mango.nix">{Mango}</CodeBlock>

## noctalia

Imports and enables the [Noctalia](https://github.com/noctalia-dev/noctalia) Wayland
shell/bar, and ships its config directory.

<CodeBlock language="nix" title="modules/homeManagerModules/gui/noctalia/noctalia.nix">{Noctalia}</CodeBlock>

## quickshell

Installs the `quickshell` package only.

<CodeBlock language="nix" title="modules/homeManagerModules/gui/quickshell/quickshell.nix">{Quickshell}</CodeBlock>

## rofi

Application launcher — extensive `extraConfig` (modes, keybindings, window formatting)
plus a fully hand-rolled `.rasi` theme inlined in Nix.

<CodeBlock language="nix" title="modules/homeManagerModules/gui/rofi/rofi.nix">{Rofi}</CodeBlock>

## stylix (home-manager)

Per-user theming: Catppuccin Mocha, the Bibata-Modern-Ice cursor theme at size 24,
`autoEnable = false` (opt-in per target).

<CodeBlock language="nix" title="modules/homeManagerModules/gui/stylix/stylix-hm.nix">{StylixHm}</CodeBlock>

## waybar

Status bar — ships a config directory and installs the package.

<CodeBlock language="nix" title="modules/homeManagerModules/gui/waybar/waybar.nix">{Waybar}</CodeBlock>

## ssh-agent

Enables the home-manager-managed `ssh-agent` service.

<CodeBlock language="nix" title="modules/homeManagerModules/services/ssh-agent.nix">{SshAgent}</CodeBlock>
