set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" This file is for neovim specific configuration.

call plug#begin()
    "Plug 'nvim-lua/completion-nvim'
"    Plug 'haorenW1025/completion-nvim'
"    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"    Plug 'nvim-treesitter/completion-treesitter'
call plug#end()

function NeovimSettings()
    set undodir=~/.vim/undodirnvim
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
endfunction


call NeovimSettings()
