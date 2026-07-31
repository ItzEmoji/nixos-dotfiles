---
title: wsl
---

import CodeBlock from '@theme/CodeBlock';
import HostConfig from '!!raw-loader!../../../modules/hosts/wsl/configuration.nix';
import UserConfig from '!!raw-loader!../../../modules/hosts/wsl/user-cyril.nix';

# Host: wsl

A minimal, CLI-only environment for Windows Subsystem for Linux — no desktop, no GUI
modules, just shell tooling.

## NixOS modules composed

<CodeBlock language="nix" title="modules/hosts/wsl/configuration.nix">{HostConfig}</CodeBlock>

## User & home-manager modules

`wsl-cyril` intentionally imports only CLI home-manager modules (shell, prompt, fuzzy
finder, history) — no desktop/GUI modules are pulled in for this host:

<CodeBlock language="nix" title="modules/hosts/wsl/user-cyril.nix">{UserConfig}</CodeBlock>
