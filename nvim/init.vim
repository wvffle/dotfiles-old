" -- Dein
if &compatible
  set nocompatible " Be iMproved
endif
set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.config/nvim/dein'))

" Let dein manage dein
call dein#add('Shougo/deoplete.nvim')

" Colours
call dein#add('mhartington/oceanic-next')
call dein#add('pangloss/vim-javascript')
call dein#add('othree/html5.vim')
call dein#add('digitaltoad/vim-pug')
call dein#add('wavded/vim-stylus')
call dein#add('clavery/vim-signcolor')
call dein#add('wvffle/vim-css-color')
call dein#add('ryanoasis/vim-devicons')
" have to fix conceal
"call dein#add('Yggdroot/indentLine')

" Completion
call dein#add('Shougo/deoplete.nvim')
call dein#add('ternjs/tern_for_vim', {'build': 'npm install'})
call dein#add('carlitux/deoplete-ternjs', {'on_ft': 'javascript'})
call dein#add('othree/jspc.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('wvffle/neosnippet-snippets')

" Linter
call dein#add('neomake/neomake')
call dein#add('airblade/vim-gitgutter')

" Functionality
call dein#add('qpkorr/vim-bufkill')
call dein#add('bling/vim-bufferline')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('Raimondi/delimitMate')
call dein#add('tpope/vim-surround')
call dein#add('wvffle/vimterm')

" NERDTree
call dein#add('scrooloose/nerdtree')
call dein#add('xuyuanp/nerdtree-git-plugin')
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

call dein#end()

filetype plugin indent on
syntax enable

" -- Install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

set t_Co=256
set t_8f=\[[38;2;%lu;%lu;%lum
set t_8b=\[[48;2;%lu;%lu;%lum
set termguicolors
set background=dark
colorscheme OceanicNext
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
set noswapfile
set undofile

set list
set listchars=eol:¬,trail:█,nbsp:_,tab:»·,nbsp:~

set number
set relativenumber

set splitbelow
set splitright

set foldmethod=indent
set foldlevel=99

set scrolloff=6


" global {{{
inoremap <silent> <c-c> <c-[>
nmap <silent> <c-c> :silent write<cr>
" }}}

" Syntax {{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
set conceallevel=1

autocmd FileType stylus if get(b:, 'is_signs_set', 0) == 0 | call signcolor#toggle_signs_for_colors_in_buffer() | endif
autocmd FileType javascript setlocal foldmethod=syntax
" }}}

" deoplete {{{
set completeopt=noinsert,menu,menuone
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#omni#functions = get(g:, 'deoplete#omni#functions', {})
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

function! Cr()
  echo getline('.')[col('.')-2:col('.')-1]
  if pumvisible()
    if neosnippet#expandable()
      call feedkeys("\<Plug>(neosnippet_expand)")
      return ""
    else
      " add omni complete
      return "\<cr>"
    endif
  else
    if getline('.')[col('.')-2:col('.')-1] == '{}'
      return "\<cr>\<Esc>O"
    else
      return "\<cr>"
    endif
  endif
endfunction

imap <cr> <c-r>=Cr()<cr>
imap <C-Space> <C-x><C-o>
imap <silent><expr> <C-Space> deoplete#mappings#manual_complete()

inoremap <silent> <expr> <Tab> pumvisible() ? deoplete#mappings#manual_complete() : '<Tab>'
inoremap <silent> <S-Tab> <C-P>
inoremap <silent> <C-J> <C-N>
inoremap <silent> <C-K> <C-P>

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern_show_signature_in_pum = 1
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}

" neomake {{{
let g:neomake_cpp_enabled_makers = ["gcc"]
let g:neomake_highlight_lines = 1
let g:neomake_cpp_clang_maker = {
  \ 'std':'c++11',
  \ 'args': ['-fsyntax-only', '-Wall', '-Wextra'],
  \ 'stdlib':'libc++'
\ }
let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')
let g:neomake_javascript_enabled_makers = ['eslint', 'jscs']
" }}}

" statusline {{{
fun! Symbol()
  return WebDevIconsGetFileTypeSymbol()
endfun
set statusline=%=\ %{Symbol()}%t%m\ %=
" }}}

" style {{{
hi! VertSplit guibg=none guifg=#343d46
hi! StatusLine guibg=none
hi! StatusLineNC guibg=none
set fillchars+=vert:\▕,stlnc:\ ,stl:=
" }}}

" window switching {{{
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
" }}}}

" addons {{{
fun! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfun
augroup whitespace
  autocmd!
  autocmd BufWrite * :call DeleteTrailingWS()
augroup END
" }}}

" IDE functionality {{{

let mapleader = ","
let s:tree = 1
let s:tree_side = 'right'
let s:tree_size = 30

let s:tags_side = 'left'

let s:workspace = win_getid()

let g:NERDTreeWinPos = s:tree_side
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize = s:tree_size

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

fun! NerdBuf()
  return get(t:, 'NERDTreeBufName', -1)
endfun
fun! NerdWin()
  let a:res =  NerdBuf()
  if a:res != -1
    let a:res = bufwinnr(a:res)
  endif
  let s:tree_win = a:res
  return a:res
endfun

fun! ChangeTab(pos)
  let a:win = win_getid()
  if a:win != s:workspace
    call win_gotoid(s:workspace)
  endif
  if a:pos == 'h'
    bprevious
  elseif a:pos == 'l'
    bnext
  endif
  if a:win != s:workspace
    call win_gotoid(a:win)
  endif
endfun

fun! Quit() abort
  let a:win = win_getid()
  if a:win != s:workspace
    call win_gotoid(s:workspace)
  endif
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) <= 1
    qa
  else
    BD
  endif
  if a:win != s:workspace
    call win_gotoid(a:win)
  endif
endfun

nnoremap <silent> qq :call Quit()<cr>
nnoremap <silent> <Tab> :call ChangeTab('l')<cr>
nnoremap <silent> <S-Tab> :call ChangeTab('h')<cr>
nnoremap <silent> <F4> :call vimterm#exec('g++ -o /tmp/out ' . expand('%')) <cr>
nnoremap <silent> <F5> :call vimterm#exec('/tmp/out') <cr>
nnoremap <leader>t :call vimterm#toggle()<cr>
tnoremap <leader>t <c-\><c-n>:call vimterm#toggle()<cr>

augroup ide
  autocmd!
  autocmd VimEnter * if s:tree == 1 | NERDTree | let s:tree_win = NerdWin() | endif
  autocmd VimEnter * call win_gotoid(s:workspace) | Neomake
  autocmd TextChangedI,TextChanged * if win_getid() == s:workspace | Neomake | endif
  autocmd TextChanged,InsertLeave * if win_getid() == s:workspace | Neomake | silent write | endif
  " TODO: Try to direct edit command to workspace
  autocmd BufHidden * if win_getid() == s:tree_win | q | NERDTree | endif
augroup END

" }}}

fun! PreSource()
  let a:ntree = NerdWin()
  if a:ntree != -1
    NERDTreeClose
  endif
  return a:ntree
endfun
autocmd! BufWritePost init.vim let s:n = PreSource() | source % | if s:n != -1 | NERDTree | endif
