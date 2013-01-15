set nocompatible
filetype off

"ruby settings
let g:ruby_path = '/usr/bin'

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

"taglist
Bundle 'int3/vim-taglist-plus'
Bundle 'mozilla/doctorjs'

"exploring
Bundle 'vim-scripts/LustyJuggler'
Bundle 'wincent/Command-T'

"snippets
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/snipmate-snippets'
Bundle 'garbas/vim-snipmate'

"dev magic
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'AndrewRadev/splitjoin.vim'

"console
Bundle 'rson/vim-conque'

"syntax
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-markdown'
Bundle 'nono/vim-handlebars'

filetype plugin indent on

"gui setup
if has("gui_running")
  set guioptions=egmrt
  set guifont=Menlo:h14
  colorscheme macvim
  "hi Normal guifg=white guibg=black
else
  colorscheme default
  " koehler
endif

"basic settings
syntax on
set nowrap
set number
set mouse=nvrh
set clipboard=unnamed
set incsearch
set vb

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

"key mappings
let mapleader=","
map <leader>t :TlistToggle<CR>
map <leader>g :CommandT<CR>
map <leader>b :LustyJuggler<CR>
map <leader>c :ConqueTerm bash<CR>
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>

"backup settings
set dir=~/.vim/tmp

"disable splitjoin mapping
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

"javascript tweaks
let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function'

"ignore tmp in CommandT
set wildignore=tmp/*

"filetypes
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
