export EDITOR="VIM"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx vt1
fi
