---
title: cyril-nixos
---

import CodeBlock from '@theme/CodeBlock';
import HostConfig from '!!raw-loader!../../../modules/hosts/cyril-nixos/configuration.nix';
import UserConfig from '!!raw-loader!../../../modules/hosts/cyril-nixos/user-cyril.nix';

# Host: cyril-nixos

The primary desktop machine — full Hyprland/Plasma desktop stack, NVIDIA graphics, GRUB.

## NixOS modules composed

<CodeBlock language="nix" title="modules/hosts/cyril-nixos/configuration.nix">{HostConfig}</CodeBlock>

## User & home-manager modules

`cyril-nixos-user-cyril` creates the `cyril` user and lists every home-manager module
that gets applied for this host — including the full desktop stack (Hyprland config,
Noctalia shell, Rofi, notifications, screenshots) plus the external
[spicetify-nix](https://github.com/Gerg-L/spicetify-nix) module:

<CodeBlock language="nix" title="modules/hosts/cyril-nixos/user-cyril.nix">{UserConfig}</CodeBlock>
