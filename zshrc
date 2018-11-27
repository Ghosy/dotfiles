# Init ----------------------------------------------------------- {{{

autoload -Uz promptinit compinit edit-command-line
if [[ -n ${ZDOTDIR:-${HOME}}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
promptinit
# Ensure emacs keybindings are working in terminal
bindkey -e

# Mimic bash keybind to edit current command
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# ---------------------------------------------------------------- }}}
# Zplug ---------------------------------------------------------- {{{
# Zplug code is default from zplug repo on github
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
	git clone https://github.com/zplug/zplug ~/.zplug
	source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
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
		command svn "$@" | less -rMF
	else
		command svn "$@"
	fi
}

# If WSL
if [[ "$(uname -r 2> /dev/null)" =~ ".*-Microsoft" ]]; then
	# TODO: Update to use variables
	alias whome="cd /mnt/c/Users/ZMatthews/"
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

# LS_COLORS ------------------------------------------------------ {{{

LS_COLORS='no=00;38;5;244:rs=0:di=00;38;5;33:ln=00;38;5;37:mh=00:pi=48;5;230;38;5;136;01:so=48;5;230;38;5;136;01:do=48;5;230;38;5;136;01:bd=48;5;230;38;5;244;01:cd=48;5;230;38;5;244;01:or=48;5;235;38;5;160:su=48;5;160;38;5;230:sg=48;5;136;38;5;230:ca=30;41:tw=48;5;64;38;5;230:ow=48;5;235;38;5;33:st=48;5;33;38;5;230:ex=00;38;5;64:*.tar=00;38;5;61:*.tgz=00;38;5;61:*.arj=00;38;5;61:*.taz=00;38;5;61:*.lzh=00;38;5;61:*.lzma=00;38;5;61:*.tlz=00;38;5;61:*.txz=00;38;5;61:*.zip=00;38;5;61:*.z=00;38;5;61:*.Z=00;38;5;61:*.dz=00;38;5;61:*.gz=00;38;5;61:*.lz=00;38;5;61:*.xz=00;38;5;61:*.bz2=00;38;5;61:*.bz=00;38;5;61:*.tbz=00;38;5;61:*.tbz2=00;38;5;61:*.tz=00;38;5;61:*.deb=00;38;5;61:*.rpm=00;38;5;61:*.jar=00;38;5;61:*.rar=00;38;5;61:*.ace=00;38;5;61:*.zoo=00;38;5;61:*.cpio=00;38;5;61:*.7z=00;38;5;61:*.rz=00;38;5;61:*.apk=00;38;5;61:*.gem=00;38;5;61:*.jpg=00;38;5;136:*.JPG=00;38;5;136:*.jpeg=00;38;5;136:*.gif=00;38;5;136:*.bmp=00;38;5;136:*.pbm=00;38;5;136:*.pgm=00;38;5;136:*.ppm=00;38;5;136:*.tga=00;38;5;136:*.xbm=00;38;5;136:*.xpm=00;38;5;136:*.tif=00;38;5;136:*.tiff=00;38;5;136:*.png=00;38;5;136:*.PNG=00;38;5;136:*.svg=00;38;5;136:*.svgz=00;38;5;136:*.mng=00;38;5;136:*.pcx=00;38;5;136:*.dl=00;38;5;136:*.xcf=00;38;5;136:*.xwd=00;38;5;136:*.yuv=00;38;5;136:*.cgm=00;38;5;136:*.emf=00;38;5;136:*.eps=00;38;5;136:*.CR2=00;38;5;136:*.ico=00;38;5;136:*.tex=00;38;5;245:*.rdf=00;38;5;245:*.owl=00;38;5;245:*.n3=00;38;5;245:*.ttl=00;38;5;245:*.nt=00;38;5;245:*.torrent=00;38;5;245:*.xml=00;38;5;245:*Makefile=00;38;5;245:*Rakefile=00;38;5;245:*Dockerfile=00;38;5;245:*build.xml=00;38;5;245:*rc=00;38;5;245:*1=00;38;5;245:*.nfo=00;38;5;245:*README=00;38;5;245:*README.txt=00;38;5;245:*readme.txt=00;38;5;245:*.md=00;38;5;245:*README.markdown=00;38;5;245:*.ini=00;38;5;245:*.yml=00;38;5;245:*.cfg=00;38;5;245:*.conf=00;38;5;245:*.h=00;38;5;245:*.hpp=00;38;5;245:*.c=00;38;5;245:*.cpp=00;38;5;245:*.cxx=00;38;5;245:*.cc=00;38;5;245:*.objc=00;38;5;245:*.sqlite=00;38;5;245:*.go=00;38;5;245:*.sql=00;38;5;245:*.csv=00;38;5;245:*.log=00;38;5;240:*.bak=00;38;5;240:*.aux=00;38;5;240:*.lof=00;38;5;240:*.lol=00;38;5;240:*.lot=00;38;5;240:*.out=00;38;5;240:*.toc=00;38;5;240:*.bbl=00;38;5;240:*.blg=00;38;5;240:*~=00;38;5;240:*#=00;38;5;240:*.part=00;38;5;240:*.incomplete=00;38;5;240:*.swp=00;38;5;240:*.tmp=00;38;5;240:*.temp=00;38;5;240:*.o=00;38;5;240:*.pyc=00;38;5;240:*.class=00;38;5;240:*.cache=00;38;5;240:*.aac=00;38;5;166:*.au=00;38;5;166:*.flac=00;38;5;166:*.mid=00;38;5;166:*.midi=00;38;5;166:*.mka=00;38;5;166:*.mp3=00;38;5;166:*.mpc=00;38;5;166:*.ogg=00;38;5;166:*.opus=00;38;5;166:*.ra=00;38;5;166:*.wav=00;38;5;166:*.m4a=00;38;5;166:*.axa=00;38;5;166:*.oga=00;38;5;166:*.spx=00;38;5;166:*.xspf=00;38;5;166:*.mov=00;38;5;166:*.MOV=00;38;5;166:*.mpg=00;38;5;166:*.mpeg=00;38;5;166:*.m2v=00;38;5;166:*.mkv=00;38;5;166:*.ogm=00;38;5;166:*.mp4=00;38;5;166:*.m4v=00;38;5;166:*.mp4v=00;38;5;166:*.vob=00;38;5;166:*.qt=00;38;5;166:*.nuv=00;38;5;166:*.wmv=00;38;5;166:*.asf=00;38;5;166:*.rm=00;38;5;166:*.rmvb=00;38;5;166:*.flc=00;38;5;166:*.avi=00;38;5;166:*.fli=00;38;5;166:*.flv=00;38;5;166:*.gl=00;38;5;166:*.m2ts=00;38;5;166:*.divx=00;38;5;166:*.webm=00;38;5;166:*.axv=00;38;5;166:*.anx=00;38;5;166:*.ogv=00;38;5;166:*.ogx=00;38;5;166:';
export LS_COLORS

# ---------------------------------------------------------------- }}}
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
