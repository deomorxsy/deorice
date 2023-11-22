#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#Keyboard setting for bash terminals
setxkbmap -model thinkpad -layout br -variant abnt2

#echo "setxkbmap -model thinkpad -layout br -variant abnt2" >> ~/.bashrc

#export PATH="$PATH:$HOME/.local/bin"
PS1="; "

#opening programs with dmenu (SHELL ALIAS)
#export discord="$HOME/Downloads/messengers/discord/Discord/Discord"
export digital_hneemann="$HOME/Downloads/other-tools/science/digital-logic/Digital/Digital.sh"

#display images
alias icat="kitty icat --align=left"
alias isvg="rsvg-convert | icat"

#xsetroot-configs
#while true; do
    #xsetroot -name "$(date)"
    #sleep 1m #time update every minute
#done &

function git_tably () {
	unset branch_all graph_all hash_all message_all time_all max_chars

	### add here the same code as under "2) as a shell-script" ###


}



colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" "\e[${value};...;${value}m"
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# fore
ground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf '%sTEXT\e[m' "${seq0}"
            printf '\e[%s1mBOLD\e[m' "${vals:+;}"
		done
		echo; echo
	done
}


# gh secrets
EXT=$EXT_BASHRC
[[ -f ${EXT}.extend.bashrc ]] && . ${EXT}.extend.bashrc

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# less/man color

export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
export LESS_TERMCAP_ue=$'\e[0m'


# Using vim as a syntax-highlighting pager with LESS
alias vmore="vim -u ~/.vimrc.more -"


##Frequent Files
#alias clstext="zathura $HOME/Documentos/coding/projetos/rscripts/bib-packrat/exercises/framework/texto/comparativo.pdf &"
#alias pbt="$HOME/Documentos/coding/projetos/rscripts/bib-packrat/exercises/framework/texto/"

# Vi/Vim Mode
set -o vi
## CLEAR screen control with vi/vim
bind -m vi-insert 'Control-l: clear-screen'

# Rust
alias rustlings="~/.cargo/bin/rustlings"

# todo list
#export TODO="${HOME}/.scripts/todolist/database/todolist.txt"

#alias tdl="${HOME}/.scripts/todolist/tdl.sh"

# <=============== TODOLIST ===============>
# Todo list
export TODO="${HOME}/.scripts/todolist/database/todolist.txt"
# create, add and list tasks
tdla() { [ $# -eq 0 ] && cat $TODO || echo "$(echo $* | md5sum | cut -c 1-4) ➞ $*" >> $TODO  ;}
## remove task
tdlr() { sed -i "/^$*/d" $TODO ; }

# <===============           ===============>


# Script Version control
#alias=attDotfiles" cat ${HOME}/.scripts/todolist/tdl.sh > ${HOME}/Documentos/coding/projetos/ricing/syncScripts/todolist/tdl.sh"


# Ruby Gems on PATH
PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

# Aliases usage
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
source <(kubectl completion bash)
source <(kubectl completion bash)

# krew: kubectl (package) plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
#WARNING: To be able to run kubectl (kubectl-krew) plugins, you need to add the following to your ~/.bash_profile or ~/.bashrc and restart your shell.
export PATH="${PATH}:${HOME}/.krew/bin"


# GREP colors
export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'


# Load Angular CLI autocompletion.
#source <(ng completion script)

# Python Virtual Environments
#export WORKON_HOME=~/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#source /usr/sbin/virtualenvwrapper.sh


# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

. "$HOME/.wasmedge/env"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
