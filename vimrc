"VIMIDE vimrc basic settings
"--------start---------
set fileencodings=ucs-bom,utf-8,cp936
set helplang=cn

set shiftwidth=2
set tabstop=2
set expandtab
set nobackup
set noswapfile
set nowb
set backspace=start,indent,eol
set nu!
set autoindent
set smartindent
set wrap

"set noerrorbells
"set novisualbell


"map <C-F3> :NERDTree<cr>
"map <C-o> :TlistToggle<cr>
"when runing ! , cmd not pop up
command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

let Tlist_Ctags_Cmd='ctags.exe'
let Tlist_Show_One_File = 1
let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 0
"inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
"nnoremap <C-P> :call PhpDocSingle()<CR>
"vnoremap <C-P> :call PhpDocRange()<CR>
"--------end--------


"
"{{{Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings

" Necesary  for lots of cool vim things
"set nocompatible

" This shows what you are typing as a command.  I love this!
"set showcmd

" Folding Stuffs
"set foldmethod=marker
set foldmethod=syntax
"set foldnestmax=4
" Needed for Syntax Highlighting and stuff

"filetype on
"filetype plugin on
"syntax enable
"set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
"set shiftwidth=3
"set softtabstop=3

" Use english for spellchecking, but don't spellcheck by default
"if version >= 700
   "set spl=en spell
   "set nospell
"endif

" Real men use gcc
"compiler gcc

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Got backspace?
"set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
"inoremap jj <Esc>

"nnoremap JJJJ <Nop>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
"let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
"set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4
" }}}

"{{{Look and Feel

" Favorite Color Scheme
if has("gui_running")
   colorscheme inkpot
   " Remove Toolbar
   set guioptions-=T
   "Terminus is AWESOME
   set guifont=Terminus\ 9
else
   colorscheme metacosm
endif

"Status line gnarliness
"set laststatus=2
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" }}}

"{{{ Functions

"{{{ Open URL in browser

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec ':Silent cmd /cstart '.line
   "exec "!konqueror ".line
endfunction

"}}}

"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "inkpot#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
" }}}

"{{{ Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
"}}}

"{{{ Todo List Mode

function! TodoListMode()
   e ~/.todo.otl
   Calendar
   wincmd l
   set foldlevel=1
   tabnew ~/.notes.txt
   tabfirst
   " or 'norm! zMzr'
endfunction

"}}}

"}}}

"{{{ Mappings

" Open Url on this line with the browser \w
"map  <Leader>w :call Browser ()<CR>
map <c-b> :call Browser ()<CR>

" Open the Project Plugin <F2>
nnoremap <silent> <F2> :Project<CR>

" Open the Project Plugin
nnoremap <silent> <Leader>pal  :Project .vimproject<CR>

" TODO Mode
nnoremap <silent> <Leader>todo :execute TodoListMode()<CR>

" Open the TagList Plugin <F3>
nnoremap <silent> <F3> :Tlist<CR>

" Next Tab
"nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
"nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
"nnoremap <silent> <C-t> :tabnew<CR>

" Rotate Color Scheme <F8>
"nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

" DOS is for fools.
"nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" Paste Mode!  Dang! <F10>
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Edit gvimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

" Up and down are more logical with g..
"nnoremap <silent> k gk
"nnoremap <silent> j gj
"inoremap <silent> <Up> <Esc>gka
"inoremap <silent> <Down> <Esc>gja

" Good call Benjie (r for i)
"nnoremap <silent> <Home> i <Esc>r
"nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
"nnoremap <silent> zj o<Esc>
"nnoremap <silent> zk O<Esc>


" Space will toggle folds!
nnoremap <space> za
nnoremap <S-space> zA

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
"map N Nzz
"map n nzz

" Testing
set completeopt=longest,menuone,preview


inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Swap ; and :  Convenient.
"nnoremap ; :
"nnoremap : ;

" Fix email paragraphs
nnoremap <leader>par :%s/^>$//<CR>

"ly$O#{{{ "lpjjj_%A#}}}jjzajj

"}}}

"{{{Taglist configuration
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
"let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0
"}}}

let g:rct_completion_use_fri = 1
"let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_ViewRule_pdf = "kpdf"





""{{{ iyixiang custom
"{{{ python
au  BufNewFile *.py call PythonHead()
au  BufWritePre,FileWritePre *py  ks|call LastMod()|'s

func RunPython()
exec "w"
exec "!python %"
endfunc

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

"}}}


"{{{ c/c++
au  BufNewFile \(*.c\)\|\(*.h\)\|\(*.cc\)\|\(*.cpp\) call Head()
au  BufWritePre,FileWritePre \(*.c\)\|\(*.h\)\|\(*.cc\)\|\(*.cpp\)   ks|call LastMod()|'s

func Head()
let l=0
let l=l+1 | call setline(l, "\/**")
let l=l+1 | call setline(l, " * @brief     ")
let l=l+1 | call setline(l, " * ")
let l=l+1 | call setline(l, " * @file      ".expand("%"))
let l=l+1 | call setline(l, " * @author    iyixiang")
let l=l+1 | call setline(l, " * @date      ")
let l=l+1 | call setline(l, " *            Created Time:  ".strftime("%c")."\\n")
let l=l+1 | call setline(l, " *            Last Modified: ".strftime("%c"))
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


"}}}

"{{{
"" completeopt
"set completeopt=longest,menuone
""set completeopt=longest,preview
"" open omni completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
"" open user completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
"
"vnoremap <silent> <C-F1> :<C-U>let old_reg=@"<CR>gvy:silent!!cmd /cstart <C-R><C-R>"<CR><CR>:let @"=old_reg<CR>
"colorscheme molokai
"let g:molokai_original = 1
"let g:rehash256 = 1
"}}}

"{{{ to fix auto completion too slow
" http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
"}}}

"{{{highlight when character exceed 80 at one line
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
"}}}

"{{{Toggle Menu and Toolbar
"set guioptions-=m
"set guioptions-=T
"map <silent> <F2> :if &guioptions =~# 'T' <Bar>
"        \set guioptions-=T <Bar>
"        \set guioptions-=m <bar>
"    \else <Bar>
"        \set guioptions+=T <Bar>
"        \set guioptions+=m <Bar>
"    \endif<CR>
"}}}

"{{{Insert time
func InsertTime(L)
exe a:L.','.a:L.'s/$/'.strftime("%Y-%m-%d %H:%M:%S")
endfunc
"}}}

"{{{Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
"}}}

"{{{vimrc ref : http://blog.csdn.net/wcc526/article/details/12111407
colorscheme desert
set background=light
set background=dark
set guifont=Consolas:h11
set textwidth=80
set lines=40
set shiftwidth=4
set tabstop=4
set laststatus=0
set modifiable
map <F4> :NERDTreeToggle<cr>
vmap <C-c> "+y<cr>,c<space>
map <C-p> "+p
map <C-q> :q<cr>:syntax on<cr>
map <C-s> :w<cr>
map <C-x> ,c<space>
map <F7> :call RunPython()<CR>
"map <C-w-C-w> :<C-w>
"}}}
"syntax enable
syntax on
filetype plugin on
filetype indent on
