return require'packer'.startup(function(use)
  use 'wbthomason/packer.nvim'
  require('meteor.plugins.colortheme').setup(use)
  require('meteor.plugins.common').setup(use)
  require('meteor.plugins.lsp').setup(use)
  require('meteor.plugins.treesitter').setup(use)
  require('meteor.plugins.lines').setup(use)
  require('meteor.plugins.picker').setup(use)
  require('meteor.plugins.tree').setup(use)
  require('meteor.plugins.completion').setup(use)
  require('meteor.plugins.diff').setup(use)
end)

