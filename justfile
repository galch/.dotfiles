init:
    git submodule update --init --merge

install package:
    stow {{ package }}

install-all:
    stow */

uninstall package:
    stow -D {{ package }}
