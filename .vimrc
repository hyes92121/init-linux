" Run pathogen
execute pathogen#infect()

" Now we can turn our filetype functionality back on
filetype plugin indent on
syntax on

" setup for airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Configuring Vim color scheme
set background=dark
colorscheme jellybeans
" Highlight bkg color 
hi Normal       ctermbg=none
" Highlight none-text
hi NoneText     ctermfg=none
" Highlight Line No. color
hi LineNr       ctermbg=none
" Enable cursorline color
set cursorline
" Highlight cursorline color 
hi CursorLine   ctermbg=none
" Highlight cursorline No. color
hi CursorLineNr ctermfg=white

" Set Vim to show 256 kinds of colors
set t_Co=256			
" Default backspace behaviour
set backspace=indent,eol,start
" Show existing tab with 4 spaces width
set tabstop=4
" When indenting with '>', use 4 spaces width
set shiftwidth=4
" Use softtabstop spaces instead of tab characters for indentation 
set expandtab
" Indent by 4 spaces when pressing <TAB>
set softtabstop=4
" Turn on auto-indent
set autoindent
" Display line numbers
set nu
" Max num of char's is 79
" set textwidth=79
" default vertical split to the right 
set splitright
" enable mouse control
set mouse=a
