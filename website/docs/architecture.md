---
id: architecture
sidebar_position: 2
title: Architecture
---

import CodeBlock from '@theme/CodeBlock';
import FlakeNix from '!!raw-loader!../../flake.nix';
import TailscaleModule from '!!raw-loader!../../modules/nixosModules/services/tailscale.nix';

# Architecture

## flake-parts + import-tree

This flake doesn't list its modules by hand. `flake.nix` hands its entire `./modules`
directory to [`import-tree`](https://github.com/vic/import-tree), which recursively
finds and imports every `.nix` file under it as a [flake-parts](https://flake.parts/)
module:

<CodeBlock language="nix" title="flake.nix">{FlakeNix}</CodeBlock>

That's the entire top-level wiring — every module described in this documentation
site is discovered this way; there is no central list to keep in sync.

## The module registry convention

Instead of writing NixOS/home-manager configuration inline in a host's config, almost
every module in this repo publishes itself into one of two registries:

- `flake.nixosModules.<name>` — a NixOS module, later consumed as `self.nixosModules.<name>`.
  This option is provided by flake-parts itself upstream; this repo doesn't declare it, it
  just uses it by convention.
- `flake.homeManagerModules.<name>` — a home-manager module, consumed as
  `self.homeManagerModules.<name>`. Unlike the above, this one **is** an option this repo
  declares itself, in `modules/options.nix` — which is also why
  [Reference → Options](/reference/options) only lists a single option.

A minimal example — this is the *entire* file that enables Tailscale on any host that
imports it:

<CodeBlock language="nix" title="modules/nixosModules/services/tailscale.nix">{TailscaleModule}</CodeBlock>

Most modules in this repo look exactly like this: a name registered into the registry,
and a config block that sets a handful of upstream NixOS or home-manager options
directly — there's very little custom option-declaring (`mkOption`/`mkEnableOption`)
in this repo. See [Reference → Options](/reference/options) for the few places that
do declare real options.

## Composing a host

A host (`modules/hosts/<name>/configuration.nix`) is just a list of
`self.nixosModules.*` entries passed to `nixpkgs.lib.nixosSystem`. See
[Hosts](/hosts/cyril-nixos) for the full list per host.
