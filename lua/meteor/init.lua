local M = {}
local log = require('meteor.log')

local function load_lazy_nvim(opt)
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.uv.fs_stat(lazypath) then
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

  require('lazy').setup('meteor.plugins', {
    defaults = {
      lazy = true,
    },
    dev = (function()
      if M.opt.dev then
        return {
          path = '~/.config/nvim/custom-plugins/',
        }
      else
        return nil
      end
    end)(),
  })
end

local function meteor_init()
  -- Map leaders. `mapleader` is used for global commands (switching buffers,
  -- etc.), and `maplocalleader` is used for local commands (mainly for LSP
  -- commands).
  vim.g.mapleader = '\\'
  vim.g.maplocalleader = ' '

  local icons = require('meteor.icons')
  vim.diagnostic.config({
    signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = icons.error,
         [vim.diagnostic.severity.WARN] = icons.warn,
         [vim.diagnostic.severity.INFO] = icons.info,
         [vim.diagnostic.severity.HINT] = icons.hint,
      },
      numhl = {
         [vim.diagnostic.severity.ERROR] = 'DiagnosticNumError',
         [vim.diagnostic.severity.WARN] = 'DiagnosticNumWarn',
         [vim.diagnostic.severity.INFO] = 'DiagnosticNumInfo',
         [vim.diagnostic.severity.HINT] = 'DiagnosticNumHint',
      }
    }
  })
  local function define_diagnostic_sign(name, icon)
    vim.fn.sign_define('DiagnosticSign' .. name, {
      text = icon,
      texthl = 'DiagnosticSign' .. name,
      numhl = 'DiagnosticNum' .. name,
    })
  end

  define_diagnostic_sign('Error', icons.error)
  define_diagnostic_sign('Warn', icons.warn)
  define_diagnostic_sign('Info', icons.info)
  define_diagnostic_sign('Hint', icons.hint)
end

local function meteor_config()
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

  -- See: https://github.com/neovim/neovim/pull/26034
  vim.opt.fsync = false
  -- This is the delay `CursorHold` autocommand will fire
  vim.opt.updatetime = 2000

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
      if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'help' then
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
        vim.api.nvim_set_option_value('undofile', true, { buf = arg.buf })
      end
    end,
  })
end

M.opt = {}

function M.setup(opt)
  if opt ~= nil then
    M.opt = opt
  end
  meteor_init()
  load_lazy_nvim(M.opt)
  require('meteor.mappings').setup()
  meteor_config()
end

function M.is_dev()
  return M.opt.dev
end

function M.is_personal()
  return M.opt.personal
end

M.floating_window_border = {
  '🭽',
  '▔',
  '🭾',
  '▕',
  '🭿',
  '▁',
  '🭼',
  '▏',
}

return M
