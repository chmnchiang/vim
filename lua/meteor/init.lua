local M = {}

local function setup_colorscheme()
  vim.opt.termguicolors = true
  vim.cmd [[colorscheme meteor-nvim]]
end

local function setup_vim_settings()
  vim.opt.expandtab = true
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.cursorline = true

  vim.opt.whichwrap = 'b,s,<,>,[,]'

  vim.opt.timeoutlen = 300
  vim.opt.ttimeoutlen = 20
  -- Keep four lines above and below the cursor
  vim.opt.scrolloff = 4
  vim.opt.startofline = false
  vim.opt.hidden = true
  -- Disable conceal (some plugin might set it, force it to be 0)
  vim.opt.conceallevel = 0

  vim.opt.foldenable = true
  vim.opt.foldmethod = 'marker'
  -- Remove the annoying preview window
  vim.opt.completeopt:remove('preview')
  vim.opt.pumheight = 15

  vim.opt.list = true
  vim.opt.listchars = 'tab:» ,extends:›,precedes:‹,nbsp:·,trail:·'
  vim.opt.showbreak = '↳'

  vim.opt.signcolumn = 'yes'
  -- Incremental replace with preview
  vim.opt.inccommand = 'nosplit'
  -- Default splitting to the right.
  vim.opt.splitright = true
  -- Use a single status line
  vim.opt.laststatus = 3
  -- Restore the cursor to the line when reopen a file.
  vim.cmd [[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]]
  -- Open :help vertically
  vim.cmd [[
    augroup vimrc_help
    autocmd!
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
    augroup END
  ]]
end

function M.setup(opt)
  if opt == nil then
    opt = {}
  end
  -- Setup colorscheme first because a lot of config use it.
  setup_colorscheme()
  -- Setup plugins
  require'packer'.startup(function(use)
    use 'wbthomason/packer.nvim'
    require('meteor.plugins.colortheme').setup(use)
    require('meteor.plugins.common').setup(use)
    require('meteor.plugins.lsp').setup(use)
    require('meteor.plugins.treesitter').setup(use)
    require('meteor.plugins.lines').setup(use)
    require('meteor.plugins.picker').setup(use)
    require('meteor.plugins.snippet').setup(use)
    require('meteor.plugins.tree').setup(use)
    require('meteor.plugins.completion').setup(use)
    require('meteor.plugins.diff').setup(use)
    require('meteor.plugins.dap').setup(use)
    require('meteor.plugins.experiments').setup(use)
  end)
  setup_vim_settings()
  require('meteor.mappings').setup(opt.mappings)
end

return M
