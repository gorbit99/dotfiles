vim.cmd [[packadd packer.nvim]]

require('_lualine')
require('_telescope')
require('_lspconfig')
require('_cmp')
require('_todocomments')
require('_luasnip')
require('_indent_blankline')
require('_treesitter')
require('_autopairs')

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    -- run = ':TSUpdate'
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {
      'nvim-lua/plenary.nvim',
      'sharkdp/fd',
      'nvim-telescope/telescope-file-browser.nvim',
    } }
  }

  use 'honza/vim-snippets'
  use 'sainnhe/sonokai'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'vim-scripts/ReplaceWithRegister'
  use 'lervag/vimtex'
  use 'fladson/kitty'
  use 'folke/todo-comments.nvim'
  use 'ThePrimeagen/vim-be-good'
  use 'tpope/vim-repeat'
  use 'easymotion/vim-easymotion'
  use 'llathasa-veleth/vim-brainfuck'
  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'

  use {
    'hrsh7th/nvim-cmp',
    requires = { {
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    } }
  }

  use 'ap/vim-css-color'
  use 'AndrewRadev/tagalong.vim'
  use 'igankevich/mesonic'
  use 'svermeulen/vimpeccable'
  use 'voldikss/vim-floaterm'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'windwp/nvim-autopairs'
end)
