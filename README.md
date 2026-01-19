# .dotfiles

Here, my collection of my unix configuration files as packages, managed by `stow`. The `XDG_CONFIG_HOME` environment variable should be set to `~/.config`.

## Dependencies

- `stow`: For installing packages
- `git`: For updating submodules
- [Just](https://github.com/casey/just): For running commands

## Usage

To initialize submodules, run:
```sh
just init
```

To install all packages, run:
```sh
just install-all
```

To install a given package, run:
```sh
just install <package>
```

To uninstall a given package, run:
```sh
just uninstall <package>
```