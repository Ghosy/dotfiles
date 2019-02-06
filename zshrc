# Init ----------------------------------------------------------- {{{

autoload -Uz promptinit compinit edit-command-line
compinit; promptinit
# Ensure emacs keybindings are working in terminal
bindkey -e

# Mimic bash keybind to edit current command
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# ---------------------------------------------------------------- }}}
# Zplug ---------------------------------------------------------- {{{
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
	git clone https://github.com/zplug/zplug ~/.zplug
	source ~/.zplug/init.zsh && zplug update --self
fi

# Essential for zplug
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "junegunn/fzf", use:"shell/key-bindings.zsh"

# Install packages that have not been installed yet
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	else
		echo
	fi
fi

zplug load

# ---------------------------------------------------------------- }}}
# Env ------------------------------------------------------------ {{{

# Set default pager to less
export PAGER="less"
# Assign parameters to less
export LESS="-isM"
# Set default editor to vim if it exists
if hash vim 2>/dev/null; then
	export EDITOR="vim"
else
	export EDITOR="vi"
fi

# Less info
export LESSHISTFILE="/dev/null"

# History length
SAVEHIST=10000
HISTSIZE=10000

PATH="/home/ghosy/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/ghosy/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/ghosy/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/ghosy/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ghosy/perl5"; export PERL_MM_OPT;
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# If WSL
if [[ "$(uname -r 2> /dev/null)" =~ ".*-Microsoft" ]]; then
	whome=$(wslpath -u $(cmd.exe /c "echo %USERPROFILE%"))
	WHOME=${whome//$'\r'}
fi

# Directory colors
if [ -f $HOME/.dir_colors ]; then
	eval $(dircolors $HOME/.dir_colors)
fi

# ---------------------------------------------------------------- }}}
# Aliases -------------------------------------------------------- {{{

alias ssh="TERM=screen-256color ssh"

alias irc-vpn="ssh ghosy@ghosy.net -t tmux a -t irc"

alias -g L="| less -rM"
alias -g G="| grep -E --color=auto"
alias -g DING="&& play -qn synth .2 pluck C3 repeat vol .5 || play -qn synth .2 pluck C2 repeat vol .5"

if hash aura 2>/dev/null; then
	alias auras="\sudo aura -S"
	alias auraa="\sudo aura -A"
	alias aurar="\sudo aura -R"
	alias aurasyu="\sudo aura -Syu"
	alias auraayu="\sudo aura -Ayu"
	alias auraqi="aura -Qi"
fi

alias s="\sudo "
alias ss='\sudo $(fc -ln -1)'

if hash vim 2>/dev/null; then
	alias v="\vim"
	alias sv="\sudo -E =vim"
else
	alias v="\vi"
	alias sv"\sudo -E =vi"
fi

alias eu="cd .."
alias a="=ls -pF --color"
alias aa="\ls -pFA --color"
alias au="\ls -pFlh --color"
alias aua="\ls -pFAlh --color"

if hash vifm 2>/dev/null; then
	alias o="\vifm"
fi

svn() {
	if [ "$1" = diff ]; then
		shift
		set -- diff --diff-cmd colordiff "$@"
		command svn "$@" | less -rM
	else
		command svn "$@"
	fi
}

# If WSL
if [[ "$(uname -r 2> /dev/null)" =~ ".*-Microsoft" ]]; then
	alias whome="cd $WHOME"
fi

# ---------------------------------------------------------------- }}}
# Zsh Settings --------------------------------------------------- {{{

zle -N zle-keymap-select
export KEYTIMEOUT=1
# Non-case sensitive globbing
setopt NO_CASE_GLOB
# Better globbing
setopt EXTENDED_GLOB
# Don't overwrite history append
setopt APPEND_HISTORY
# Don't record same command repeated directly after another
setopt HIST_IGNORE_DUPS
# Allow substitutions in prompt
setopt PROMPT_SUBST

# ---------------------------------------------------------------- }}}
# Prompt --------------------------------------------------------- {{{

PROMPT='$(ssh_check)%m%# '
RPROMPT='$(git_behind_origin)$(git_ahead_origin)$(git_uncommited)$(git_branch)'

# Check that the current dir is in a git repo
git_check() {
	if ! git rev-parse --git-dir > /dev/null 2>&1; then
		exit 0;
	fi
}

# Output the current branch
git_branch() {
	git_check
	git branch 2>/dev/null | awk '/^*/ {print $2}'
}

# Output a character if there are uncommited changes
git_uncommited() {
	git_check
	if [ ! -z "$(git status --untracked-files=no --porcelain 2>/dev/null)" ]; then
		echo -e "\u00B1"
	fi
}

git_ahead_origin() {
	git_check
	if [ "$(git rev-list origin..HEAD 2>/dev/null | wc -l)" -gt 0 ]; then
		echo -e "\u2192$(git rev-list origin..HEAD 2>/dev/null | wc -l) "
	fi
}

git_behind_origin() {
	git_check
	if [ "$(git rev-list HEAD..origin 2>/dev/null | wc -l)" -gt 0 ]; then
		echo -e "\u2190$(git rev-list HEAD..origin 2>/dev/null | wc -l) "
	fi
}

ssh_check()
	if [[ -n $SSH_CONNECTION ]]; then
		echo "\u21CC "
	fi

# ---------------------------------------------------------------- }}}
