#!/bin/bash

DOTFILES_FOLDER=$(dirname $(readlink -f "$0"))

so() {
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     MACHINE=linux;;
        Darwin*)    MACHINE=mac;;
        *)          MACHINE="UNKNOWN:${unameOut}"
    esac

    echo "$MACHINE"
}

#
# Install packages
# ==============================================================================================================================
#
if [ `so` = "linux" ]; then
    if [ -x "$(command -v pacman)" ]; then
        xargs -0 -n 1 sudo pacman -Syu --noconfirm < <(tr \\n \\0 <"$DOTFILES_FOLDER/pacman.pkglist")
    elif [ -x "$(command -v apt)" ]; then
        xargs sudo apt-get -y install < "$DOTFILES_FOLDER/apt.pkglist"
    fi
# todo snap
#    if [ -x "$(command -v snap)" ]; then
#        xargs -0 -n 1 sudo snap install < <(tr \\n \\0 <"$DOTFILES_FOLDER/snap.pkglist")
#    fi
elif [ `so` = "mac" ]; then
    xargs brew install < "$DOTFILES_FOLDER/brew.pkglist"
fi

#
# Install shell configuration
# ==============================================================================================================================
#
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

stow zinit
stow vim
if [[ ! -d ~/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

# install minpac
if [[ ! -d ~/.vim/pack/minpac/opt/minpac ]]; then
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
# install neovim plugins
nvim --headless +PackUpdate +qall
fi
