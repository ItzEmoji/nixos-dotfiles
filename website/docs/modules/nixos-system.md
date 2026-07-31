---
title: NixOS — System
sidebar_position: 1
---

import CodeBlock from '@theme/CodeBlock';
import BaseSystem from '!!raw-loader!../../../modules/nixosModules/base-system.nix';
import Grub from '!!raw-loader!../../../modules/nixosModules/bootloaders/grub.nix';
import Fonts from '!!raw-loader!../../../modules/nixosModules/config/fonts.nix';
import HomeManagerConfig from '!!raw-loader!../../../modules/nixosModules/config/home-manager.nix';
import NixCache from '!!raw-loader!../../../modules/nixosModules/config/nix-cache.nix';
import Wsl from '!!raw-loader!../../../modules/nixosModules/config/wsl.nix';
import ConfigXkb from '!!raw-loader!../../../modules/nixosModules/config/xkb.nix';
import Bluetooth from '!!raw-loader!../../../modules/nixosModules/general/bluetooth.nix';
import Virtualisation from '!!raw-loader!../../../modules/nixosModules/general/virtualisation.nix';
import GeneralXkb from '!!raw-loader!../../../modules/nixosModules/general/xkb.nix';
import Nh from '!!raw-loader!../../../modules/nixosModules/programs/nh.nix';
import Audio from '!!raw-loader!../../../modules/nixosModules/services/audio.nix';
import Flatpak from '!!raw-loader!../../../modules/nixosModules/services/flatpak.nix';
import Kmscon from '!!raw-loader!../../../modules/nixosModules/services/kmscon.nix';
import Printing from '!!raw-loader!../../../modules/nixosModules/services/printing.nix';
import SshServer from '!!raw-loader!../../../modules/nixosModules/services/ssh-server.nix';
import Tailscale from '!!raw-loader!../../../modules/nixosModules/services/tailscale.nix';

# NixOS Modules — System

Core system-level `self.nixosModules.*` entries: networking, locale, boot, and services
that aren't desktop-specific.

:::info Duplicate registration
`modules/nixosModules/config/xkb.nix` and `modules/nixosModules/general/xkb.nix` both
register `flake.nixosModules.xkb` with the same content — one silently shadows the
other. Harmless today since both set the same value, but worth cleaning up.
:::

## base-system

Networking via NetworkManager, `Europe/Zurich` timezone, `en_US.UTF-8` + `C.UTF-8`
locales, `allowUnfree`, the `nix-command`/`flakes` experimental features, and
`system.stateVersion = "25.05"`.

<CodeBlock language="nix" title="modules/nixosModules/base-system.nix">{BaseSystem}</CodeBlock>

## grub

GRUB in UEFI mode (`devices = [ "nodev" ]`), `os-prober` enabled for dual-boot detection,
EFI variables writable.

<CodeBlock language="nix" title="modules/nixosModules/bootloaders/grub.nix">{Grub}</CodeBlock>

## fonts

Installs the JetBrains Mono Nerd Font system-wide.

<CodeBlock language="nix" title="modules/nixosModules/config/fonts.nix">{Fonts}</CodeBlock>

## home-manager (NixOS side)

Imports the home-manager NixOS module and wires `useGlobalPkgs`/`useUserPackages`, a
`.backup` extension for files home-manager would otherwise refuse to overwrite, and
passes `inputs`/`self` through as `extraSpecialArgs`.

<CodeBlock language="nix" title="modules/nixosModules/config/home-manager.nix">{HomeManagerConfig}</CodeBlock>

## nix-cache

Adds `packages.itzemoji.com` — this project's own binary cache — as a substituter,
with its trusted public key.

<CodeBlock language="nix" title="modules/nixosModules/config/nix-cache.nix">{NixCache}</CodeBlock>

## wsl (config)

Imports [nixos-wsl](https://github.com/nix-community/NixOS-WSL), enables WSL
integration (default user `cyril`, interop registration, Docker Desktop passthrough),
`aarch64-linux` emulation, and sets `zsh` as the login shell.

<CodeBlock language="nix" title="modules/nixosModules/config/wsl.nix">{Wsl}</CodeBlock>

## xkb

Sets the Swiss (`ch`) keyboard layout for the X server. Declared twice (see the note
above) — shown here is `config/xkb.nix`; `general/xkb.nix` is functionally identical.

<CodeBlock language="nix" title="modules/nixosModules/config/xkb.nix">{ConfigXkb}</CodeBlock>
<CodeBlock language="nix" title="modules/nixosModules/general/xkb.nix">{GeneralXkb}</CodeBlock>

## bluetooth

Enables Bluetooth hardware support and the `blueman` applet/service.

<CodeBlock language="nix" title="modules/nixosModules/general/bluetooth.nix">{Bluetooth}</CodeBlock>

## virtualisation

`libvirtd`, the `virt-manager` GUI, QEMU guest services, and `spice-vdagentd` for VM
clipboard/display integration.

<CodeBlock language="nix" title="modules/nixosModules/general/virtualisation.nix">{Virtualisation}</CodeBlock>

## nh

Enables [`nh`](https://github.com/nix-community/nh) (a friendlier NixOS/home-manager
CLI), auto garbage-collection cleanup, pointed at `~/dotfiles` as the flake.

<CodeBlock language="nix" title="modules/nixosModules/programs/nh.nix">{Nh}</CodeBlock>

## audio

Enables PulseAudio; explicitly disables PipeWire.

<CodeBlock language="nix" title="modules/nixosModules/services/audio.nix">{Audio}</CodeBlock>

## flatpak

Enables the Flatpak service.

<CodeBlock language="nix" title="modules/nixosModules/services/flatpak.nix">{Flatpak}</CodeBlock>

## kmscon

A KMS-based virtual console (replaces the Linux VT), hardware-accelerated, reusing the
system's X keyboard configuration.

<CodeBlock language="nix" title="modules/nixosModules/services/kmscon.nix">{Kmscon}</CodeBlock>

## printing

Enables CUPS printing.

<CodeBlock language="nix" title="modules/nixosModules/services/printing.nix">{Printing}</CodeBlock>

## ssh-server

Enables OpenSSH; disables password authentication (key-only).

<CodeBlock language="nix" title="modules/nixosModules/services/ssh-server.nix">{SshServer}</CodeBlock>

## tailscale

Enables the Tailscale VPN service.

<CodeBlock language="nix" title="modules/nixosModules/services/tailscale.nix">{Tailscale}</CodeBlock>
