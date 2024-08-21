# dotfiles

Home directory configuration using [chezmoi](https://www.chezmoi.io/).

## New Install

Run this command:

```shell
curl -Ls https://raw.githubusercontent.com/mtik00/dotfiles/main/setup.sh > /tmp/setup.sh \
    && bash /tmp/setup.sh
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