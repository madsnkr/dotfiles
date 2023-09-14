""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings

set nobackup                " Dont save backup
set noswapfile              " No swapfile
set number                  " Set linenumbers 
syntax on                   " Turn syntax highlighting on
set nocompatible            " Disable compatibility with vi which can cause unexpected issues 
set clipboard=unnamedplus   " Allow copy and paste between vim and other programs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search settings 

set incsearch               " Highlight where search matches while typing
set ignorecase              " Ignore capital letters during search
set smartcase               " Override ignorecase if searching for capital letters
set hlsearch                " Highlight search results
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype settings

filetype on                 " Enable type file detection.
filetype plugin on          " Enable plugins and load plugin for the detected file type
filetype indent on          " Load an indent file for the detected file type
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text and indent

set shiftwidth=4            " 4 spaces in normal mode 
set tabstop=4               " 4 spaces in insert mode
set expandtab               " Spaces instead of tabs

 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
