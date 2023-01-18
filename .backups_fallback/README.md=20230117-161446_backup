<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/violetax/42born2broot"></a>
<div align="left">
  <h3 align="center">42 born2broot</h3>
  <p>Este repositorio contiene dos cosas útiles: </p>
  <ol>
  	<li> Una serie de scripts en bash, y otros archivos de texto de diferentes tipos, con material para desarrollar el proyecto de BORN-2B-ROOT </li>
   	<li> Breves instrucciones, en este README, sobre cómo configurar y acceder a un directorio compartido entre un guest Debian de VirtualBox, y un host (al menos Mac o Linux) </li>
  </ol>
  <p>Como recurso de ayuda para el proyecto Born2Broot, es flojo por muchos motivos. Pero si alguien parte de 0, y quiere dedicarle al menos una semana al proyecto, este es un punto de partida tremendamente mejor que nada.</p>
  <p>En particular, lo más valioso es la utilización de bash y vim a través de las scripts, que pueden entenderse con apoyo en Google, que es en lo que consiste el proyecto de born2Broot.</p>
  <p>Como recurso de ayuda, queda pendiente: mejorarlo y ampliarlo con conocimientos útiles. En particular, los bonus están sin hacer.</p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
	<summary>Archivos contenidos</summary>
		<h4><a href="#bashscripts">Scripts de bash</a></h4>
	<div align="left">
		<ol>
			<li>[btbr-comienzo.sh](https://github.com/violetax/42born2broot/blob/main/btbr-comienzo.sh)</li>
			<li>[btbr-final.sh](https://github.com/violetax/42born2broot/blob/main/btbr-comienzo.sh)</li>
			<li>[monitoring.sh](https://github.com/violetax/42born2broot/blob/main/monitoring.sh)</li>
			<li>[algunos_comandos_virtualbox.sh](https://github.com/violetax/42born2broot/blob/main/algunos_comandos_virtualbox.sh)</li>
			<li>[sobre_lvm_y_contrasenia_encriptada.sh](https://github.com/violetax/42born2broot/blob/main/sobre_lvm_y_contrasenia_encriptada.sh)
		</ol>
	</div>
	<div align="left">
		<h4><a href="#bashfunciones">Funciones: auxiliares de bash</a></h4>
		<ol>
			<li>[Opte.fu](https://github.com/violetax/42born2broot/blob/main/Opte.fu)</li>
			<li>[Continua.fu](https://github.com/violetax/42born2broot/blob/main/Continua.fu)</li>
		</ol>
	</div>
	<div align="left">
		<h4><a href="#configbash">Archivos de configuración de bash</a></h4>
		<ol>
			<li>[.bashrc](https://github.com/violetax/42born2broot/blob/main/.bashrc)</li>
			<li>[.bash_aliases](https://github.com/violetax/42born2broot/blob/main/.bash_aliases)</li>
			<li>[.dircolors](https://github.com/violetax/42born2broot/blob/main/.dircolors)</li>
		</ol>
	</div>
	<div align="left">
		<h4><a href="#configvim">Archivos de configuración de vim</a></h4>
		<ol>
			<li>[.vimrc](https://github.com/violetax/42born2broot/blob/main/.vimrc)</li>
		</ol>
	</div>
	<div align="left">
		<h4><a href="#vimdir">Directorio de vim</a></h4>
		<ul>
			<li>[Directorio de archivos con contenido de texto, para la funcionalidad: insert](https://github.com/violetax/42born2broot/tree/main/.vim/sourceText)</li>
			<li>[Directorio de archivos tipo vim, con funcionalidad de sintaxis](https://github.com/violetax/42born2broot/tree/main/.vim/plugin)</li>
		</ul>
	</div>
	<div align="left">
		<h4><a href="#subjhtml">El subject, en formato html</a></h4>
	</div>
	</ul>
</details>

<!-- ABOUT THE PROJECT -->
## RECOMENDACIONES
<strong><strong>WARNING</strong></strong> 
<strong>El material incluído en las scripts y archivos de configuración no está testeado; es solo orientativo</strong>

<div id="recomendaciones">
<p>Para este proyecto, se recomienda hacer una instalación rápida, con partición guiada, y estas scripts en un directorio compartido (<a href="#directoriocompartido">ver instrucciones</a>)</p>
<p>Ir utilizando sin miedo estas scripts, en esa instalación de prueba. Lo único: ASEGURAR AL MENOS <b>3 GB</b> de RAM, porque si no va horriblemente lento, al menos en las máquinas de 42.</p>
<p><b>Puede adelantarse</b> este punto del subject: en particiones, escoger <b>GUIADA CON LVM ENCRIPTADO</b>. Más adelante, escoger una <b>/home partition separada</b>. Y más adelante, se pregunta cuál es el mínimo tamaño de disco que se quiere usar, y se te indica cual es el mínimo indispensable: poner solo "algo más" que el mínimo (menos que el 100% pero más que el mínimo, a boleo, y que haya suerte).</p>
</div>
<!-- Here's a blank template to get started: To avoid retyping too much info. Do a search and replace with your text editor for the following: `violetax`, `42born2broot`, `twitter_handle`, `linkedin_username`, `email_client`, `violetaggarcia@gmail.com`, `project_title`, `project_description` -->

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
### DIRECTORIO COMPARTIDO EN VIRTUAL BOX

<div id="directoriocompartido">
<p>La configuración de uno o varios directorios compartidos está en el menú general de configuración de la máquina virtual (Settings). Para añadir un <b>Machine folder</b>, se rellena (o puede rellenarse al menos) de la siguiente manera:</p>
<div align="left">
<p><b>Folder Path</b> y <b>Folder name</b> hace referencia a los valores en el host, i.e. la ruta completa con el nombre incluido, para el path; y solo el nombre en el host, de ese directorio que quieres compartir. En host y guest, no tienen que llamarse igual.
<p>Read-only : NO </p>
<p>Auto-mount : con esta opción, al menos en Debian hay que aplicar el comando de montado igualmente.</p>
</div>
<div align="left">
<h3>En un guest tipo Debian</h3>
<p>Un usuario con privilegios de administrador tiene que montar el directorio. El comando par ello <b>mount</b> tiene un parámetro concreto para este caso:</p>
</div>
</div>

* mount -t vboxsf
  ```sh
  mount -t vboxsf nombreDlDirectorio /ruta_en_el_guest
  ```
* por ejemplo
  ```sh
  mount -t vboxsf nombreenHost /mnt/nombreenGuest
  ```
<p>Estas líneas, una logueado en la máquina como root,  pueden añadirse a un archivo de configuración de bash (por ejemplo, el <i>/etc/profile</i>) para que se ejecuten de manera automática al encenderse la máquina virtual. Conviene además, añadir en la configuración una línea para asegurarse de que sí existe el directorio donde se quiere hacer el montaje.</p>

* si no existe, crearlo
  ```sh
  [[ ! -d /mnt/nombreenGuest ]] && mkdir /mnt/nombreenGuest
  ```
<p>En caso de acceder a una máquina desde <b>ssh</b>, ese acceso es automático o no: está vinculado a la configuración de ssh (relativo a los privilegios de administración del usuario que se conecta por ssh).</p>

## CÓMO ENTENDER Y USAR LOS ARCHIVOS DE ESTE REPOSITORIO

  <div align="left" id="comousaresto">
   <p>La idea es guardar las script incluidas en un directorio compartido. A partir de ahí, puede ejecutarse en primer lugar <b>btbr-comienzo.sh -h<b> </p>
   <p>Esa opción <b>-h</b> utiliza un builtin de bash, que permite que las scripts tomen opciones. Y en esta script, la opción h hace referencia a "help", y se limita a printar información... Todas las script incluidas llevan dos opciones: la <b>-h</b> para ver ayuda, y la <b>-e</b> para editarla. Con la optión -e se ejecuta ``` vim $0 ```, es decir, que se abre la script desde cualquier directorio en que se ejecute.  </p>
  <p>Y "plug and play".</p>
  <strong>btbr-comienzo.sh instala: vim, w3m y acl</strong> 
  <p><b>w3m</b> es un navegador en texto, con el que puede abrirse el archivo <b>[btbr-subject.html](https://github.com/violetax/42born2broot/blob/main/btbr-subject.html)</b>, que contiene el subject oficial (el que era en diciembre de 2022), frase a frase, con cada frase comentada con información y comandos. <b>Pendiente, mejorarlo y ampliarlo</b></p>.
  <p>Se agradecen todas las ampliaciones de información que sean una mejora. En particular compartir cómo se hace el apartado de particiones de los bonus, sin el truco de la partición manual durante la instalación.</p>
  </div>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contacto

Project Link: [https://github.com/violetax/42born2broot](https://github.com/violetax/42born2broot)
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Reconocimientos

<!-- * [Guia anterior para born2broot, desde Urduliz 42](https://docs.google.com/document/d/1P3aTAu0zp-_aRrH31AdM6_k6_tWx6j97MF007J6LtsI/edit?usp=sharing) -->
* [Plantilla de este Readme](https://github.com/othneildrew/Best-README-Template)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/violetax/42born2broot.svg?style=for-the-badge
[contributors-url]: https://github.com/violetax/42born2broot/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/violetax/42born2broot.svg?style=for-the-badge
[forks-url]: https://github.com/violetax/42born2broot/network/members
[stars-shield]: https://img.shields.io/github/stars/violetax/42born2broot.svg?style=for-the-badge
[stars-url]: https://github.com/violetax/42born2broot/stargazers
[issues-shield]: https://img.shields.io/github/issues/violetax/42born2broot.svg?style=for-the-badge
[issues-url]: https://github.com/violetax/42born2broot/issues
[license-shield]: https://img.shields.io/github/license/violetax/42born2broot.svg?style=for-the-badge
[license-url]: https://github.com/violetax/42born2broot/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
