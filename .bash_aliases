# OPEN FILES
alias vipro="vim /etc/profile"
alias vibashal="vim $HOME/.bash_aliases"
alias vibashrc="vim $HOME/.bashrc"
alias vimrc="vim $HOME/.vimrc"
alias exrc="vim .exrc"
alias vicom="vim $HOME/.vim/plugin/vcomm*"
alias s="vim s.sh"
alias tmp="vim tmp"

# MODIFY COMMANDS
#alias vim="vim -c 'source $HOME/.vimrc'"

# SOURCE FILES
alias sal="source $HOME/.bash_aliases"
alias senf="source $HOME/.bashrc"

# GREP FILES
alias grepal='cat $HOME/.bash_aliases | grep'
alias greper="cat $VPH | grep"

# CD TO DIRECTORIES
alias ..="cd .."
alias cb="cd -"
alias cvs="cd /mnt/virtualshare; ls -l"
# MILOGIN42 es una variable definida en .bashrc, que las tiene que tener cargadas con un source de .bashrc
alias cvio="cd /home/${MILOGIN42}"
alias cvim="cd $HOME/.vim"
alias cvimpath="cd /usr/share/vim/vim82"
alias cvimcols="cd /usr/share/vim/vim82/colors"
alias cbi="cd /usr/local/bin"
alias cbif="cd /usr/local/bin/funciones"
alias cbia="cd /usr/local/bin/auxiliares"
alias cbis="cd /usr/local/bin/sed_awk_scripts"
alias cgam="cd /usr/local/games" 
alias cgab="cd /usr/local/games/bups"
alias cgar="cd /usr/local/games/reffiles"
alias cgame="cd /usr/local/games/emptypru" 
alias csha="cd /usr/local/share"
alias cshad="cd /usr/local/share/docs"
alias cshal="cd /usr/local/share/historylogs"

#RUN SCRIPTS
alias rs="./s.sh"

#RUN COMMANDS
alias restsh="systemctl start sshd"
alias ipad="ip addr | grep '^.*\([0-9]\{2,3\}\.\?\)\{4\}'"
