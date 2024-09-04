# dotfiles

Home directory configuration using [chezmoi](https://www.chezmoi.io/).

## New Install / Get Updates

When you need to update the dotfiles, either for a new install or need to update to current changes, run the following 
command.  You can run this multiple times without issues.

### New Install / Get Updates

```shell
bash <(curl -s https://raw.githubusercontent.com/mtik00/dotfiles/main/setup.sh)
```

NOTE: For normal updates, you can also just use this (also aliased as `cu`):

```shell
chezmoi update
```

## Manage home files

Use chezmoi to add/edit files.

```shell
chezmoi add <some home file or directory>
chezmoi cd
git add .
git commit -am'feat: adding files'
git push
```

NOTE: You might want to set up GitHub authentication so you're not always prompted when you `git push`.

## General Guidance

- ENV vars should be exported in `.zshenv` (except `${PATH}`, which should be in `.zshrc`)
- source code should be cloned into `~/.local/share` 