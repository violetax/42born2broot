#!/bin/bash

source Continua.fu

function Quehace() {
	echo -e "\033[38;5;190mScript muy, muy poco pulida, para mostrar info sobre comandos relativos a LVM" 
	return 25
}

while getopts ":eh" o; do
	case ${o} in
		e)
			vim $0
			exit
			;;
		h)
			Quehace 2>/dev/null
			echo -e "$?"
			[[ '$?' == 25  ]] || echo 'No esta definido Quehace'
			exit
			;;
	esac
    
done
shift $((OPTIND-1))

exit_script() {
	# esto se ejecuta en caso de exit distinto de 0
	# poner aqui lo que quieres que se ejecute
    trap - SIGINT SIGTERM # 
    kill -- -$$ # Sends SIGTERM to child/sub processes
}

trap exit_script SIGINT SIGTERM

### MAIN

lvmcomandos=( "pvs" "vgs" "lvs" )   
function Comandos_LVM_no_encriptado {
	echo -e "\033[38;5;118mhttps://www.tecmint.com/extend-and-reduce-lvms-in-linux/"
	echo -e "\033[38;5;208m Commands \033[38;5;118mpvs vgs lvs \033[38;5;190mDisplay information about logical volumes"   
	echo -e "Si no hay espacio libre disponible en el volumen fisico y grupo, hay que: \033[38;5;11m 
	1.	aniadir un volumen fisico, PV :usar el comando \033[38;5;208m fdisk 
		\033[38;5;14m$ \033[38;5;118mfdisk -cu /dev/devname \033[38;5;11m 
		- n : nueva particion 
		- p : primary
		- escoger particion del menu, y presionar \`t\` para cambiarle el tipo : meter \`8e\` para Linux LVM
	    - w : escribir cambios
	2.	Restart sistema
	3.	Crear un volumen fisico, PV	
		\033[38;5;14m$ \033[38;5;118mpvcreate /dev/devname1
		\033[38;5;14m$ \033[38;5;118mpvs \033[38;5;14m#para verificar
	4.	Extender el Grupo de volumen
	..."
#endfunction InfoLVMcomandos
} #
function Info_LVM_encriptado {
	echo -e "\033[38;5;190mhttps://unix.stackexchange.com/questions/320957/extend-a-luks-encrypted-partition-to-fill-disk \033[0m" 
	echo -e "
	\033[38;5;11m/dev/sda5 : mounted at /, Id: 83 
 \033[38;5;118m  cryptsetup luksOpen /dev/sda5 crypt-volume \033[38;5;14m # to open the encrypted volume.
 \033[38;5;118m  parted /dev/sda to extend the partition\033[38;5;14m # resizepart NUMBER END.
 \033[38;5;118m  vgchange -a n volumegroup_name\033[38;5;14m # Stop using the VG so you can do the next step.
 \033[38;5;118m  cryptsetup luksClose crypt-volume\033[38;5;14m # Close the encrypted volume for the next steps.
 \033[38;5;118m  cryptsetup luksOpen /dev/sda5 crypt-volume\033[38;5;14m # Open it again.
 \033[38;5;118m  cryptsetup resize crypt-volume\033[38;5;14m # Will automatically resize the LUKS volume to the available space.
 \033[38;5;118m  vgchange -a y volumegroup_name\033[38;5;14m # Activate the VG.
 \033[38;5;118m  pvresize /dev/mapper/crypt-volume\033[38;5;14m # Resize the PV.
 \033[38;5;118m  lvresize -l+100%FREE /dev/volumegroup_name/home\033[38;5;14m # Resize the LV for /home to 100% of the free space.
 \033[38;5;118m  e2fsck -f /dev/mapper/volumegroup_name-home\033[38;5;14m # Throw some fsck magic at the resized fs.
 \033[38;5;118m  resize2fs /dev/mapper/volumegroup_name-home\033[38;5;14m # Resize the filesystem in /home (automatically uses 100% free space)
"
#endfunction Info_LVM_encriptado
} #
function CryptsetupInfo {
	echo -e "\033[38;5;190mhttps://linuxconfig.org/basic-guide-to-encrypting-linux-partitions-with-luks"
   echo -e "
\033[38;5;14m# apt-get install cryptsetup
\033[38;5;11m 1. Setting Up The Partition → 
\033[38;5;14m # cryptsetup luksFormat /dev/sdb1
\033[38;5;11m With options → 
\033[38;5;14m # cryptsetup -c aes-xts-plain64 --key-size 512 --hash sha512 --time 5000 --use-urandom /dev/sdb1
...
o open the volume onto the device mapper.

👀 Ver tambien : \033[38;5;190m https://thequantitative.medium.com/resize-an-encrypted-partition-without-breaking-your-linux-system-6ef475619745 "
#endfunction CryptsetupInfo
} #
function ChangeEncrypPsswd {
	echo -e "\033[38;5;190m https://askubuntu.com/questions/109898/how-to-change-the-password-of-an-encrypted-lvm-system-previously-alternate-inst"
   echo -e "
   \033[38;5;208m ATT!! \033[38;5;11mLo principal, es que no se puede dejar el volument sin al menos una contrasenia. Esto es, que si hay solo una y se quiere cambiar, primerro se aniade la nueva, y despues se borra la vieja.
   \033[38;5;208m Es decir, \033[38;5;11mque puede haber varias contrasenias 
\033[38;5;14m1. \033[38;5;11m	 which is the encrypted LVM partition 
	\033[38;5;45m$ \033[38;5;118m    cat /etc/crypttab
\033[38;5;14m2. \033[38;5;11m	To add a new password, use luksAddKey: 
	\033[38;5;45m$ \033[38;5;118m sudo cryptsetup luksAddKey /dev/sda5   
\033[38;5;14m5. \033[38;5;11m	View currently used slots of the encrypted partition (make sure at least one slot is shown): 
	\033[38;5;45m$ \033[38;5;118m sudo cryptsetup luksDump /dev/sda5   
	"
#endfunction ChangeEncrypPsswd
} #

#MAIN
#Comandos_LVM_no_encriptado
#Info_LVM_encriptado
#CryptsetupInfo 
select inff in Comandos_LVM_no_encriptado Info_LVM_encriptado CryptsetupInfo ChangeEncrypPsswd
do
	clear
	${inff} 
	REPLY=""
done	
