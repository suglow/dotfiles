# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
	mkdir ~/.zinit
	git clone https://gitee.com/suglow006/zinit.git ~/.zinit/bin
fi

export NVM_DIR=${HOME}/.nvm
export NVM_COMPLETION=true
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
export EDITOR=nvim
# load zinit
source ~/.zinit/bin/zinit.zsh
# 快速目录跳转
zinit ice lucid wait='1' # lucid ice 可以隐藏Turbo mode下插件加载完成的提示
# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
# 补全
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/directories.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
# zinit snippet OMZ::plugins/git-flow/git-flow.plugin.zsh
# zinit snippet OMZ::plugins/mvn/mvn.plugin.zsh
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
zinit snippet OMZ::plugins/tmuxinator/tmuxinator.plugin.zsh
zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
# zinit snippet OMZ::plugins/pip/pip.plugin.zsh

##
# Plugins
##
zinit ice silent wait"0"
zinit snippet OMZ::plugins/history/history.plugin.zsh

zinit ice silent wait"0"
zinit snippet OMZ::plugins/per-directory-history/per-directory-history.zsh


zinit ice silent wait"0" pick"zsh-history-substring-search.zsh"
zinit load "zsh-users/zsh-history-substring-search"

##
# Configuration
##
if [ ! -z ${WORKSPACE} ];then
  HISTFILE="${WORKSPACE}/.zsh_history"
else
  HISTFILE="$HOME/.zsh_history"
fi

if [ ! -z ${HISTFILEPATH} ];then
  HISTFILE="${HISTFILEPATH}"
fi
HISTORY_BASE="$(dirname ${HISTFILE})/.directory_history"
HISTSIZE=10000000
SAVEHIST=10000000

HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd..:zh"
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_VI_VISUAL_ESCAPE_BINDKEY=jk
ZVM_VI_OPPEND_ESCAPE_BINDKEY=jk
# Treat the '!' character specially during expansion.
setopt BANG_HIST

# Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY

# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY

# Share history between all sessions.
setopt NO_SHARE_HISTORY

# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST

# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS

# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS

# Do not display a line previously found.
setopt HIST_FIND_NO_DUPS

# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE

# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS

# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS

# Don't execute immediately upon history expansion.
setopt HIST_VERIFY


zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Gitignore plugin – commands gii and gi
zinit ice wait"2" lucid
zinit load voronkovich/gitignore.plugin.zsh

zinit load lukechilds/zsh-nvm
# vi模式
# zinit snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh
# 加载主题
zinit ice depth=1
zinit light romkatv/powerlevel10k
export BAT_THEME="gruvbox-dark"

# autoload -z edit-command-line
# zle -N edit-command-line
# bindkey "^X^E" edit-command-line

[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ ! -x "$(command -v node)" ]; then
    nvm install v16.13.1
    nvm use v16.13.1
    nvm alias default v16.13.1
    npm config set registry http://registry.npm.taobao.org
fi


zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
function zvm_after_lazy_keybindings() {
  zvm_bindkey vicmd 'j' up-line
  zvm_bindkey vicmd 'k' down-line
  zvm_bindkey vicmd '^R' fzf-history-widget
  zvm_bindkey viins '^R' fzf-history-widget
  zvm_bindkey viins '^b' vi-first-non-blank 
  zvm_bindkey viins '^e' vi-end-of-line 
}
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH
[ -f $HOME/.gvm/scripts/gvm ] && source $HOME/.gvm/scripts/gvm 

# Alias
# use neovim instead of vim
alias vim='nvim'
# utf-8 tmux
alias tmux='tmux -u'
# cat -> bat
alias cat='bat'
