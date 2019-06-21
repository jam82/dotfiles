"===============================================================================
"
"          FILE: .vimrc
" 
"   DESCRIPTION: jam82's .vimrc
" 
"        AUTHOR: Jonas Mauer (jam82), jam@kabelmail.net
"       CREATED: 29.12.2017 19:42:40
"      REVISION: 1.0.0
"
"===============================================================================

set autoindent smartindent      " copy indent from current line
set autoread                    " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set backspace=indent,eol,start  " backspacing over everything in insert mode
set background=dark             " colors for dark background
set browsedir=current           " which directory to use for the file browser
set complete+=k                 " scan files given with the 'dictionary' option
set history=50                  " keep 50 lines of command line history
set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
set mouse="
set nowrap                      " do not wrap lines
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set showmatch
set showmode
"set smartindent                 " smart autoindenting when starting a new line
set visualbell                  " visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu                    " command-line completion in an enhanced mode

"-------------------------------------------------------------------------------
" Use vim native mode, no backup or bloat files, use vcs.
"-------------------------------------------------------------------------------
set nocompatible
set nobackup
set nowb
set noswapfile

"-------------------------------------------------------------------------------
" Tabs and spacing.
"-------------------------------------------------------------------------------
set expandtab
set tabstop=2                   " number of spaces that a <Tab> counts for
set shiftwidth=2                " number of spaces to use for each indent

"-------------------------------------------------------------------------------
" Search options highlight and incremental.
"-------------------------------------------------------------------------------
set hlsearch                    " highlight the last used search pattern
set incsearch                   " do incremental searching

"-------------------------------------------------------------------------------
" Syntax and filetype settings.
"-------------------------------------------------------------------------------
syntax on
filetype on             " enable filetype detection
filetype indent on      " enable filetype-specific indenting
filetype plugin on      " enable filetype-specific plugins
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"-------------------------------------------------------------------------------
" Set title in screen window and reset to previous title after leaving vim.
"-------------------------------------------------------------------------------
if $TERM=~'screen.*'
    set t_ts=k
    set t_fs=\
    auto BufEnter * :set title | let &titlestring = "VIM(" . expand('%') .")"
    auto VimLeave * :set titleold=
endif

"-------------------------------------------------------------------------------
" Some key mappings (K=remove highlighting from search, F2/3 line numbers, etc).
"-------------------------------------------------------------------------------
noremap K :set nohls<CR>
noremap Y y$

noremap <F2> :set nu<CR>
noremap <F3> :set nonu<CR>

"-------------------------------------------------------------------------------
" Visual indication for column 81.
"-------------------------------------------------------------------------------
let &colorcolumn=join(range(81,82),",")
highlight ColorColumn ctermbg=066 guibg=#001D2F
""
"-------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufNewFile,BufRead * :lchdir %:p:h
endif
"
"-------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif " has("autocmd")
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
"
vnoremap ( s()<Esc>P
vnoremap [ s[]<Esc>P
vnoremap { s{}<Esc>P
inoremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
