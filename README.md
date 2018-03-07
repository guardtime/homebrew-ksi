# Welcome

This is a homebrew tap for KSI libraries and tools aimed at OSX users.

install formula like this by adding a new tap:

```
brew tap guardtime/ksi
brew install {formula_name}
```

or use this command to install formula without adding a new tap:
```
brew install Guardtime/homebrew-ksi/{formula_name}
```

### Available Formula
* ksi-tools
* libksi
* libparamset
* logksi

### Updating

Use script `rebuild_homebrew.sh` to check for updates. When new formulas are added, consult `rebuild_formulas.sh` help (call without parameters), to learn how to configure `rebuild_homebrew.sh` to check new repositories for updates. Note that `revision` must be handled manually (in most cases it is not used at all).