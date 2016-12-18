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
call dein#add('ternjs/tern_for_vim', { 'build': 'npm install' })

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
call dein#add('wavded/vim-stylus')

" Linter
call dein#add('neomake/neomake')
call dein#add('airblade/vim-gitgutter')

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
set fileformat=unix

set laststatus=2
set clipboard=unnamedplus

set list
set listchars=eol:¬,trail:█,nbsp:_,tab:»·

set number
set relativenumber

set splitbelow
set splitright

set foldmethod=indent
set foldlevel=99


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

" -- Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_menu_width = 30
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete'
\]
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>
imap <expr> <Tab> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : pumvisible() ? deoplete#mappings#manual_complete() : "\<TAB>"
imap <expr><CR> pumvisible() && neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<CR>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<TAB>"
autocmd InsertLeave * NeoSnippetClearMarkers
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd FileType javascript setlocal omnifunc=tern#Complete

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
autocmd! VimEnter,BufReadPost,BufWritePost * Neomake
let g:neomake_cpp_enabled_makers = ["gcc"]
let g:neomake_highlight_lines = 1
let g:neomake_cpp_clang_maker = {
  \ 'std':'c++11',
  \ 'args': ['-fsyntax-only', '-Wall', '-Wextra'],
  \ 'stdlib':'libc++'
\ }

" -- Compile cpp
nnoremap <silent> <F4> :call vimterm#exec('echo "compiling ' . expand('%') . '" && g++ -m32 -O2 -static -lm -std=c++11 -Wall -Wextra -Werror -Wno-long-long -Wno-variadic-macros -Wsign-compare -fexceptions ' . expand('%') . ' -o /tmp/' . expand('%:t:r') . '.out && echo "compiled without errors"') <CR>
  nnoremap <silent> <F5> :call vimterm#exec('echo "executing ' . expand('%') . '" && /tmp/' . expand('%:t:r') . '.out') <CR>

" -- git
function! Commit()
  if neomake#statusline#LoclistCounts() == {}
    call vimterm#exec('echo "commiting ' . expand('%') . '" && git add ' . expand('%') . ' && git status -s')
  else
    call vimterm#exec('echo "\033[0;31mcannot commit ' . expand('%') . ' due to errors"')
  endif
endfunction
nnoremap <F8> :call Commit()<CR>
nnoremap <F9> :call vimterm#exec('echo "commit message: " && read message && echo "\"$message\"" \| xargs git commit -m')<CR>
nnoremap <F10> :call vimterm#exec('echo pushing to git && git push')<CR>

" -- Terminal movement
tnoremap <Esc> <C-\><C-n>
imap <C-c> <Esc>:w<CR>
tmap <C-c> <Esc><CR>
nmap <C-c> :w<CR>
nnoremap <silent> <F7> :call vimterm#toggle()<CR>
tnoremap <silent> <F7> <C-\><C-n><bar>:call vimterm#toggle()<CR>

" -- Folding
nnoremap <space> za

" -- window switching
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-\><C-n><C-w>h
nnoremap <A-j> <C-\><C-n><C-w>j
nnoremap <A-k> <C-\><C-n><C-w>k
nnoremap <A-l> <C-\><C-n><C-w>l
inoremap <A-h> <C-\><C-n><C-w>h
inoremap <A-j> <C-\><C-n><C-w>j
inoremap <A-k> <C-\><C-n><C-w>k
inoremap <A-l> <C-\><C-n><C-w>l

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
hi SignColumn ctermbg=233
hi Pmenu ctermbg=236
hi PmenuSel ctermfg=117 ctermbg=234
