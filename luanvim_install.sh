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
        xargs -i sh -c "sudo apt-get -y install {} || true" < "$DOTFILES_FOLDER/apt.pkglist"
        mkdir -p ~/.local
        # install neovim 0.6.1
        wget --no-check-certificate -q https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.tar.gz -O ~/.local/nvim-linux64.tar.gz
        tar -xf ~/.local/nvim-linux64.tar.gz -C ~/.local
        sudo ln -s ~/.local/nvim-linux64/bin/nvim /usr/bin/nvim
        # rust-analyzer
        if [[ ! -e  ~/.local/bin/rust-analyzer ]]; then
          mkdir -p ~/.local/bin
          wget --no-check-certificate -c -qO- https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz  | gunzip -c - > ~/.local/bin/rust-analyzer
          chmod +x ~/.local/bin/rust-analyzer
        fi
        if [[ ! -d ~/.local/bin/codelldb ]]; then
          mkdir -p ~/.local/bin/codelldb
          # wget --no-check-certificate -q https://github.com/vadimcn/vscode-lldb/releases/latest/download/codelldb-x86_64-linux.vsix -O ~/.local/bin/codelldb-x86_64-linux.vsix 
          wget --no-check-certificate -q https://github.com/vadimcn/vscode-lldb/releases/download/v1.6.10/codelldb-x86_64-linux.vsix -O ~/.local/bin/codelldb-x86_64-linux.vsix
          unzip -d ~/.local/bin/codelldb  ~/.local/bin/codelldb-x86_64-linux.vsix
          rm -rf ~/.local/bin/codelldb-x86_64-linux.vsix
        fi
        if [[ ! -e  ~/.local/bin/lazygit ]]; then
          mkdir -p ~/.local/bin
          pushd ~/.local/bin
          LAZYGIT_VERSION=$(wget -qO- "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
          wget --no-check-certificate -c -qO- https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz | tar -xzf - lazygit
          chmod +x ~/.local/bin/lazygit
          popd
        fi
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
stow neovimlua
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
#nvim --headless +PackUpdate +qall
fi
nvim --headless +PackerUpdate +qall
