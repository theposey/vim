au GUIEnter * simalt ~x

set nocompatible

" Vundle shenanigans
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-commentary'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/vis'
Plugin 'chazy/cscope_maps'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'nelstrom/vim-visual-star-search'

call vundle#end()

set tags=./tags

set number

syntax enable
colors molokai

set hlsearch
set incsearch
set nosol

set noerrorbells
set t_vb=
set visualbell

filetype plugin on
filetype indent on

set clipboard=unnamedplus
set clipboard=unnamed

set autoindent
set smartindent
set expandtab
set smarttab
set softtabstop=4
set tabstop=4
set shiftwidth=4

set showmatch
set scrolloff=2
set lazyredraw
set wildmenu
set nowrap

set history=100

set ff=unix
set ffs=unix,dos

set guioptions-=T
set guifont=Consolas:h9:cANSI

set ruler

au GUIEnter * set t_vb=

set listchars=eol:$,tab:>-,trail:·,extends:>,precedes:<
set autochdir

set list
hi NonText ctermfg=7 guifg=gray

set noswapfile
set undofile
set undodir=~/temp

set hidden

set complete-=i

inoremap jk <Esc>

nnoremap <silent> <C-l> :nohl<CR><C-l>

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

nnoremap <Up> <esc>:bprev<cr>
nnoremap <Down> <esc>:bnext<cr>

set tags=./tags;

function! Cleanup()
"  set ff=unix
  let l = line(".")
  let c = col(".")
  silent! %s/\s\+$//
  silent! %s/\t/    /g
  silent! %s///g
  call cursor(l, c)
:endfunction

fun! ShowFuncName()
    let lnum = line(".")
    let col = col(".")
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
    echohl None
    call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

"Trim trailing space on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

noremap! <silent> <F2> :call Cleanup()<CR>
noremap <silent> <F2> :call Cleanup()<CR>
noremap <silent> <F3> :call ShowFuncName() <CR>
noremap <silent> <F4> :let @+=expand("%:p")<CR>

"For airline status bar
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t'

"For A.vim
let g:alternateSearchPath = 'sfr:../inc,sfr:../src'

let g:tagbar_width = 50
let g:tagbar_left = 1

let g:LargeFile = 1024 * 1024 * 10

"For CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:40,results:40'
nnoremap <C-o> :<C-U>CtrlPBuffer<CR>

" To edit/source vimrc
nmap ,ev :e $MYVIMRC<cr>
nmap ,es :so $MYVIMRC<cr>

function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
    endif
endfunction
au BufEnter /* call LoadCscope()

