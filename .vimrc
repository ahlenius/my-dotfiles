set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
    Plugin 'elzr/vim-json'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'junegunn/vim-peekaboo'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/nerdtree'
    Plugin 'tpope/vim-dispatch'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-surround'
    Plugin 'yegappan/mru'
call vundle#end()
filetype plugin indent on    " required

" set surround " tpope/vim-surround activation


let mapleader=','
set autoread
set encoding=utf-8
set history=10000
set hid " Hide abandoned buffers

" itchyny/lightline.vim status bar, removes normal bar
set laststatus=2
set noshowmode

" Key mappings
map <C-n> :NERDTreeToggle<CR>

" General settings
set number
set relativenumber
set csprg=/usr/bin/cscope
set csto=0
set cst
set ruler

"Set .req extension to .json
autocmd BufNewFile,BufRead *.req set syntax=json

" Go To definition (cscope find)
map <silent> gt <C-]>
" Go To usage (cscope find)
nmap gu :cs find d <C-R>=expand("<cword>")<CR><CR>

let NERDTreeQuitOnOpen=1

" Movement with <Ctrl>hjkl in insert
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l
" search and replace
set ignorecase    " Ignore case when searching
set smartcase     " Override ignorecase if the pattern contains upper case
set incsearch     " Make search act like search in modern browsers
set magic         " Set magic on, for regular expressions
set scrolloff=7   " Include lines for context of a find

set hlsearch      " Highlight search results

" indentation
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8
set nowrap
set linebreak
set autoindent   " Use smart indent?
set cino=(0,Ws   " Align output after parantheses but not if ( is followed by whitespace

" Find this C symbol
nmap gc :cs find s <C-R>=expand("<cword>")<CR><CR><C-O>:cw<CR>

map <leader>f :NERDTreeFind<cr>

" Replace inner word
nmap S viw"_dP<esc>

" Delete and keep the previous buffer content (No yanking)
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register without yanking it
vnoremap <leader>p "_dP

" Increment/Decrement next number is used for start/end of line in macOS
nnoremap <leader>a <C-a>
nnoremap <leader>x <C-x>

" Remove trailing white space
:command! WhitespaceCleanup %s/\s\+$//ge

" Autoremove trailing whitespace on save
:autocmd BufWritePre * :WhitespaceCleanup

"Fix columns lining
nnoremap <leader>zz :%!column -t<CR>
vnoremap <leader>zz :%!column -t<CR>

"Copy and Paste to external register
vnoremap <leader>y "+y
nnoremap <leader>p "+p

"MRU
nnoremap <leader>2 :MRU<CR>

"Visual Replace
vnoremap <leader>r "hy:%s/<C-R>h//gc<left><left><left>

"Visual Search
vnoremap <leader>s "sy/<C-R>s<CR>

" Copy file path to default register
nnoremap <leader>cp :let @+=@%<cr>

" Sudo save :W
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs, duh
set smarttab

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

