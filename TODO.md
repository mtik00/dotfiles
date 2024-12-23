# Things left to do

## Update applications

How do I update the applications that get installed?

For now, I just delete the binary and run `bash dotfiles/.installers/<application>.sh`

I'd like to do something like:

```shell
source $(chezmoi execute-template -i < dotfiles/run_onchange_10-install-apps.sh.tmpl)
```

but that doesn't quite work.
