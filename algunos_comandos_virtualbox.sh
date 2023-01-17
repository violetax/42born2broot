#!/bin/bash

source Asksure.fu
source Opte.fu
source Continua.fu
source Whereami.fu
whereami 

function whatis() {
	echo -e "Script muy poco pulida, para mostrar algunos comando útiles para usar VBoxManage"
	echo -e "Coge una maquina virtual como argumento en \$1, y si no hay, la busca entre las variables de entorno..."
	echo -e "\033[38;5;190mhttps://superuser.com/questions/634195/how-to-get-ip-address-assigned-to-vm-running-in-background\033[0m" 
	return 25
}
lsonly=false
while getopts ":ehl" o; do
	case ${o} in
		e)
			vim $0
			exit
			;;
		h)
			whatis 2>/dev/null
			[[ "$?" == 25  ]] || echo "🔥 PENDING whatis"
			exit
			;;
		l)
			lsonly=true;
			;;
	esac
    
done
shift $((OPTIND-1))

exit_script() {
	# esto se ejecuta en caso de exit distinto de 0 # NO ES 100% FIABLE...
	# poner aqui lo que quieres que se ejecute
    trap - SIGINT SIGTERM # 
    kill -- -$$ # Sends SIGTERM to child/sub processes # A VECES, LA SYNTAXIS AQUÍ ES SIN EL GUIÓN QUE PRECEDE AL DOBLE DOLAR
}

trap exit_script SIGINT SIGTERM

### MAIN
[[ $1 ]] && VM=$1

#function Get--mac-address() {

vibocoms=(
"VBoxManage list vms"
"VBoxManage startvm $VM"
"VBoxManage controlvm $VM poweroff"
"VBoxManage controlvm $VM savestate"
"VBoxManage startvm $VM --type headless"
"VBoxManage list runningvms"
"VBoxManage showvminfo $VM --details"
"VBoxManage list vms"
#"vboxmanage showvminfo --details e800470a-8ee3-49bf-bbf9-7f41d2eebd78"
#"vboxmanage dhcpserver --network NatNetwork --mac-address="
"VBoxManage guestproperty enumerate ${VM}"
"VBoxManage guestproperty get ${VM} IP"
"VBoxManage guestproperty get ${VM} Net"
"VBoxManage snapshot ${VM} take snapshot1_of_${VM}"
"VBoxManage clonevm ${VM}"
)

if [[ ${lsonly} == true ]]; then
	for vco in "${vibocoms[@]}"
	do
		echo "${vco}"
	done
	exit
fi


COLUMNS=12
select vic in "${vibocoms[@]}" 
do
	case $REPLY in
		7)
			${vic} | less
			;;
		9)
			${vic} | fgrep MAC
			;;
		*)
			${vic}
			;;
	esac
   break
done 
