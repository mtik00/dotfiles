# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository managed by **chezmoi**. Supports Debian-based and Arch-based (CachyOS) Linux distributions with "work-laptop" and "personal" configuration profiles.

## Key Commands

```bash
# Bootstrap on a new machine
bash <(curl -s https://raw.githubusercontent.com/mtik00/dotfiles/main/setup.sh)

# Update dotfiles from remote
chezmoi update    # aliased as 'cu'

# Apply local changes
chezmoi apply

# Preview what chezmoi would change
chezmoi diff

# Add a new file to be managed
chezmoi add <file>

# Typical workflow for committing changes
chezmoi cd && git add . && git commit -am 'feat: description' && git push
```

There are no build, test, or lint commands — this is a configuration repository.

## Architecture

### Chezmoi Source Directory

All managed files live under `dotfiles/` (set via `.chezmoiroot`). Chezmoi naming conventions:

- `dot_` prefix → `.filename` in `$HOME`
- `private_` prefix → restrictive permissions (600/700)
- `executable_` prefix → makes file executable
- `.tmpl` suffix → Go template, processed with chezmoi data
- `run_onchange_*.sh` → scripts that re-run when their content changes

### Installation Script Ordering

Scripts in `dotfiles/` run sequentially by numeric prefix during `chezmoi apply`:

1. `00-install-packages` — system packages (from `.chezmoidata/packages.yaml`)
2. `10-install-apps` — additional apps (uv, starship, fzf, etc.)
3. `20-configure-zsh` — set zsh as default shell
4. `30-configure-ssh` — SSH config (work-laptop only)
5. `40-configure-git` — git config for personal projects

### Modular Environment Loading

`.zshenv` sources every file in `~/.env-files.d/` (mapped from `dotfiles/dot_env-files.d/`). This directory contains modular config for aliases, functions, git, GPG, and SSH. `PATH` modifications go in `.zshrc`; all other exports go in `.zshenv`.

### OS-Specific Package Data

`dotfiles/.chezmoidata/packages.yaml` defines package lists per OS. Templates in `.tmpl` files use `{{ .chezmoi.osRelease.id }}` (or similar) to branch on OS.

### Custom Scripts

`dotfiles/bin/` contains utility scripts (AWS STS, container runners, git helpers, password generators). Shared logging lives in `bin/lib/logger.sh`.
