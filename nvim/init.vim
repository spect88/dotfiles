filetype off

"ruby settings
let g:ruby_path = '/usr/bin'

"plugin management
call plug#begin('~/.local/share/nvim/plugged')

"tags
Plug 'majutsushi/tagbar'

"exploration
Plug 'sjbach/lusty'
Plug 'tpope/vim-projectionist'
Plug 'rking/ag.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'liuchengxu/vim-which-key'

"snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'

"dev magic
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'terryma/vim-multiple-cursors'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-syntastic/syntastic'

"syntax
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-markdown'
Plug 'nono/vim-handlebars'
Plug 'groenewege/vim-less'
Plug 'posva/vim-vue'

"load plugins
call plug#end()

filetype plugin indent on

"basic settings
syntax on
set nowrap
set number
set mouse=nvrh
set clipboard=unnamed
set incsearch
set vb
set ruler
set backspace=2
set hidden "lusty explorer wants this
set iskeyword+=- "include '-' in words

"indent
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

"folding settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

"gui
colorscheme torte

"key mappings
let mapleader=","

nmap <leader>t :TagbarToggle<cr>
nmap <leader>l :BLines<cr>
nmap <leader>L :Lines<cr>
nmap <leader>h :Helptags<cr>
nmap <leader>g :Files<cr>
nmap <leader>G :GFiles<cr>
nmap <leader>b :LustyJuggler<cr>
nmap <leader>B :Buffers<cr>
nmap <leader>u :Ag <cword><cr>
nmap <leader>U :Rg<cr>

nmap <leader>c :split term://bash<cr>
nmap <leader>r :Dispatch<cr>
nmap <leader>j :SplitjoinJoin<cr>
nmap <leader>s :SplitjoinSplit<cr>
nmap <leader>d :windo diffthis<cr>
nmap <leader>D :diffoff!<cr>

"Alt (option key) + ,./' for window resizing
nmap ĺ <C-W>2-
nmap ÷ <C-W>2+
nmap ≤ <C-W>2<
nmap ≥ <C-W>2>

nmap <Up>    <NOP>
nmap <Down>  <NOP>
nmap <Left>  <NOP>
nmap <Right> <NOP>

"cd to current file's dir
nmap gp :cd %:p:h<cr>
nmap gP :cd -<cr>

"easier indenting and de-indenting
vnoremap < <gv
vnoremap > >gv

"easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"typo rescue
command! W execute "w"

"backup settings
set dir=~/.vim/tmp

"filetypes
au BufRead,BufNewFile {Capfile,Guardfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
au BufRead,BufNewFile *.sql set commentstring=--%s
au BufRead,BufNewFile *.toml set commentstring=#%s
au BufWritePost $MYVIMRC source %

"syntastic config
let g:syntastic_python_checkers = ['flake8', 'mypy']

"fzf config
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
"^ TODO: investigate vim-clap

"whichkey config
source $HOME/.config/nvim/which_key.vim
