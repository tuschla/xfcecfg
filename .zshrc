# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export SHELL=/bin/zsh
source ~/antigen.zsh

export EDITOR=/bin/nvim
export PATH="/home/lt/.local/bin:$PATH"

antigen use oh-my-zsh
antigen bundle docker
antigen bundle docker-compose
antigen bundle archlinux
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle asdf
antigen bundle bundler
antigen bundle docker
antigen bundle jsontools
antigen bundle vscode
antigen bundle web-search
antigen bundle k
antigen bundle tig
antigen bundle git
antigen bundle colored-man-pages
antigen bundle colorize
antigen bundle command-not-found
antigen bundle cp
antigen bundle dirhistory
antigen bundle sudo
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle fantasque-sans
antigen theme romkatv/powerlevel10k

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

antigen apply

source ~/.oh-my-zsh/oh-my-zsh.sh

# Ctrl-O opens zsh at the current location, and on exit, cd into ranger's last location.
ranger-cd() {
	tempfile=$(mktemp)
	ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
	test -f "$tempfile" &&
	if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
	cd -- "$(cat "$tempfile")"
	fi
	rm -f -- "$tempfile"
	# hacky way of transferring over previous command and updating the screen
	VISUAL=true zle edit-command-line
}
zle -N ranger-cd
bindkey '^o' ranger-cd

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source ~/.oh-my-zsh/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# alias for kittens
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"
alias diff="kitty +kitten diff"
alias kssh="kitty +kitten ssh"

alias vi="nvim"
alias vim="nvim"
alias gitv="git log --graph --decorate --oneline"

alias t="sdcv -n --utf8-output --color "$@" 2>&1 | \
  fold --width=$(tput cols) | \
  less -FRX"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
