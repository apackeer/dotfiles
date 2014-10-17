" Make Vim more useful
set nocompatible
" Setup Pathogen
filetype on
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
" Turn on Syntax highlighting
syntax on
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
" set clipboard=unamed
" Allow cursor keys in insert mode
set esckeys
" ALlow backspace in insert mode
set backspace=indent,eol,start
"Optimize for fast terminal connections
set ttyfast
" Set up Solarized color scheme
set background=dark
colorscheme solarized
" Make tabs as wide as four spaces (PEP8)
set tabstop=4
" How many columns vim uses when you hit tab in insert mode (PEP8)
set softtabstop=4
" Exapand tabs to spaces (PEP8)
set expandtab
" How many columns text is indented with reindents
set shiftwidth=4
" Indent/Outdent to nearest tabstops
set shiftround
" Show mode at the bottom of the screen
set showmode
" Don't wrap lines
set nowrap
" Autoindent where possible
set autoindent
" Copy previous line indentation
set copyindent
" Show line numbers
set number
" Show matches found in searches
set showmatch
" Ignore all case in searches
set ignorecase
" Override ignorecase if search patterns contain uppercase
set smartcase
" Insert tabs on linebreaks
set smarttab
" Keep four lines when scrolling
set scrolloff=4
" Move about wherever you want
set virtualedit=all
" Do incremental searching
set incsearch
" Search globally by default
set gdefault
" Display tabs, trailing spaces, etc
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
" Wrap existing text
set nolist
" Toggle paste mode (so doesn't produce waterfall text)
set pastetoggle=<F2>
" Use the mouse in all windows
set mouse=a
" Support all EOL formats
set fileformats="unix,dos,mac"
