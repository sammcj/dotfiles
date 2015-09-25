" Sams ~/.vimrc
" Requires git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Launch vim and run vim +BundleInstall +qall

" set verbose command
" set verbose=1

set nocompatible              " be iMproved, required
filetype on
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bigbrozer/vim-nagios'
Plugin 'jonhiggs/MacDict.vim'
Plugin 'jonhiggs/tabline.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'rodjek/vim-puppet'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'
Plugin 'twerth/ir_black'

call vundle#end()

filetype plugin on              " required

set autochdir                   " change to directory of current file.
set backspace=indent,eol,start  " allow backspace to delete before insert point.
set expandtab
set listchars=tab:▸\ ,eol:$     " configure the invisible characters.
set modeline                    " make sure the modeline is used if it exists.
set mouse=a
set nocursorline                " disabled because it makes keyboard repeat too slow.
"set nofoldenable
"set nowrap
set ruler
set scrolloff=8                 " start scrolling before reaching the bottom.
set shiftwidth=2
set showtabline=2
set tabstop=2
set visualbell
let g:airline_theme='dark'

set background=dark
set t_Co=256                    " enable 256 colours.
colorscheme ir_black
" Fix Delete (backspace) on Mac OS X
set backspace=2
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
set ffs=unix
" Do not attempt to fix style on paste
nnoremap <silent> p "+p
syntax on
" Dont add comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


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


"" GitGutter
let g:gitgutter_eager = 1
let g:gitgutter_realtime = 1
let g:gitgutter_sign_column_always = 0
let g:gitgutter_sign_added = '█'
let g:gitgutter_sign_modified = '█'
let g:gitgutter_sign_modified_removed = '▁'
let g:gitgutter_sign_removed = '▁'
let g:gitgutter_sign_removed_first_line = '▔'
autocmd BufEnter     * GitGutterAll
autocmd ShellCmdPost * GitGutterAll

"" Distraction Free Mode F12
let g:goyo_width=85
let g:goyo_margin_top=4
let g:goyo_margin_bottom=4


""
let g:ctrlp_map = '<c-t>'
let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("e")': [],
\ 'AcceptSelection("t")': ['<ct>', '<c-m>'],
\ }
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'


"" KEY MAPPINGS
" Tab Shortcuts
map <C-n> :tabnext<CR>
map <C-p> :tabprevious<CR>

" move between panes.
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" <C-h> is mapped to backspace on ML62. Add a fix in.
nmap <silent> <Backspace> :wincmd h<CR>

" fix current word with first spelling suggestion.
map Z 1z=

" Setup the F Key maps.
set pastetoggle=<F1>
map <F2> :set hlsearch!<CR>
map <F3> :setlocal spell! spell?<CR>

" Redraw Screen
map <F5> :GitGutterAll<CR>:redraw!<CR>

" MacDict
map <F10> "dyiw:call MacDict(@d)<CR>

" Goyo
map <F12> :Goyo<CR>:GitGutterEnable<CR><F5>


