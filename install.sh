# install nx
cat <<EOF >~/.config/nix/nix.conf
substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/
EOF

#curl -L https://nixos.org/nix/install | sh
curl -L https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install | sh

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.antibody \
	nixpkgs.git \
	nixpkgs.neovim \
	nixpkgs.tmux \
	nixpkgs.stow \
	nixpkgs.yarn \
	nixpkgs.fzf \
	nixpkgs.ripgrep \
	nixpkgs.bat \
	nixpkgs.gnumake \
	nixpkgs.gcc \
	nixpkgs.direnv

stow git
stow vim
stow tmux
stow zsh

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
# install minpac
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
# install neovim plugins
nvim --headless +PackUpdate +qall

# Use kitty terminal on MacOS
[ `uname -s` = 'Darwin' ] && stow kitty
