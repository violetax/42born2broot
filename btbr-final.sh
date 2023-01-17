#!/bin/bash

source Opte.fu
source Continua.fu

function Quehace() {
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
			[[ "$?" == 25  ]] || echo "PENDIENTE: Quehace"
			exit
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

echo -e "\033[38;5;208m CINCO \033[38;5;190mpuntos finales : "

echo -e "\033[38;5;11m1. \033[38;5;118m Cambiar las contrasenias de milogin42 y root : si no cumplen la politica, el cambio se rechaza de manera automatica. Comando: \033[38;5;208m passwd " 

echo -e "\033[38;5;11m2. \033[38;5;118m Cambiar la contrasenia del encriptado, a algo seguro: por ejemplo, de 14 caracteres, con numeros, letras en mayuscula y minuscula, y algun simbolo : \033[38;5;195m 
1.  Mostrar la particion LVM encriptada: 
	$     cat /etc/crypttab # EJEMPLO: para sda5_crypt : /dev/sda5
2. 	Aniadir contrasenia encriptada:
	$  sudo cryptsetup luksAddKey /dev/sda5
3.	Borrar la contrasenia vieja, si se quiere: 
	$  sudo cryptsetup luksRemoveKey /dev/sda5
4.	Mostrar info sobre el encriptado
	$  sudo cryptsetup luksDump /dev/sda5
"

echo -e "\033[38;5;11m3. \033[38;5;118m Editar /etc/ssh/sshd_config para 1. usar PAM y 2. no permitir conexion ssh con root: \033[38;5;195m 
	$	sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
	$	sed -i 's/#\(UsePAM yes\)/\1/' /etc/ssh/sshd_config
	$	systemctl restart ssh
	"

echo -e "\033[38;5;118m - Desde el host , con la maquina apagada, supongo: 
\033[38;5;195m$ \033[38;5;190m shasum nuestro-born2BRoot-vhd-file.vdi > signature.txt "

echo -e "\033[38;5;9m ATT !!!!! \033[38;5;190m durante las evaluaciones , bien \033[38;5;208mcerrar la maquina con save-estate  bien \033[38;5;208m  haber hecho clones de aquella cuya firma se entrega \033[38;5;190m, y usar un clon por evaluacion"
