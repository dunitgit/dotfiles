""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" download plugin manager if missing
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugin list
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" detect file
filetype plugin on

" syntax highlighting
syntax enable

" recursively look for files when using gf/find/etc
set path+=**

" wild menu
set wildmenu

" colorscheme
colorscheme gruvbox

" background (light/dark)
set background=dark

" store swap files in central location
let vimtmp = $HOME . '/.vimtmp/'
silent! call mkdir(vimtmp, 'p', 0700)
let &backupdir=vimtmp
let &directory=vimtmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" maximum width of an tab character
set tabstop=4

" indent size
set shiftwidth=4

" number of cols for a TAB
set softtabstop=4

" interpret tabs as spaces
set expandtab

" auto indent detection
set autoindent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual effects
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" highlight search hit
set hlsearch

" highlight hits while typing
set incsearch

" minimal number of screen lines to keep above and below the cursor
set scrolloff=8

" highlight whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" map leader
let mapleader = ','

" <ESC> alternative
inoremap jj <esc>

" toggle highlight search
nnoremap <silent><expr> <Leader>n (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" window closing
noremap <silent><leader>cj :wincmd j<CR>:close<CR>
noremap <silent><leader>ck :wincmd k<CR>:close<CR>
noremap <silent><leader>ch :wincmd h<CR>:close<CR>
noremap <silent><leader>cl :wincmd l<CR>:close<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom commands / functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" create ctags recursively
command! MakeTags !ctags -R .

" diff unsaved changes
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree
let NERDTreeShowHidden = 0
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=40
noremap <silent> <leader>m :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDCommenter
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" ALE
let g:ale_enabled = 0
"let g:ale_linters = {
"\   'python': ['pylint'],
"\}
"
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \}
