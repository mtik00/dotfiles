# dotfiles

Home directory configuration using [chezmoi](https://www.chezmoi.io/).

## New Install / Get Updates

When you need to update the dotfiles, either for a new install or need to update to current changes, run the following 
command.  You can run this multiple times without issues.

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