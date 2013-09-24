"VIMIDE vimrc basic settings
"--------start---------
set fileencodings=ucs-bom,utf-8,cp936
set helplang=cn
colo desert
set guifont=Consolas:h12
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set noswapfile
set nowb
set backspace=start,indent,eol
set nu!
set autoindent
"set smartindent
set wrap
set incsearch  
set hlsearch  "高亮所有匹配
set noerrorbells
set novisualbell
set lines=40 
set columns=90
set textwidth=80

"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

syntax on

filetype plugin on
filetype indent on

map <C-t> :NERDTree<cr>
map <C-o> :TlistToggle<cr>
vmap <C-c> "+y
map <A-v> "+p


let Tlist_Ctags_Cmd='ctags.exe'
let Tlist_Show_One_File = 1

let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 
"--------end--------
"
map <F7> :call CompilePython()<CR>
func! CompilePython()
exec "w"
exec "!python %"
endfunc
let g:DoxygenToolkit_authorName="iyixiang"
"let g:DoxygenToolkit_licenseTag="My own license" 

func Head()
let l=0
let l=l+1 | call setline(l, "\/**")
let l=l+1 | call setline(l, " * @file    ".expand("%")) 
let l=l+1 | call setline(l, " * @author  iyixiang")
let l=l+1 | call setline(l, " * @date ")
let l=l+1 | call setline(l, " *          Created Time:  ".strftime("%c")."\\n") 
let l=l+1 | call setline(l, " *          Last Modified: ".strftime("%c"))
let l=l+1 | call setline(l, " * @brief   ")
let l=l+1 | call setline(l, " */ ")
let l=l+1 | call setline(l, "")
"7r ~/.template
endfunc
fun LastMod()
    let L = line("$")
    let original_view = winsaveview()
    if L > 20
        let L = 20
    endif
    let x = "1," . L . "g/Last Modified: /s/Last Modified: .*/Last Modified: " .
        \ strftime("%Y-%m-%d %H:%M:%S")
    "call setline(8, x)
    exe x
    call winrestview(original_view)
endfun

au  BufNewFile \(*.c\)\|\(*.h\)\|\(*.cc\)\|\(*.cpp\) call Head()
au  BufWritePre,FileWritePre \(*.c\)\|\(*.h\)\|\(*.cc\)\|\(*.cpp\)   ks|call LastMod()|'s

func PythonHead()
let l=0
let l=l+1 | call setline(l, "##")
let l=l+1 | call setline(l, "# File Name: ".expand("%")) 
let l=l+1 | call setline(l, "# Created Time:  ".strftime("%c")) 
let l=l+1 | call setline(l, "# Author: iyixiang")
let l=l+1 | call setline(l, "# Description: ")
let l=l+1 | call setline(l, "# Last Modified: ".strftime("%c"))
let l=l+1 | call setline(l, "##")
let l=l+1 | call setline(l, "")
"7r ~/.template
endfunc
au  BufNewFile *.py call PythonHead()
au  BufWritePre,FileWritePre *py  ks|call LastMod()|'s


func AppendTime(L)
exe a:L.','.a:L.'s/$/'.strftime("%Y-%m-%d %H:%M:%S")
endfunc


highlight OverLength ctermbg=red ctermfg=white guibg=#592929 
match OverLength /\%81v.\+/










