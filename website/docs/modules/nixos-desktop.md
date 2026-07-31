---
title: NixOS — Desktop
sidebar_position: 2
---

import CodeBlock from '@theme/CodeBlock';
import Hyprland from '!!raw-loader!../../../modules/nixosModules/gui/desktops/hyprland.nix';
import Plasma from '!!raw-loader!../../../modules/nixosModules/gui/desktops/plasma.nix';
import Ly from '!!raw-loader!../../../modules/nixosModules/gui/displaymanagers/ly.nix';
import Stylix from '!!raw-loader!../../../modules/nixosModules/gui/stylix/stylix.nix';
import Xserver from '!!raw-loader!../../../modules/nixosModules/gui/xserver.nix';
import BaseVideoDrivers from '!!raw-loader!../../../modules/nixosModules/videoDrivers/base-videoDrivers.nix';
import Nvidia from '!!raw-loader!../../../modules/nixosModules/videoDrivers/nvidia.nix';

# NixOS Modules — Desktop

Desktop environment, display manager, theming, and video-driver `self.nixosModules.*`
entries. These are all system-level enable switches — the actual window-manager/user
config lives in the matching home-manager module (see
[Home Manager Modules](/modules/home-manager)).

## hyprland

Enables the Hyprland Wayland compositor at the system level.

<CodeBlock language="nix" title="modules/nixosModules/gui/desktops/hyprland.nix">{Hyprland}</CodeBlock>

## plasma

Enables the KDE Plasma 6 desktop manager.

<CodeBlock language="nix" title="modules/nixosModules/gui/desktops/plasma.nix">{Plasma}</CodeBlock>

## ly

Enables the `ly` TUI display/login manager, with X11 session support.

<CodeBlock language="nix" title="modules/nixosModules/gui/displaymanagers/ly.nix">{Ly}</CodeBlock>

## stylix (system-wide)

Imports [Stylix](https://github.com/nix-community/stylix) and sets the Catppuccin Mocha
base16 color scheme. `autoEnable = false` — theming is opt-in per target rather than
applied to everything automatically.

<CodeBlock language="nix" title="modules/nixosModules/gui/stylix/stylix.nix">{Stylix}</CodeBlock>

## xserver

Enables the X server and tunes key auto-repeat delay/interval.

<CodeBlock language="nix" title="modules/nixosModules/gui/xserver.nix">{Xserver}</CodeBlock>

## base-videoDrivers

Enables generic graphics acceleration (`hardware.graphics.enable`).

<CodeBlock language="nix" title="modules/nixosModules/videoDrivers/base-videoDrivers.nix">{BaseVideoDrivers}</CodeBlock>

## nvidia

NVIDIA driver with kernel modesetting, the open-source kernel module variant, the
`nvidia-settings` GUI, and sets `nvidia` as the active X video driver.

<CodeBlock language="nix" title="modules/nixosModules/videoDrivers/nvidia.nix">{Nvidia}</CodeBlock>
