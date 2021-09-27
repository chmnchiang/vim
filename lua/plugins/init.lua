local function require_config(name)
  local mod = require('plugins.configs.' .. name)
  if (type(mod) == 'table') then
    return mod.config
  else
    return mod
  end
end

return require'packer'.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
		'chmnchiang/vim-color-scheme-meteor',
    as = 'colorscheme',
	  requires = 'rktjmp/lush.nvim',
	  config = function()
		  vim.opt.termguicolors = true
		  vim.cmd[[colorscheme meteor-nvim]]
    end,
  }
  use {
	  'akinsho/bufferline.nvim',
	  after = 'colorscheme',
	  requires = 'kyazdani42/nvim-web-devicons',
	  config = require_config'bufferline',
  }
  use {
    'chmnchiang/lualine-signify-diff',
  }
  use {
    'hoob3rt/lualine.nvim',
	  after = {'colorscheme', 'lualine-signify-diff'},
    config = require_config'lualine',
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = require_config'nvim_tree',
  }
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require'lsp_signature'.setup { floating_window = false }
    end
  }
  use {
    'neovim/nvim-lspconfig',
    after = 'lsp_signature.nvim',
    config = require_config'lspconfig',
  }
  use {
    'hrsh7th/nvim-compe',
    config = require_config'compe',
  }
  use {
    'tpope/vim-surround'
  }
  use {
    'scrooloose/nerdcommenter'
  }
  use {
    'ntpeters/vim-better-whitespace'
  }
  use {
    'wellle/targets.vim'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    config = require_config'telescope',
  }
  use {
    'sheerun/vim-polyglot',
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = require_config'indent_blankline'
  }
  use {
    'mhinz/vim-signify',
    config = require_config'signify',
  }
  use {
    'ojroques/vim-oscyank',
    config = require_config'oscyank'
  }
  use {
    'rmagatti/auto-session',
  }
end)
