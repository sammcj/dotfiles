set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bigbrozer/vim-nagios'
Plugin 'csexton/trailertrash.vim'
Plugin 'hdima/python-syntax'
Plugin 'jonhiggs/tabline.vim'
"Plugin 'kien/ctrlp.vim'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'bling/vim-airline'
Plugin 'plasticboy/vim-markdown'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/syntastic'
Plugin 'twerth/ir_black'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'

call vundle#end()

filetype plugin indent on

set autochdir                   " change to directory of current file.
set backspace=indent,eol,start  " allow backspace to delete before insert point.
set expandtab
set listchars=tab:▸\ ,eol:$     " configure the invisible characters.
set modeline " make sure the modeline is used if it exists.
set ruler
set scrolloff=8 " start scrolling before reaching the bottom.
set tabstop=2
set visualbell
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
" Default to soft tabs, 2 spaces
set expandtab
set sw=2
set sts=2
" Except for Makefiles
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
" And Markdown
autocmd FileType mkd set sw=4
autocmd FileType mkd set sts=4
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.cql set filetype=cql
nnoremap <silent> p "+p
syntax on
" Dont add comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set background=dark
set t_Co=256                    " enable 256 colours.
colorscheme ir_black

"" RemoveFancyCharacters COMMAND
" Removes smart quotes, etc.
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()


"" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_exit_checks = 0
