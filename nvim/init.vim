" -- Dein
if &compatible
  set nocompatible " Be iMproved
endif
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin('~/.config/nvim/dein')

" Let dein manage dein
call dein#add('Shougo/deoplete.nvim')

" Buffers
call dein#add('qpkorr/vim-bufkill')

" Deocomplete
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('wvffle/neosnippet-snippets')
call dein#add('ternjs/tern_for_vim', { 'build': 'npm install' })
call dein#add('othree/jspc.vim')
call dein#add('zchee/deoplete-clang')

" Airline
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" NERDTree
call dein#add('scrooloose/nerdtree')
call dein#add('jistr/vim-nerdtree-tabs')
call dein#add('xuyuanp/nerdtree-git-plugin')
"call dein#add('ryanoasis/vim-devicons')
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

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
call dein#add('othree/yajs.vim')
call dein#add('othree/html5.vim')

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

"colorscheme molokai
let t_Co = 256
set background=dark
set cursorline

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

set scrolloff=6


autocmd! bufwritepost init.vim source %

" -- Plugin Configs

" -- Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_menu_width = 30
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/include/c++/6.2.1'
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>
imap <C-j> <C-N>
imap <C-k> <C-P>
imap <expr> <Tab> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : pumvisible() ? deoplete#mappings#manual_complete() : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<TAB>"
function! Complete()
  if synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name") == "String"
    return
  endif
  if index([ "js", "coffee", "cpp" ], expand('%:e')) >= 0
    if getline('.')[col('.')-2] == '.'
      call feedkeys("\<C-x>\<C-o>")
    endif
  endif
  if index([ "cpp" ], expand('%:e')) >= 0
    if getline('.')[col('.')-3:col('.')-2] == '->'
      call feedkeys("\<C-x>\<C-o>")
    endif
  endif
endfunction
autocmd CursorMovedI  * call Complete()
autocmd InsertLeave * NeoSnippetClearMarkers
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd FileType javascript setlocal omnifunc=tern#Complete

" -- Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="zenburn"

" -- NERDTree
let g:NERDTreeWinPos = "right"
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_autofind=1
let g:NERDTreeIgnore=['node_modules$[[dir]]']
let g:NERDTreeMinimalUI=1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "o",
    \ "Renamed"   : ">",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "-",
    \ "Dirty"     : "x",
    \ "Clean"     : "v",
    \ "Unknown"   : "?"
    \ }
map <F2> :NERDTreeTabsToggle<CR>
autocmd FileType nerdtree setlocal nolist

function! PanelOpen() abort
  :TagbarOpen
  wincmd h
  let a:tagbar=bufnr('%')
  :TagbarClose
  :GundoShow
  sp
  wincmd k
  exec 'buffer ' . a:tagbar
  wincmd j
  wincmd j
  exec 'resize ' . g:vimterm_height
  wincmd k
  wincmd l
endfunction
function! PanelClose() abort
  :GundoHide
  :TagbarClose
endfunction

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

" -- Easier insert navigation
function! Colon()
  if getline('.')[col('.')-1:-1] =~ ')$'
    return "\<End>;"
  elseif getline('.')[col('.')-1] == ';'
    return "\<Right>"
  endif
  return ';'
endfunction
inoremap <A-;> <End>
imap ; <C-R>=Colon()<CR>

function! Cr()
  echo getline('.')[col('.')-2:col('.')-1]
  if pumvisible()
    if neosnippet#expandable()
      call feedkeys("\<Plug>(neosnippet_expand)")
      return ""
    else
      " add omni complete
      return "\<CR>"
    endif
  else
    if getline('.')[col('.')-2:col('.')-1] == '{}'
      return "\<CR>\<Esc>O"
    else
      return "\<CR>"
    endif
  endif
endfunction
imap <CR> <C-R>=Cr()<CR>

" -- Neomake
autocmd! VimEnter,BufReadPost,BufWritePost * Neomake
let g:neomake_cpp_enabled_makers = ["gcc"]
let g:neomake_highlight_lines = 1
let g:neomake_cpp_clang_maker = {
  \ 'std':'c++11',
  \ 'args': ['-fsyntax-only', '-Wall', '-Wextra'],
  \ 'stdlib':'libc++'
\ }
let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')
let g:neomake_javascript_enabled_makers = ['eslint', 'jscs']

" -- Compile
let g:msg_compiling = 'echo "compiling ' . expand('%') . '"'
function! FileExists(file)
  return filereadable(getcwd() . "/" . a:file)
endfunction
function! CompileJS()
  if FileExists("gruntfile.js") || FileExists("gruntfile.coffee")
    call vimterm#exec(g:msg_compiling . ' && grunt')
  else
    call vimterm#exec(g:msg_compiling . ' && npm run build')
  endif
endfunction
nmap <silent> <F4> :echo "No compiler detected"<CR>
autocmd FileType javascript nmap <silent> <F4> :call CompileJS()<CR>
autocmd FileType cpp nmap <silent> <F4> :call vimterm#exec(g:msg_compiling . ' && g++ -m32 -O2 -static -lm -std=c++11 -Wall -Wextra -Werror -Wno-long-long -Wno-variadic-macros -Wsign-compare -fexceptions ' . expand('%') . ' -o /tmp/' . expand('%:t:r') . '.out && echo "compiled without errors"') <CR>

autocmd FileType cpp nmap <silent> <F5> :call vimterm#exec('echo "executing ' . expand('%') . '" && /tmp/' . expand('%:t:r') . '.out') <CR>
autocmd FileType javascript nmap <silent> <F5> :call vimterm#exec('npm run -s test \|\| electron . \|\| node .')<CR>

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

" -- Buffer switching
nnoremap <Tab> :bn<cr>
nnoremap <S-Tab> :bp<cr>
function! Quit() abort
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    q
  else
    BD
  endif
endfunction
nnoremap <silent> qq :call Quit()<cr>

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
hi LineNr ctermfg=236 ctermbg=none
hi SignColumn ctermbg=233
hi Pmenu ctermbg=236
hi PmenuSel ctermfg=117 ctermbg=234
hi CursorLine ctermbg=234
hi CursorLineNr ctermbg=234
hi Normal ctermbg=none
hi VertSplit ctermfg=234
