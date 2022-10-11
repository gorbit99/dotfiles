local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local use_rocks = require('packer').use_rocks

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'simrat39/rust-tools.nvim',
      'mfussenegger/nvim-dap',
      'jose-elias-alvarez/null-ls.nvim',
      'MunifTanjim/prettier.nvim',
    },
    config = function()
      require('user.lsp')
    end,
  }

  use {
    'jacoborus/tender.vim',
    config = function()
      require('user.colorscheme')
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function()
      require('user.treesitter')
    end,
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require("nvim-autopairs").setup {} end
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('user.cmp')
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require 'user.telescope'
    end,
    after = 'project.nvim'
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'user.indent_blankline'
    end
  }

  use {
    'kylechui/nvim-surround',
    config = function()
      require("nvim-surround").setup {}
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {}
    end,
  }

  use {
    'svermeulen/vimpeccable',
    config = function()
      require('user.vimpeccable')
    end
  }

  use_rocks 'inspect'

  use {
    '/Projects/NeovimPlugins/minimap',
    rocks = { 'luautf8' },
    config = function()
      require('minimap').setup()
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
