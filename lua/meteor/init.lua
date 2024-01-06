local M = {}
local log = require('meteor.log')

local function load_lazy_nvim(opt)
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  local function get_all_packages(modules)
    local packages = {}
    for _, module in ipairs(modules) do
      local ok, err = pcall(function()
        vim.list_extend(packages, require(('meteor.plugins.%s'):format(module)).packages(opt))
      end)
      if not ok then
        log.error([[failed to load packages from meteor.plugins.%s: %s]], module, err)
      end
    end
    return packages
  end

  local packages = get_all_packages({
    'colorscheme',
    'common',
    'completion',
    'dap',
    'diff',
    'filetype',
    'lines',
    'lsp',
    'picker',
    'snippet',
    'treesitter',
    'experiments',
  })
  require('lazy').setup(packages, {
    defaults = {
      lazy = true,
    },
    dev = {
      path = '~/.config/nvim/custom-plugins/',
    },
  })
end

local function setup_vim_settings()
  -- Set tab size = 2 and use spaces.
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = -1
  vim.opt.expandtab = true

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.cursorline = true

  vim.opt.whichwrap = 'b,s,<,>,[,]'

  vim.opt.timeoutlen = 300
  vim.opt.ttimeoutlen = 50
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
  vim.opt.fillchars =
    'eob: ,horiz:━,horizup:┻,horizdown:┳,vert:┃,vertleft:┫,vertright:┣,verthoriz:╋'
  vim.opt.showbreak = '↳'

  vim.opt.signcolumn = 'yes'
  -- Incremental replace with preview
  vim.opt.inccommand = 'nosplit'
  -- Default splitting to the right.
  vim.opt.splitright = true
  -- Use a single status line
  vim.opt.laststatus = 3
  vim.opt.exrc = true

  local meteor_augroup = vim.api.nvim_create_augroup('MeteorAugroup', {})
  -- Restore the cursor to the line when reopen a file.
  vim.api.nvim_create_autocmd('BufReadPost', {
    group = meteor_augroup,
    callback = function()
      vim.cmd(
        [[if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]]
      )
    end,
  })
  vim.api.nvim_create_autocmd('BufWinEnter', {
    group = meteor_augroup,
    callback = function()
      if vim.api.nvim_buf_get_option(0, 'buftype') == 'help' then
        vim.cmd([[wincmd L]])
      end
    end,
  })
  local homedir = vim.fn.expand('~')
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost', 'FileReadPost' }, {
    group = meteor_augroup,
    pattern = { homedir .. '/Documents/*', homedir .. '/.config/nvim/*' },
    callback = function(arg)
      if arg.buf ~= nil then
        vim.api.nvim_buf_set_option(arg.buf, 'undofile', true)
      end
    end,
  })
end

function M.setup(opt)
  if opt == nil then
    opt = {}
  end
  load_lazy_nvim(opt)
  require('meteor.mappings').setup(opt.mappings)
  setup_vim_settings()
end

return M
