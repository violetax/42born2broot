"  FUNCIONES PARA METER ENTRE COMILLAS UNA PALABRA O LiNEA

" PALABRA COMILLAS DOBLES
function! Comillar()
    let l:part = expand('<cword>')
    if l:part != ""
        silent exe 'normal ciw"pa"'
    endif
endfunction
nmap kks :call Comillar()a
ab kks <left>kks

" PALABRA COMILLAS SIMPLES
function! Comising()
    let l:part = expand('<cword>')
    if l:part != ""
        silent exe "normal ciw'pa'"
    endif
endfunction
nmap kkss :call Comising()a
ab kkss <left>kkss

" PALABRA COMILLAS TIC
function! Comitic()
    let l:part = expand('<cword>')
    if l:part != ""
        silent exe 'normal ciw`pa`'
    endif
endfunction
nmap kkt :call Comitic()a
ab kkt <left>kkt
ab lkks <left>lkks

" LiNEA COMILLAS DOBLES
function! LComillas()
    let l:part =  line('.')
    if l:part != ""
        silent exe 'normal 0Di"pi"'
    endif
endfunction
nmap lkks :call LComillas()a
ab lkks <left>lkks 
