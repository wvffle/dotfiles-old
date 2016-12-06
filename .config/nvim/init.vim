" -- Dein
if &compatible
  set nocompatible " Be iMproved
endif
set runtimepath+=/home/waff/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin('/home/waff/.config/nvim/dein')

" Let dein manage dein
call dein#add('Shougo/deoplete.nvim')

" You Complete Me
"call dein#add('Valloric/YouCompleteMe')

" Deocomplete
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('wvffle/neosnippet-snippets')

" Airline
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" NERDTree
call dein#add('scrooloose/nerdtree')
call dein#add('jistr/vim-nerdtree-tabs')
call dein#add('xuyuanp/nerdtree-git-plugin')

" vimterm
call dein#add('wvffle/vimterm')

" Tagbar
call dein#add('majutsushi/tagbar')

" Cursor
call dein#add('terryma/vim-multiple-cursors')

" Graph undo
call dein#add('sjl/gundo.vim')

" delimitMate
call dein#add('Raimondi/delimitMate')

" Tabularize
call dein#add('godlygeek/tabular')

" Surround.vim
call dein#add('tpope/vim-surround')

" Syntax
call dein#add('plasticboy/vim-markdown')
call dein#add('kchmck/vim-coffee-script')
call dein#add('digitaltoad/vim-pug')

" Linter
call dein#add('neomake/neomake')

" Molokai theme
call dein#add('tomasr/molokai')

call dein#end()

filetype plugin indent on
syntax enable

" -- Install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" -- Neovim Configs

colorscheme molokai
let t_Co = 256
set background=dark

set ttimeout
set ttimeoutlen=50

set expandtab
set shiftwidth=2
set softtabstop=2
set cindent
set copyindent

set laststatus=2
set clipboard=unnamedplus

set list
set listchars=eol:¬,trail:█,nbsp:_,tab:»·

set number
set relativenumber

autocmd! bufwritepost init.vim source %

" -- Plugin Configs

" -- YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_global_ycm_extra_conf = '~/.ycm.py'

" -- Deocomplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_menu_width = 30

inoremap <expr> <Tab>  pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr><CR> pumvisible() && neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<CR>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
autocmd InsertLeave * NeoSnippetClearMarkers

" -- Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="murmur"

" -- NERDTree
let g:NERDTreeWinPos = "right"
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_autofind=1
let NERDTreeMapOpenInTab='<Enter>' " see: jistr/vim-nerdtree-tabs/issues/47#issuecomment-57338002
map <F2> :NERDTreeTabsToggle<CR>

" -- Tagbar
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_compact = 1
nnoremap <F6> :TagbarToggle<CR>

" -- Graph undo
let g:gundo_return_on_revert=0
let g:gundo_width=30
let g:gundo_help=0
nnoremap <F3> :GundoToggle<CR>

" -- delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"let delimitMate_jump_expansion = 2
"let backspace = 2

" -- Neomake
autocmd! BufWritePost * Neomake
autocmd! VimEnter * Neomake
let g:neomake_cpp_enabled_makers = ["gcc"]
let g:neomake_cpp_clang_maker = {
  \ 'std':'c++11',
  \ 'args': ['-fsyntax-only', '-Wall', '-Wextra'],
  \ 'stdlib':'libc++'
\ }
imap <C-c> <Esc>:w<CR>

" -- Compile cpp
nnoremap <silent> <F4> :call vimterm#exec('echo "compiling ' . expand('%') . '" && g++ -m32 -O2 -static -lm -std=c++11 -Wall -Wextra -Werror -Wno-long-long -Wno-variadic-macros -Wsign-compare -fexceptions ' . expand('%') . ' -o /tmp/' . expand('%:t:r') . '.out && echo "compiled without errors"') <CR>
nnoremap <silent> <F5> :call vimterm#exec('echo "executing ' . expand('%') . '" && /tmp/' . expand('%:t:r') . '.out') <CR>

" -- Terminal movement
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <F7> :call vimterm#toggle()<CR>
tnoremap <F7> <C-\><C-n><bar>:call vimterm#toggle()<CR>

" -- Disable arrows
inoremap <Up> <NOP>
vnoremap <Up> <NOP>
nnoremap <Up> <NOP>
inoremap <Down> <NOP>
vnoremap <Down> <NOP>
nnoremap <Down> <NOP>
inoremap <Left> <NOP>
vnoremap <Left> <NOP>
nnoremap <Left> <NOP>
inoremap <Right> <NOP>
vnoremap <Right> <NOP>
nnoremap <Right> <NOP>

" -- Syntax
hi LineNr ctermfg=236 ctermbg=233
