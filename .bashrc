# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

case $- in 
	*i*) ;;
	*) return;;
esac

# source aliases

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# no escapar el simbolo dollar con el autocompletado de tab
shopt -s direxpand

# algunos exports de variables de environment personales
export PATH=$PATH:/mnt/virtualshare:/usr/local/bin:/usr/local/bin/funciones:/usr/local/bin/auxiliares
export LS_OPTIONS='--color=auto'
export HISTTIMEFORMAT="%F %T  "
export TERM=xterm
export VPH=/usr/local/share/historylogs/a_persistent_history
hoy=$(date +%d-%m-%y)
export VHH=/usr/local/share/historylogs/bash_${hoy}_history

# algunos alias
alias ls='ls $LS_OPTIONS'
alias la='ls -a $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

# cambiar algunos colores de la terminal
eval "$(dircolors)"
[[ -f ~/.dircolors ]] && eval "`dircolors -b ~/.dircolors`"

# FUNCIoN PARA registrar todos los comandos que se ejecuten en cualquier terminal abierta, en el directorio creado por el usuario: /usr/local/share/historylogs 
	# DENTRO DE un unico file, $VPH (declarado con un comando export)
	# Y DENTRO DE un file diario, con los comandos solo de ese dia, $VHH (declarado con un comando export)
log_bash_persistent_history() {
	[[
		$(history 1) =~ ^\ *([0-9]+)\ +([^\ ]+)\ ([^\ ]+)\ +(.*)$
	]]
	local match_history_numero="${BASH_REMATCH[1]}"
	local match_fecha="${BASH_REMATCH[2]}"
	local match_hora="${BASH_REMATCH[3]}"
	local match_comando="${BASH_REMATCH[4]}"

	if [ "$match_comando" != "$PERSISTENT_HISTORY_LAST" ]
	then
			echo -e "$match_fecha $match_hora -> $(pwd) => $match_comando" >> $VPH
			echo -e "$match_fecha $match_hora -> $(pwd) => $match_comando" >> $VHH
	fi
	export PERSISTENT_HISTORY_LAST="$match_comando"
}

# funcion par recoger varias funciones o comandos - y aplicarla a traves de la variable builtin de bash PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
	echo -e '\033[38;5;195m'
	# ejecutar echo -e '\033[38;5;195m' es un mecanismo facil para cambiar el color de la terminal
}
# por algun motivo, la instruccion solo funciona poniendola dos veces en lo que parece un array de la builtin PROMPT_COMMAND
PROMPT_COMMAND=("run_on_prompt_command" "run_on_prompt_command" )

# mas exports
# VARIABLES
export MILOGIN42=$(less /etc/passwd | grep "1000:1000" | awk -F: '{print $1}')
## DIRECTORIOS
export CVS=/mnt/virtualshare
export CVIM=/root/.vim
export CVISO=/root/.vim/sourceText
export CVIPLU=/root/.vim/plugin
export CBI=/usr/local/bin
export CBIF=$CBI/funciones
export CBIA=$CBI/auxiliares
export CBIS=$CBI/sed_awk_scripts
export CGAM=/usr/local/games
export CGAB=/usr/local/games/backups
export CGAR=/usr/local/games/referencefiles
export CGAME=/usr/local/games/emptypru
export CSHA=/usr/local/share
export CSHAD=/usr/local/share/docs
export CSHAL=/usr/local/share/historylogs
## FILES -- usar solo los files de configuracion de root, como mecanismo facil para una maquina de uso privado
export BASH_ALIASES=/root/.bash_aliases
export BASHRC=/root/.bashrc
export VIMRC=/root/.vimrc
