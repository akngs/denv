call plug#begin('~/.local/share/nvim/plugged')
Plug 'editorconfig/editorconfig-vim'
call plug#end()

" True color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
