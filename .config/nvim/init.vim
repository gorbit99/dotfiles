set autoindent
set backupcopy=yes
set bg=dark
set bs=indent,eol,start
set colorcolumn=+1
set emo
set equalalways
set expandtab
set fileignorecase
set foldlevelstart=99
set foldmethod=marker
set hidden
set history=1000
set hlsearch
set ignorecase
set inccommand=nosplit
set incsearch
set linebreak
set magic
set mouse=
set nocompatible
set noerrorbells
set number
set numberwidth=3
set relativenumber
set ruler
set scrolloff=5
set shiftround
set shiftwidth=4
set smartcase
set smartindent
set smarttab
set softtabstop=-1
set splitbelow
set splitright
set tabstop=4
set termguicolors
set textwidth=80
set title
set wildignorecase
set wildignore+=*/tmp/*,*.so,*.swp
set wildmenu

call plug#begin('~/.config/nvim/plugged')
    Plug 'Mathijs-Bakker/vim-unity-snippets'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'honza/vim-snippets'
    Plug 'itchyny/lightline.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdtree'
    Plug 'sainnhe/sonokai'
    Plug 'tikhomirov/vim-glsl'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rails'
    Plug 'tpope/vim-surround'
    Plug 'vim-scripts/ReplaceWithRegister'
    Plug 'wfxr/minimap.vim'
call plug#end()

let mapleader = " "

"  Handle vimrc
nnoremap <leader>rc :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>orc :sp ~/.config/nvim/init.vim<CR>

color sonokai

augroup markdown
    autocmd!
    autocmd BufWritePost *.md :silent !pandoc "%" -o "%:r.pdf"
augroup END

packadd termdebug

nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>qf <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <silent> <leader>ef :normal call CocAction('format')<CR>

let g:fold_options = {
   \ 'fallback_method' : { 'line_threshold' : 2000, 'method' : 'syntax' },
   \ 'fold_blank': 0,
   \ 'fold_includes': 0,
   \ 'max_foldline_length': 'win',
   \ 'merge_comments' : 1,
   \ 'show_if_and_else': 1,
   \ 'strip_namespaces': 1,
   \ 'strip_template_arguments': 1
   \ }



imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
xmap <leader> <Plug>(coc-convert-snippet)



nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif



let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.git|CMakeFiles|node_modules|target|compiled$',
    \ 'file': '\v\.(o)|.lock$'
    \ }
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_mruf_relative = 1


autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <leader>hl :call CocAction("pickColor")<CR>

let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
let g:minimap_highlight_range = 1

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && bufname(@%) == '-MINIMAP-' | quit | endif


augroup misc
    au!
    autocmd FileType cpp setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END


function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

map <leader>ch :call SynStack()<CR>



highlight CocRustTypeHint guifg=#666666
highlight CocRustChainingHint guifg=#666666



nnoremap <leader>hm :Hexmode<CR>

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction


" Filetypes
augroup Filetypes
    autocmd!
    
    au BufRead,BufNewFile *.hbs setfiletype handlebars
    au BufRead,BufNewFile *.tera setfiletype html
augroup END
