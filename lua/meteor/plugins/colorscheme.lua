return {
  {
    dir = '~/.config/nvim/custom-plugins/vim-color-scheme-meteor',
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd([[colorscheme meteor-nvim]])
    end,
  },
  { 'rktjmp/shipwright.nvim', enabled = require('meteor').is_dev, cmd = { 'Shipwright' } },
  { 'rktjmp/lush.nvim', enabled = require('meteor').is_dev, cmd = { 'Lushify' } },
}
