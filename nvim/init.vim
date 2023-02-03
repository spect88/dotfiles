filetype off

"plugin management
call plug#begin('~/.local/share/nvim/plugged')

"exploration
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-vinegar'
Plug 'rking/ag.vim'
Plug 'folke/which-key.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim'

"snippets
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*'}
Plug 'benfowler/telescope-luasnip.nvim'
Plug 'honza/vim-snippets'

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
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'j-hui/fidget.nvim'

"completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind.nvim'

"syntax / file type support
Plug 'kchmck/vim-coffee-script'
Plug 'nono/vim-handlebars'
Plug 'darfink/vim-plist'
Plug 'junegunn/vim-journal'
Plug 'sainnhe/sonokai'

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
set hidden
set iskeyword+=- "include '-' in words
set splitright
lang en_US.UTF-8
set timeoutlen=500 "for whichkey
set updatetime=250 "for auto-showing diagnostics

"indent
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

"folding settings
set foldnestmax=10
set nofoldenable
set foldlevel=1
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"gui
if $COLORFGBG == "0;15"
  colorscheme desert
else
  colorscheme sonokai
endif

"key mappings
let mapleader=","

nmap <leader>l :Telescope current_buffer_fuzzy_find<cr>
nmap <leader>h :Telescope help_tags<cr>
nmap <leader>g :Telescope find_files<cr>
nmap <leader>G :Telescope git_files<cr>
nmap <leader>b :Telescope buffers sort_mru=true ignore_current_buffer=true initial_mode=normal path_display=['tail']<cr>
nmap <leader>B :Telescope buffers<cr>
nmap <leader>S :Telescope luasnip<cr>
nmap <leader>u :Ag <cword><cr>
nmap <leader>U :Telescope grep_string<cr>
nmap <leader>n :vsplit ~/Documents/notes/vim.md<cr>
nmap <leader>N :Telescope find_files cwd=~/Documents/notes/<cr>
nmap <leader>e :e $MYVIMRC<cr>
nmap <leader>E :e ~/.config/nvim/lua/my-config.lua<cr>
nmap <leader>m :lua require('harpoon.ui').toggle_quick_menu()<cr>
nmap <leader>M :lua require('harpoon.mark').add_file()<cr>

nmap <leader>c :split term://fish<cr>
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
nmap <M-'> <C-W>2-
nmap <M-/> <C-W>2+
nmap <M-,> <C-W>2<
nmap <M-.> <C-W>2>

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

"don't touch unnamed register when pasting over visual selection
xnoremap <expr> p 'pgv"' . v:register . 'y'

"easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"typo rescue
command! W execute "w"
command! Q execute "q"
cnoreabbrev <expr> E getcmdtype()==':'&&getcmdline()=~#'^E'?'e':'E'


"backup settings
set dir=~/.vim/tmp

"filetypes
if !exists('g:filetype_callbacks_set_up')
  au BufRead,BufNewFile {Capfile,Guardfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
  au BufRead,BufNewFile *.sql set commentstring=--%s
  au BufRead,BufNewFile *.toml set commentstring=#%s
  au BufRead,BufNewFile *.fish set ft=bash
  au BufRead,BufNewFile *.note set ft=journal
  au BufRead,BufNewFile .simplebarrc set ft=json
  au BufWritePost $MYVIMRC source %
  let g:filetype_callbacks_set_up = 1
endif

"splitjoin config
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_hanging_args = 0

"snippets config
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

"autoclose preview buffer when leaving completion 
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

lua require('my-config')
