set guicursor=
set scrolloff=10
set number 
set relativenumber

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'morhetz/gruvbox'
call plug#end()

colorscheme gruvbox

let mapleader = " "
noremap <leader>pv :Vex<CR>
noremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
noremap <C-p> :GFiles<CR>
noremap <leader>pf :Files<CR>
noremap <C-j> :cnext<CR>
noremap <C-k> :cprev<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap jk <esc>
inoremap kj <esc>
