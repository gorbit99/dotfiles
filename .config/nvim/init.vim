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
set signcolumn=yes

call plug#begin('~/.config/nvim/plugged')
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'honza/vim-snippets'
    Plug 'itchyny/lightline.vim'
    Plug 'jiangmiao/auto-pairs'
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdtree'
    Plug 'sainnhe/sonokai'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'vim-scripts/ReplaceWithRegister'
    Plug 'mustache/vim-mustache-handlebars'
    Plug 'lervag/vimtex'
    Plug 'fladson/kitty'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'folke/todo-comments.nvim'
    Plug 'ThePrimeagen/vim-be-good'
    Plug 'tpope/vim-repeat'
    Plug 'easymotion/vim-easymotion'
    Plug 'yggdroot/indentline'
    Plug 'llathasa-veleth/vim-brainfuck'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'SirVer/ultisnips'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
call plug#end()

let mapleader = " "

"  Handle vimrc
nnoremap <silent><leader>rc :source ~/.config/nvim/init.vim<CR>
nnoremap <silent><leader>orc :sp ~/.config/nvim/init.vim<CR>

color sonokai

packadd termdebug
let g:termdebug_wide=1

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


nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.git|CMakeFiles|node_modules|target|compiled|dist$',
    \ 'file': '\v\.(o)|.lock$'
    \ }
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 0


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



" highlight CocRustTypeHint guifg=#666666
" highlight CocRustChainingHint guifg=#666666



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
    
    " Tabstop
    au FileType json set tabstop=2
    au FileType json set shiftwidth=2

    au FileType css,scss set tabstop=2
    au FileType css,scss set shiftwidth=2

    au FileType html,html.handlebars set tabstop=2
    au FileType html,html.handlebars set shiftwidth=2

    au FileType brainfuck set tabstop=2
    au FileType brainfuck set shiftwidth=2
augroup END

nnoremap <silent> <leader>ss :nohl<cr>

nmap <c-w><c-l> :set scrollback=1 \| sleep 100m \| set scrollback=10000<cr>
tmap <c-w><c-l> <c-\><c-n><c-w><c-l>i<c-l>



let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ 'active': {
      \   'left': [ 
      \     [ 'mode', 'paste' ],
      \     [ 'gitbranch', 'readonly', 'diredfilename', 'modified' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ 'component': {
      \   'diredfilename': '%{expand("%:h:t")."/".expand("%:t")}'
      \ }
      \ }


function CtrlJTerm()
    if bufexists("ctrlJTerm")
        botright :sbuffer ctrlJTerm
        normal i
    else
        :botright split
        :term
        :file ctrlJTerm
        normal i
    endif
endfunction

nnoremap <C-j> :call CtrlJTerm()<CR>
tnoremap <C-j>  <C-\><C-n><C-w>c

lua << EOF
  require("todo-comments").setup {
    keywords = {
        FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            },
            TODO = { icon = "⭘", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
    }
EOF


nnoremap <leader>tl <silent> :TodoLocList<cr>


let g:hardtime_default_on = 1


lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

lspconfig.clangd.setup {
    on_attach = on_attach,
    default_config = {
        cmd = {
            "clangd", "--background-index", "--pch-storage=memory",
            "--clang-tidy", "--suggest-missing-includes"
        },
        filetypes = {"c", "cpp", "objc", "objcpp"},
    }
}

lspconfig.texlab.setup{}

lspconfig.solargraph.setup{}

vim.o.completeopt = 'menuone'

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
  },
}
EOF

augroup lsp
    autocmd!
    autocmd BufWritePre *.h,*.c,*.cpp lua vim.lsp.buf.formatting_sync()
augroup END
