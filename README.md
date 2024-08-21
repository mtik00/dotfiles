# dotfiles

Home directory configuration using [chezmoi](https://www.chezmoi.io/).

## New Install / Get Updates

WARNING: Some template variables require the appropriate `CHEZ_CONFIG` environment variable.

When you need to update the dotfiles, either for a new install or need to update to current changes, run the following 
command.  You can run this multiple times without issues.

### New Install

You should set `${CHEZ_CONFIG}` first:

```shell
export CHEZ_CONFIG=work-laptop
```

You won't need to do this again.  The chezmoi update process will install scrips to ensure it's current.

### Get Updates
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

NOTE: You might want to set up GitHub authentication so you're not always prompted when you `git push`.