
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

syntax on 

set t_Co=256 "Enables 256 color mode
noh "Disable search highlighting
nnoremap <silent> <leader>n :nohlsearch<CR>

call plug#begin('~/plugged')

Plug 'morhetz/gruvbox'
Plug 'BurntSushi/ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'townk/vim-autoclose'
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'sharkdp/fd'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

"First time setup, run:
":TSInstall python
":TSInstall bash

"org.vim config, to install: https://github.com/axvr/org.vim
syntax enable
filetype plugin indent on

colorscheme gruvbox
set background=dark

highlight NORMAL ctermbg=NONE

if executable('rg')
	let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['/git', 'git --git-dir=%s/.git ls-files - oc --exclude-standalone']
let g:netrw_browse_split=2
let g:netrw_banner=0

let g:ctrlp_use_caching=0
let g:netrw_winsize=25

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
"set undodir=~/.vim/undodir
set undofile
set incsearch
set nu
set number relativenumber
set nu rnu

"autocmd InsertEnter * set cul
"autocmd InsertLeave * set nocul

"Remappings
let mapleader = " "

"Moving between windows
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l

"Resizing windows
noremap <leader>a :vertical resize +10<CR>
noremap <leader>f :vertical resize -10<CR>
noremap <leader>d :resize +10<CR>
noremap <leader>s :resize -10<CR>

"Center for find and join
nnoremap n nzzzv
nnoremap N nzzzv
nnoremap J mzJ`z

"Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Nerdtree
noremap <leader>n :NERDTreeToggle<CR>

"Tabs
noremap <leader>t :tab split<CR>

"Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"Page up and down
noremap J <c-u>
noremap K <c-d>



