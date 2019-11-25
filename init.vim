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

"snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'

"dev magic
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
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
nmap <leader>g :Files<cr>
nmap <leader>G :GFiles<cr>
nmap <leader>b :LustyJuggler<cr>
nmap <leader>B :Buffers<cr>
nmap <leader>u :Ag <cword><cr>

nmap <leader>c :split term://bash<cr>
nmap <leader>r :Dispatch<cr>
nmap <leader>j :SplitjoinJoin<cr>
nmap <leader>s :SplitjoinSplit<cr>
nmap <leader>d :windo diffthis<cr>
nmap <leader>D :diffoff!<cr>

nmap <leader>+ <C-W>5+
nmap <leader>- <C-W>5-
nmap <leader>< <C-W>5<
nmap <leader>> <C-W>5>

nmap <Up>    <NOP>
nmap <Down>  <NOP>
nmap <Left>  <NOP>
nmap <Right> <NOP>

"typo rescue
command W execute "w"

"backup settings
set dir=~/.vim/tmp

"filetypes
au BufRead,BufNewFile {Capfile,Guardfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
