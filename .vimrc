set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
		"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
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
        Plugin 'universal-ctags/ctags'
        Plugin 'yegappan/mru'

" TODO: Check what you want to keep
"Plugin 'vim-pandoc/vim-pandoc'
"Plugin 'vim-pandoc/vim-pandoc-syntax'
"Plugin 'itchyny/lightline.vim'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'tpope/vim-surround'
"Plugin 'scrooloose/nerdtree'
"Plugin 'ARM9/arm-syntax-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype plugin indent on
let mapleader=','
set autoread
set encoding=utf-8
set history=10000
set nobackup
set nowritebackup
set noswapfile

" itchyny/lightline.vim status bar, removes normal bar
set laststatus=2
set noshowmode

" ARM9/arm-syntax-vim
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

" Key mappings
map <C-n> :NERDTreeToggle<CR>

" General settings
set nu
set rnu

set cscopetag        " Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetagorder=0 " Check cscope for definition of a symbol before ctags

set csprg=/usr/bin/cscope
set csto=0
set cst

"Set .req extension to .json
autocmd BufNewFile,BufRead *.req set syntax=json

" Go To definition (cscope find)
map <silent> gt <C-]>
" Go To usage (cscope find)
nmap gu :cs find d <C-R>=expand("<cword>")<CR><CR>

" add cscope database on open
:autocmd VimEnter * :cs add system("git rev-parse --show-toplevel")/.git/cscope.out



let $FZF_DEFAULT_COMMAND= 'ag --ignore-dir=Run,*Mocks,Build2,ExtDeps -g ""'
nmap <silent> <C-P> :call fzf#run({'source': 'ag --ignore=*.gcov* -g"" .', 'sink': 'e'})<CR>

let NERDTreeQuitOnOpen=1

" search and replace
set ignorecase    " Ignore case when searching
set smartcase     " Override ignorecase if the pattern contains upper case
set incsearch     " Make search act like search in modern browsers
set magic         " Set magic on, for regular expressions
set scrolloff=5   " Include lines for context of a find

set hlsearch

" indentation
set expandtab
set shiftwidth=3
set softtabstop=3
set tabstop=8
set nowrap
set linebreak
set autoindent
set cino=(0,Ws   " Align output after parantheses but not if ( is followed by whitespace

" Find this C symbol
nmap gc :cs find s <C-R>=expand("<cword>")<CR><CR><C-O>:cw<CR>

map <leader>f :NERDTreeFind<cr>

" Replace inner word
nmap S viw"_dP<esc>

" Delete and keep the previous buffer content
nnoremap <leader>d "_d
vnoremap <leader>d "_d

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

" Dispatch cscope update to .git
nnoremap <leader>ccs :Dispatch! time cscope -R -b -q && mv cscope* $(git rev-parse --show-toplevel)/.git/<CR>
