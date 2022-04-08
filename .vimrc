" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

set laststatus=2

if !has('gui_running')
  set t_Co=256
endif

set noshowmode

let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

map <C-o> :NERDTreeToggle<CR>

let g:user_emmet_install_global = 0
autocmd FileType html,css,php EmmetInstall

map <F7> :tabp<CR>
map <F8> :tabn<CR>

set nu
set updatetime=500
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
