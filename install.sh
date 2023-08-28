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
        # sudo add-apt-repository ppa:neovim-ppa/stable
        sudo apt-get update
        xargs sudo apt-get -y install < "$DOTFILES_FOLDER/apt.pkglist"
        # install neovim 0.6.1
        # wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim-linux64.tar.gz -O ~/.local/nvim-linux64.tar.gz
        # tar -xvf ~/.local/nvim-linux64.tar.gz -C ~/.local
        # sudo ln -s ~/.local/nvim-linux64/bin/nvim /usr/bin/nvim
    elif [ -x "$(command -v zypper)" ]; then
        xargs sudo zypper -n install < "$DOTFILES_FOLDER/zypper.pkglist"
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
stow git
stow tmux

if [[ ! -d ~/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi

if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
# install minpac
if [[ ! -d ~/.vim/pack/minpac/opt/minpac ]]; then
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
# install neovim plugins
# nvim --headless +PackUpdate +qall
fi
