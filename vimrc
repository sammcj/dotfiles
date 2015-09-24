set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bigbrozer/vim-nagios'
Plugin 'jonhiggs/MacDict.vim'
Plugin 'jonhiggs/tabline.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'rodjek/vim-puppet'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'

call vundle#end()

"filetype plugin indent on

set autochdir                   " change to directory of current file.
set backspace=indent,eol,start  " allow backspace to delete before insert point.
set expandtab
set listchars=tab:▸\ ,eol:$     " configure the invisible characters.
set modeline                    " make sure the modeline is used if it exists.
set mouse=a
set nocursorline                " disabled because it makes keyboard repeat too slow.
set nofoldenable
"set nowrap
set ruler
set scrolloff=8                 " start scrolling before reaching the bottom.
set shiftwidth=2
set showtabline=2
set tabstop=2
set visualbell

set background=dark
set t_Co=256                    " enable 256 colours.
colorscheme ir_black
" Fix Delete (backspace) on Mac OS X
set backspace=2
" Default to soft tabs, 2 spaces
set expandtab
set sw=2
set sts=2
" Except for Makefiles: Hard tabs of width 2
autocmd FileType make set ts=2
" And Markdown
autocmd FileType mkd set sw=4
autocmd FileType mkd set sts=4
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.cql set filetype=cql
set ffs=unix
" Do not attempt to fix style on paste
nnoremap <silent> p "+p
syntax on

"" Powerline settings
set laststatus=2
set noshowmode
let g:Powerline_stl_path_style = "short"


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
let g:syntastic_check_on_wq = 0


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

"" Custom Spell Check and Dictionary
set nospell
set spelllang=en_au
set encoding=utf-8

if empty(glob("~/vim/dict/custom-dictionary.utf-8.add.spl"))
  mkspell ~/vim/dict/custom-dictionary.utf-8.add
endif

set spellfile=~/vim/dict/custom-dictionary.utf-8.add
set dict=~/vim/dict/custom-dictionary.utf-8.add
set dict+=~/vim/dict/en_au-words.txt
set complete=.          " current buffer
set complete+=w         " buffers in other windows
set complete+=b         " other loaded buffers
set complete+=t         " tags
set complete+=i         " included files
set complete+=k         " dictionaries

" SOME SHORTCUTS I'M GOING TO FORGET.
"
"     1z=           substitute word for first suggested word.
"     [s            go to last spelling mistake.
"     ]s            go to next spelling mistake.
"     `]            move to the last insert point.
"     ``            go back to whence you came.
"     zg            the word is good.
"     zw            the word is wrong.


"" KEY MAPPINGS
" Tab Shortcuts
map <C-n> :tabnext<CR>
map <C-p> :tabprevious<CR>

" gq the paragraph (Q was EX mode which I don't like or use)
map Q gqip

" Make Y behave like other capitals
map Y y$

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

