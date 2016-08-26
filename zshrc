autoload -U compinit promptinit
compinit
promptinit

# Zplug code is default from zplug repo on github

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

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

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';

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

zle -N zle-keymap-select
export KEYTIMEOUT=1
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

# History length
SAVEHIST=10000
HISTSIZE=10000

# Non-case sensitive globbing
setopt NO_CASE_GLOB
# Better globbing
setopt EXTENDED_GLOB
# Don't overwrite history append
setopt APPEND_HISTORY
# Don't record same command repeated directly after another
setopt HIST_IGNORE_DUPS

PATH="/home/ghosy/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/ghosy/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/ghosy/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/ghosy/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ghosy/perl5"; export PERL_MM_OPT;
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Ensure emacs keybindings are working in terminal
bindkey -e
