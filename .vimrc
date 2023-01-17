" cargar la configuracion estandard, si se quiere, con la linea cogida del
" archivo /usr/share/vim/vim82/vimrc_example.vim
" VIMRUNTIME esta definido en el .bashrc del directorio compartido de
" Born2BeRoot
source $VIMRUNTIME/defaults.vim

" LEER VARIABLES DE ENTORNO DEL ARCHIVO ~/.bashrc
let g:milogin42 = $MILOGIN42

" SETTINGS 
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}
set laststatus=2
set statusline+=%F
set statusline+=%<\                       " cut at start
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file
set exrc
set tabstop=4
set noexpandtab
set noundofile 

" COPIAR UN BACKUP DE CADA ARCHIVO QUE SE EDITE CON VIM, CADA VEZ QUE SE EDITE

"las siguientes son vaiables para configurar en que directorio se guardan los
"backups -- primero se saca de la builtin lista el directorio actul
set backupdir-=.
" despues se aniaden los directorios que se quiere, separados por coma en orden de prioridad
set backupdir^=/usr/local/games/backups/,./.backups_fallback,/tmp
" el directorio ./backups_fallback se encuentra en este directorio compartido
" el directorio /usr/local/games/backupdir se crea con la script btbr-comienzo.sh

set noundofile
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set noundofile	" keep an undo file (undo changes after closing)
endif


" SOURCE FUNCTIONS -- los archivos de tipo 'vim' pueden incluir cualquier instruccion vim
" Los siguientes incluyen funciones; y comandos para mapping y alias de esas funciones 
source	$HOME/.vim/plugin/vcomments.vim
source	$HOME/.vim/plugin/comillas.vim

" AUCOMMANDS -- ver desde la linea de comandos de vim :help au
au VimEnter * :colorscheme blue
au VimLeave * :!clear
augroup ConfFiles
	"ATENCION esto desde /root machaca cambios locales para el user mylogin
	au!
	au VimLeave .vimrc :exe "w! /home/" . g:milogin42 . "/.vimrc"
	au VimLeave .bashrc :exe "w! /home/" . g:milogin42 . "/.bashrc"
	au VimLeave .bash_aliases :exe "w! /home/" . g:milogin42 . "/.bash_aliases"
	au VimLeave .dircolors :exe "w! /home/" . g:milogin42 . "/.dircolors"
augroup END

augroup  mantener_folds
	" ====== >>>>>  ATENCION <<<<< =======
	" esto puede provocar efectos inesperados en vim, y se arreglan
	" borrando los archivos del directorio .vim/view que se autocrea con el
	" autocomando mkview
	autocmd!
	autocmd BufWinLeave * mkview
	autocmd BufWinEnter * silent! loadview
augroup END

augroup poner_fecha_y_hora_a_los_archivos_backedup
    autocmd!
    au BufWritePre ?* let &bex = '=' . strftime("%Y%m%d-%H%M%S") . '_backup'
augroup END

augroup source_text
	autocmd! 
	if expand('%:e') =~# "sh"
		autocmd BufNewFile ?* :so $HOME/.vim/sourceText/sh_files
		au BufWritePost ?* silent !chmod +x <afile>
	endif
	if expand('%:e') =~# "c"
		autocmd BufNewFile ?*  :so $HOME/.vim/sourceText/c_files
	endif
augroup END

" SYNTAX -- ver :help sy
syn match Comment "\(^\#.*\)\|\(^\".*\)"
highlight Comment ctermfg=Black
