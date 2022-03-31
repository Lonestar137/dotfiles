
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
Plug 'Chiel92/vim-autoformat'
Plug 'BurntSushi/ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'townk/vim-autoclose'
Plug 'preservim/nerdtree'
Plug 'sharkdp/fd'
Plug 'Yggdroot/indentLine'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'github/copilot.vim'
"Plug 'wellle/context.vim'
Plug 'romgrk/nvim-treesitter-context'
"syntastic
"Plug 'vim-syntastic/syntastic'

"File searching
Plug 'junegunn/fzf', {'do': {->fzf#install()}}
Plug 'junegunn/fzf.vim'

Plug 'sbdchd/neoformat'


"Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

set completeopt=menu,menuone,noselect


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

" autoformat python program.  Other systems may need just 'python' TODO add support for formatting other languages
let g:python3_host_prog='python3'

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
set scrolloff=10
set shortmess-=F


"set cursorcolumn
"set cursorline

" context.vim
"let g:context_enabled = 1
"let g:context_presenter = 'preview'

"Tree sitter context
"TSContextEnable

" call 'packer.nvim' language servers replaces syntastic
lua require('plugins') 
lua require'lspconfig'.pyright.setup{} 
lua require'lspconfig'.rust_analyzer.setup{}
lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.sqls.setup{}
lua require'lspconfig'.metals.setup{}

"Metals config
augroup lsp
    au!
    au FileType java,scala,sbt lua require("metals").initialize_or_attach({})
augroup end
"metals_config = require("metals").bare_config()
"metals_config.init_options.statusBarProvider = "on"
"vim.g['metals_status']



" syntastic - code error checking
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_wq = 1
"let g:syntatsic_check_on_open = 1
"let g:syntastic_check_on_write = 1
"
""---Note you need to install your linters, ex: sudo apt install pylint
"let g:syntastic_python_checkers = ['flake8', 'pylint']
"let g:syntastic_scala_checkers = ['scalac']
"let g:syntastic_go_checkers = ['golint']
"let g:syntastic_rust_checkers = ['rustc']
"let g:syntastic_java_checkers = ['checkstyle']
"let g:syntastic_sql_checkers = ['sql']
"
"


"autocmd InsertEnter * set cul
"autocmd InsertLeave * set nocul

"Remappings
let mapleader = " "

" Common programming keybindings closer to home row
inoremap <a-j> {}<Esc>i<CR><ESC>O
nnoremap <a-j> i{}<Esc>F{a<CR><BS><ESC>O
inoremap <a-k> []<Esc>i
nnoremap <a-k> i[]<Esc>F[a
inoremap <a-o> ()<Esc>i
nnoremap <a-o> i()<Esc>F[a
nnoremap <a-h> <<
nnoremap <a-l> >>
vnoremap <a-h> <<<ESC>
vnoremap <a-l> >><ESC>
inoremap <a-h> <
inoremap <a-l> >
inoremap <a><a> <Esc>A

"zoom out set to alt + s
"zoom in set to alt + f

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
"nnoremap J mzJ`z

"Moving text
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv


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
noremap J 20jzz
noremap K 20kzz

"Harpoon
noremap T :lua require("harpoon.mark").add_file()<CR>
noremap t :lua require("harpoon.ui").toggle_quick_menu()<CR>


"Jumping around
"TODO add LSP support for jumping to definition and references
nnoremap <C-p> :GFiles<CR>


" make a normale mode remap which create a set of curly braces for me and put
" me in insert mode

"Copilot disable

" Moving in movement history, amazing for switching files.
    " backwards
nnoremap <leader>hh <c-o><CR> 
    " forward
nnoremap <leader>ll <c-i><CR> 
    " swap between two files
nnoremap <leader>j <c-^><CR> 



