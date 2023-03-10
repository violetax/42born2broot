#!/bin/bash

# FUNCIONES

# esta se ejecuta si la script se termina con CTRL-C
exit_script() {
	echo -e "\033[38;5;195m" 
	# comandos que se quiere que se ejecuten
	trap - SIGINT SIGTERM
	kill -- -$$
}
trap exit_script SIGINT SIGTERM

function Muestra_scriptnames() {
	echo -e "
	\033[38;5;11*** \033[38;5;118mEjecutables que $(basename $0) incluye en /usr/local/bin , para desarrollar \033[38;5;208mBORN-2-B-ROOT : 
	$(find  /usr/local/bin -maxdepth 1 -type f -executable 2>/dev/null || find  /usr/local/bin -maxdepth 1 -type f -perm -g+x)
\033[38;5;118m 
# \033[38;5;118m Con la opcion \033[38;5;208m -h \033[38;5;118m para ver que hacen
# \033[38;5;118m Con la opcion \033[38;5;208m -e \033[38;5;118m para editarlas al gusto
# \033[38;5;11m Lanzar \033[38;5;45mcomienzo.sh -l \033[38;5;11mpara acordarse de los nombres!!
"
}

function get_milogin42() {
	[[ $(uname -a) =~ "urduliz" ]] && milogin42=$(users) || milogin42=$(less /etc/passwd | grep "1000:1000" | awk -F: '{print $1}')
}

function Quehace() {
	get_milogin42
	echo -e "\033[38;5;45m Esta script esta pensada para ejecutarse como root, desde la maquina virtual del proyecto born2BRoot.
	Si se le pasa la \033[38;5;208m option -x \033[38;5;45m, ejecuta los comandos. De otra manera, solo se printa el pedazo de script que los contiene. 
	Acciones principales:
	1.	Copia los contenidos del DIRECTORIO COMPARTIDO (shared folder) a la MV \033[38;5;195m 
		a. Archivos de configuracion: .bashrc, .bash_aliases, .vimrc y .dircolors
		### Estos archivos, principalmente:
		\033[38;5;11m - Cambian el PATH de ejecutables para incluir /usr/local/bin, y ahi se copian el resto de scripts del directorio compartido
		- Configuran display con colores ('\$HOME/.dircolors' para bash; 'autocmd.*colorscheme' para vim)
 		- Establecen variables de entorno personalizadas, en particular, la \033[38;5;208m PROMPT_COMMAND\033[38;5;11m, de forma que registre cada comando que se utilice en la MV en un archivo en el archivo unico \033[38;5;118m /usr/local/share/historylogs/a_persistent_history \033[38;5;11m, y en otro archivo de creacion diaria : \033[38;5;118m /usr/local/share/historylogs/bash-$fecha-history \033[38;5;195m 
	2.	Instala vim, w3m y acl 
	3.	Copia el directorio .vim (con mas configuraciones de vim) al los \$HOME de root y ususario ${milogin42} 
	4.	Configura ssh para permitir login como root
	"
	[[ $HOME =~ "home" ]] && Muestra_scriptnames
	return 25
}

# VARIABLES
ejecutarcomandos=false

# getopts es un inbuilt de bash para que las scripts tomen opciones; el siguiente ejemplo significa que lanzar esta script con la opcion echo -e, lo que hace es abrir la propia script con vim'
while getopts ":ehlx" o; do
	case ${o} in
		e) 
			vim $0
			exit
			;;
		h)
			Quehace
			[[ "$?" == 25 ]] || echo 'No esta definido Quehace' 
			exit
			;;
		l)
			Muestra_scriptnames
			exit
			;;
		x)
			ejecutarcomandos=true
			;;
	esac
done
shift $((OPTIND-1))

function continua() {
	echo -e '\033[38;5;45m'
	read -p ' Pulsa ENTER para continuar ' variableinutilsoloesunmecanismoparaforzarunwaitforinput
	echo -e '\033[38;5;45m'
	clear
}


# MAIN
clear
Quehace
continua

echo -e '
\033[38;5;45m
# \033[38;5;208m >>>\033[38;5;45m PRIMERO : configuracion al gusto \033[38;5;208m<<<
' #
echo -e '
\033[38;5;45m
# \033[38;5;208mI\033[38;5;45m Desarrollar estructura personalizada de directorios :
' #
echo -e '
\033[38;5;45m
#	\033[38;5;11ma)\033[38;5;118m Copiar los directorios de .vim al \033[38;5;208m/home \033[38;5;45mde ambos users: root y milogin42\033[38;5;45m 
    ./.vim
    ./.vim/plugin
    ./.vim/sourceText
\033[38;5;11m >>>>>>>>>\033[38;5;45m Y EN LA COPIA para milogin42, cambiar los permisos con \033[38;5;118mchown \033[38;5;45m :
\033[38;5;11m 
' #
set -x
[[ ${ejecutarcomandos} == true ]] && cp -r /mnt/virtualshare/.vim $HOME  || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && cp -r /mnt/virtualshare/.vim /home/${milogin42} && find /home/${milogin42}/.vim -type d -exec chown ${milogin42}:${milogin42} {} \;       || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
set +x
continua

echo -e '
\033[38;5;45m
#	\033[38;5;11mb)\033[38;5;118m Crear directorios (si no existen) : \033[38;5;45m 
' #
set -x
[[ ${ejecutarcomandos} == true ]] && [[ ! -d /usr/local/bin/funciones ]]       && mkdir -p /usr/local/bin/funciones || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && [[ ! -d /usr/local/bin/auxiliares ]]      && mkdir -p /usr/local/bin/auxiliares || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && [[ ! -d /usr/local/bin/sed_awk_scripts ]] && mkdir -p /usr/local/bin/sed_awk_scripts || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && [[ ! -d /usr/local/games/backups ]]       && mkdir -p /usr/local/games/backups || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && [[ ! -d /usr/local/games/reffiles ]]      && mkdir -p /usr/local/games/reffiles || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && [[ ! -d /usr/local/games/emptypru ]]      && mkdir /usr/local/games/emptypru || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && [[ ! -d /usr/local/share/docs ]]          && mkdir /usr/local/share/docs || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && [[ ! -d /usr/local/share/historylogs ]]   && mkdir /usr/local/share/historylogs || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
set +x
continua

echo -e '\033[38;5;45m
#   \033[38;5;11mc)\033[38;5;118m COPIAR LOS EJECUTABLES Y FUNCIONES DE este shared folder a sus respectivos directorios en /usr/local : /usr/local/bin y /usr/local/bin/funciones (que estan incluidos en la variable PATH exportada en .bashrc)
\033[38;5;11m 
' #
set -x
[[ ${ejecutarcomandos} == true ]] && 	find /mnt/virtualshare -maxdepth 1 -type f -executable -exec cp {} /usr/local/bin \; || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && 	find /mnt/virtualshare -maxdepth 1 -type f -name '*fu' -exec cp {} /usr/local/bin/funciones \; || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
set +x
continua

echo -e '\033[38;5;45m 
# \033[38;5;208mII\033[38;5;45m. INSTALAR comandos para trabajar con facilidad:
	\033[38;5;118m vim \033[38;5;14m: necesario para editar con facilidad archivos
	\033[38;5;118m w3m \033[38;5;14m: para navegar paginas web en modo texto
	\033[38;5;118m acl \033[38;5;14m: utilidad para manejar permisos; aqui se utiliza para asignarle a milogin42, permiso de escritura en dos archivos propiedad de root
\033[38;5;45m' 
set -x
[[ ${ejecutarcomandos} == true ]] && apt install vim || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && apt install w3m || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && apt install acl || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
set +x
continua

echo -e '
\033[38;5;45m
# \033[38;5;208mIII\033[38;5;45m EDITAR, REEMPLAZAR O CREAR los archivos de configuracion y facilidades basicos, en el \033[38;5;45m/home \033[38;5;45mde \033[38;5;45mroot: \033[38;5;11m.profile, .bashrc, .bash_aliases, .dircolors, .vimrc \033[38;5;45m. 
HAY QUE \033[38;5;208m manual, \033[38;5;14mleerlos con el comando \033[38;5;118m source \033[38;5;45m desde la linea de comandos para que hagan efecto 
\033[38;5;118m$ source /root/.bashrc /root/.bash_aliases \033[38;5;11m 
'
set -x
if [[ ${ejecutarcomandos} == true ]]; then
    for f in .bashrc .bash_aliases .dircolors .vimrc
    do
        cp /mnt/virtualshare/${f} /root
        cp /mnt/virtualshare/${f} /home/${milogin42}  
    done
cat >> /root/.profile << EOF
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
EOF
else
	sed -ne "/for f in .bashrc .bash_aliases .dircolors .vimrc/,/EOF/p" $0
fi
set +x
 #

continua
echo -e '
\033[38;5;45m
#	\033[38;5;11ma)\033[38;5;118m El \033[38;5;208m.vimrc \033[38;5;118m incluye AUTOCOMANDOS PARA MACHACAR LOS ARCHIVOS DEL USUARIO milogin42, cuando se cambien en /root   
\033[38;5;45m# machacar con un autocomando, es un mecanismo facil y muy malo para usar la misma configuracion en varios users, y con posibles \033[38;5;9magujeros de seguridad \033[38;5;45m 
# \033[38;5;11mb) \033[38;5;118m AQUI se utiliza la herramienta \033[38;5;208m acl\033[38;5;45m : en la configuracion de .bashrc, la variable PROMPT_COMMAND guarda \033[38;5;9mCADA COMANDO \033[38;5;45men sendos archivos del directorio /usr/local/share/historylogs.
Ese directorio y sus archivos son territorio exclusivo de root, pero con acl se puede conceder permiso de escritura a archivos concretos, a l directorio entero: \033[38;5;11m'

set -x
[[ ${ejecutarcomandos} == true ]] && setfacl -m u:${milogin42}:rwx /usr/local/share/historylogs || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
#[[ ${ejecutarcomandos} == true ]] && setfacl -m u:${milogin42}:rw /usr/local/share/historylogs/bash_*  || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
set +x

echo -e '\033[38;5;45m
# Siguiente : \033[38;5;11m  SSH
' #
continua

echo -e '
\033[38;5;45m
#	\033[38;5;11ma)\033[38;5;118m Mostrar la instalacion standard de ssh : \033[38;5;11m 
' #
set -x
[[ ${ejecutarcomandos} == true ]] && dpkg -l  | grep ssh || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
set +x
continua

echo -e '
\033[38;5;45m
#	\033[38;5;11mb)\033[38;5;118m SI NO ESTa \033[38;5;118mopenssh-server \033[38;5;45mseria necesario instalarlo para: 
		\033[38;5;208mb.1\033[38;5;208m distintas configuraciones \033[38;5;45m(como la del puerto 4242)
		\033[38;5;45mAl instalarse el servidor ssh, es cuando aparece el directorio \033[38;5;11m /ssh \033[38;5;45m en \033[38;5;11m /etc\033[38;5;45m, y el siguiente archivo de configuracion: 
			-> /etc/\033[38;5;208mssh/sshd_config \033[38;5;45m.
		\033[38;5;208mb.2\033[38;5;45m para copiar contenidos con scp\033[38;5;208m DESDE EL GUEST\033[38;5;45m, la VM, hacia el host
' #
echo -e "\033[38;5;11m$ \033[38;5;45mls -l /etc/ssh \n\033[38;5;11m$(ls -l /etc/ssh) \033[0m"
echo -e '\033[38;5;45m 
#	\033[38;5;11mc)\033[38;5;45m Si no estuviera, tambie se puede instalar \033[38;5;118mopenssh-client \033[38;5;45mnecesario para copiar contenidos con scp desde el host \033[38;5;208mHACIA EL GUEST\033[38;5;45m, la VM
\033[38;5;45m
' #
continua

echo -e '
\033[38;5;11md)\033[38;5;45m El subject pide configurar para impedir el acceso por root, pero \033[38;5;208mno \033[38;5;45mhace falta, porque ese es el modo por defecto
\033[38;5;208m Esta script \033[38;5;45mCONTRARIO AL SUBJECT, \033[38;5;208m si \033[38;5;14mautoriza el acceso por root desde ssh por comodidad, y hay que cambiarlo antes de la evaluacion 
\033[38;5;11m' #
set -x
[[ ${ejecutarcomandos} == true ]] && sed -i 's/^\#\(PermitRootLogin\).*/\1 yes/' /etc/ssh/sshd_config || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && sed -i 's/^\(UsePAM yes\)/#\1/' /etc/ssh/sshd_config || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && sed -ne '/^\#UsePAM/p' /etc/ssh/sshd_config || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && sed -ne '/^PermitRootLogin/p' /etc/ssh/sshd_config || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
set +x
echo -e "\033[38;5;45m" 
continua 


echo '\033[38;5;11m 
# Y RESTART SSH 
' #
set -x
[[ ${ejecutarcomandos} == true ]] && systemctl start sshd || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
set +x

continua

echo -e '\033[38;5;45m
#		\033[38;5;11mEXTRA 1\033[38;5;118m Para hacer \033[38;5;208m ssh sin password \033[38;5;118m ejecutar desde la maquina del host : \033[38;5;195m 

	$ ssh-copy-id -i path_to_file/public_key_file.pub nombredeusuario@direccionIP
	$  \033[38;5;208m especificar puerto si hace falta: \033[38;5;195m  -p 4242  
	\033[38;5;45m  
	ej. $ ssh-copy-id -i $HOME/.ssh/id_rsa.pub viogonza@10.13.4.5
	ej. $ ssh-copy-id -i $HOME/.ssh/id_rsa.pub root@10.13.4.5
' #
echo -e '\033[38;5;45m
#		\033[38;5;11mEXTRA 2\033[38;5;118m Para hacer \033[38;5;208m ssh en modeo debug \033[38;5;118m ejecutar desde la maquina virtual: \033[38;5;195m

\t		systemctl stop sshd
\t		[[ ! -d /run/sshd ]] && mkdir /run/sshd
\t		/usr/sbin/sshd -d -p 4242
' #
continua
echo -e '\033[38;5;45m 
# \033[38;5;11mFIN\033[38;5;45m. IP address de la VM para conectarse por ssh :
\033[38;5;45m '

set -x
[[ ${ejecutarcomandos} == true ]] && echo -e "\033[38;5;208m"  || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
[[ ${ejecutarcomandos} == true ]] && ip addr | grep '^.*\([0-9]\{2,3\}\.\?\)\{4\}' || awk -v lineno=$LINENO '{ if ( NR == lineno ) print }' $0
set +x

echo -e "
\033[38;5;45m# Aplicar nuevos archivos de configuracion con :\033[38;5;11m

source /root/.profile

\033[38;5;45m
# Ahora pueden ejecutarse, como root, directamente desde cualquier directorio: \033[38;5;11m 
$(find /mnt/virtualshare -maxdepth 1 -type f -executable)
	\033[38;5;45m 
# \033[38;5;45m Con la opcion \033[38;5;208m -h \033[38;5;118m para ver que hacen
# \033[38;5;45m Con la opcion \033[38;5;208m -e \033[38;5;118m para editarlas al gusto \033[38;5;45m 
# \033[38;5;11m Lanzar \033[38;5;118mbtbr-comienzo.sh -l \033[38;5;11mpara acordarse de los nombres!!

\033[38;5;195m 
" #
