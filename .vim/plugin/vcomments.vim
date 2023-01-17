" FUNCIoN PARA COMENTAR,DESCOMENTAR LiNEAS, SEGuN TEST IF
" AL MINAL DE ARCHIVO, MAPEADO LLAMAR A LAS FUNCIONES COMENTAR,DESCOMENTAR CON
" CTRL-A, CTRL-B

let s:filename = expand('%:t')
let s:ext = expand('%:e') 
let s:path = expand('%:p:h') 
let s:relpath = expand('%:p:h:t') 
"tolower(expand('%:p'))

function! Comment()
  if s:relpath == 'bin' || s:path =~ 'auxiliaries' || s:path =~ 'funciones' || ( s:relpath == 'emptypru' && s:ext != 'c' ) || s:ext == 'php' || s:ext == 'rb' || s:ext == 'sh' || s:ext == 'py' || s:ext == 'toml' || s:ext == 'awk' || s:filename == '.bashrc' || s:filename == '.bash_aliases' || s:ext == 'sed' || s:filename =~ "[Mm]akefile"
    silent s/^/\#/
  elseif s:ext == 'tex' 
	  silent s/^/% /
  elseif s:ext == 'js'
    silent s:^:\/\/:g
  elseif s:ext == 'vim' || s:filename == '.vimrc' || s:filename == '.exrc'
    silent s:^:\":g
  elseif s:ext == 'html'
	 silent s/^/<!-- /
	 silent s/$/ -->/
  elseif s:ext == 'css'
	  silent s:^:/* :
	  silent s:$: */:
  elseif s:ext == 'c' || s:ext == 'h' || s:ext == 'dot'
	  silent s:^://:
echom s:path
echom s:ext
  endif
endfunction

function! Uncomment()
  if s:relpath == 'bin' || s:path =~ 'auxiliaries' || s:path =~ 'funciones' || ( s:relpath == 'emptypru' && s:ext != 'c' ) || s:ext == 'php' || s:ext == 'rb' || s:ext == 'sh' || s:ext == 'py' || s:ext == 'toml' || s:ext == 'awk' || s:filename == '.bashrc' || s:filename == '.bash_aliases' || s:ext == 'sed' || s:filename =~ "[Mm]akefile"
    silent s/^\#//
  elseif s:ext == 'tex'
	  silent s/^% \?//
  elseif s:ext == 'js'
    silent s:^\/\/::g
  elseif s:ext == 'vim' || s:filename == '.vimrc' || s:filename == '.exrc'
    silent s:^\"::g
  elseif s:ext == 'html'
	  silent s/^<!-- //
	  silent s/ -->$//
  elseif s:ext == 'css'
	  silent s:^/* ::
	  silent s: */$::
  elseif s:ext == 'c' || s:ext == 'h' || s:ext == 'dot'

	  silent s:^//::
  endif
endfunction

map <C-a> :call Comment()<CR>
map <C-b> :call Uncomment()<CR>
