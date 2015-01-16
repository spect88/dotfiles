set nocompatible
filetype off

"ruby settings
let g:ruby_path = '/usr/bin'

"plugin management
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'

"dependencies for other plugins
Plugin 'Shougo/vimproc.vim'

"learning
Plugin 'wikitopian/hardmode'
nmap <Up>    <NOP>
nmap <Down>  <NOP>
nmap <Left>  <NOP>
nmap <Right> <NOP>

"tags
Plugin 'majutsushi/tagbar'

"exploring
Plugin 'vim-scripts/LustyJuggler'
Plugin 'Shougo/unite.vim'
Plugin 'tpope/vim-projectionist'
Plugin 'rking/ag.vim'

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_length'])
call unite#custom#source('line', 'matchers', 'matcher_fuzzy')
call unite#custom#source('file_rec/async', 'sorters', 'sorter_length')
call unite#custom#source('file_rec/async', 'matchers', [
    \ 'matcher_fuzzy'
  \])
call unite#custom#profile('default', 'context', {
      \ 'start_insert': 1,
      \ 'direction': 'botright',
      \ 'winheight': 10,
      \ 'candidate_icon': '-',
      \ 'cursor_line_highlight': 'LineNr',
      \ 'prompt': '» '
  \ })
"call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern',
"      \ '\(\.git|node_modules|tmp\)'
"  \ )
"call unite#custom#source('file_rec,file_rec/async', 'ignore_globs', [
"      \ 'tmp/*',
"      \ '*/node_modules/*'
"  \ ])

"snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'garbas/vim-snipmate'

"dev magic
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-commentary'
Plugin 'terryma/vim-multiple-cursors'

"syntax
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-markdown'
Plugin 'nono/vim-handlebars'
Plugin 'groenewege/vim-less'

filetype plugin indent on

"gui setup
if has("gui_running")
  set guioptions=egmrt
  set guifont=Menlo:h14
  colorscheme macvim
  set background=dark
  "hi Normal guifg=white guibg=black
else
  set background=light
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
set ruler
set backspace=2

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
map <leader>t :TagbarToggle<cr>
nmap <leader>g :Unite -buffer-name=files file_rec/async:!<cr>
nmap <leader>G :exec('Unite -buffer-name=files file_rec/async:'.expand("%:p:h"))<cr>
map <leader>b :LustyJuggler<CR>
"nmap <leader>b :Unite -quick-match -buffer-name=buffers buffer<cr>

map <leader>c :ConqueTerm bash<cr>
map <leader>r :Dispatch<cr>
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>
nmap <leader>h :call ToggleHardMode()<cr>

nmap <leader>+ <C-W>5+
nmap <leader>- <C-W>5-
nmap <leader>< <C-W>5<
nmap <leader>> <C-W>5>

"backup settings
set dir=~/.vim/tmp

"disable splitjoin mapping
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

"javascript tweaks
"let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function'

"ignore tmp in CommandT
"set wildignore=tmp/*

"filetypes
au BufRead,BufNewFile {Capfile,Guardfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
