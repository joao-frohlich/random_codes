" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir ~/.vim
  silent !mkdir ~/.vim/autoload
  silent !wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.vim/autoload/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'preservim/nerdtree'

call plug#end()

set laststatus=2

map <C-o> :NERDTreeToggle<CR>

map <F7> :tabp<CR>
map <F8> :tabn<CR>

set number
set ruler
set updatetime=500
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
syntax on
