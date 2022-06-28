vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require("_lualine")
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('_treesitter')
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {
      'nvim-lua/plenary.nvim',
      'sharkdp/fd',
      'nvim-telescope/telescope-file-browser.nvim',
    } },
    config = function()
      require('_telescope')
    end
  }

  use 'honza/vim-snippets'
  use 'sainnhe/sonokai'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'vim-scripts/ReplaceWithRegister'
  use 'lervag/vimtex'
  use 'fladson/kitty'
  use {
    'folke/todo-comments.nvim',
    config = function() 
      require('_todocomments')
    end
  }
  use 'ThePrimeagen/vim-be-good'
  use 'tpope/vim-repeat'
  use 'easymotion/vim-easymotion'
  use 'llathasa-veleth/vim-brainfuck'
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require("_lspconfig")
    end
  }
  use {
    'simrat39/rust-tools.nvim',
    config = function()
      require('_rusttools')
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = { {
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    } },
    config = function()
      require("_cmp")
      require('_luasnip')
    end
  }

  use 'ap/vim-css-color'
  use 'AndrewRadev/tagalong.vim'
  use 'igankevich/mesonic'
  use 'svermeulen/vimpeccable'
  use 'voldikss/vim-floaterm'
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('_indent_blankline')
    end
  }
  use {
    'windwp/nvim-autopairs',
    config = function() 
      require('_autopairs')
    end
  }
end)
