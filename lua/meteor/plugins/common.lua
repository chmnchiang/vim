local M = {}

local function nvim_tree_config()
  local icons = require('meteor.icons')

  require('nvim-tree').setup({
    respect_buf_cwd = false,
    diagnostics = {
      enable = true,
      icons = {
        error = icons.error,
        warning = icons.warn,
        hint = icons.hint,
        info = icons.info,
      },
    },
    view = {
      side = 'right',
    },
  })
end

local function comment_nvim_keys()
  return {
    {
      '<Space>c<Space>',
      function()
        if vim.api.nvim_get_vvar('count') == 0 then
          return '<Plug>(comment_toggle_linewise_current)'
        else
          return '<Plug>(comment_toggle_linewise_count)'
        end
      end,
      expr = true,
      desc = 'Toggle the comment of current line',
    },
    {
      '<Space>c<Space>',
      '<Plug>(comment_toggle_linewise_visual)',
      mode = 'x',
      desc = 'Toggle comment with linewise style',
    },
    {
      '<Space>cb',
      function()
        if vim.api.nvim_get_vvar('count') == 0 then
          return '<Plug>(comment_toggle_blockwise_current)'
        else
          return '<Plug>(comment_toggle_blockwise_count)'
        end
      end,
      expr = true,
      desc = 'Toggle the comment of current line with block style',
    },
    {
      '<Space>cb',
      '<Plug>(comment_toggle_blockwise_visual)',
      mode = 'x',
      { desc = 'Toggle comment with blockwise style' },
    },
    {
      '<Space>ca',
      function()
        require('Comment.api').locked('insert.linewise.eol')()
      end,
      desc = 'Insert comment at the end of the current line',
    },
  }
end

function M.packages(opt)
  return {
    {
      'folke/which-key.nvim',
      config = function()
        local which_key = require('which-key')
        which_key.setup({})
        which_key.register({
          c = {
            name = '+Comment actions',
          },
          v = {
            name = '+LSP extra actions',
          },
        }, { prefix = '<Localleader>' })
      end,
      lazy = false,
    },
    {
      'kylechui/nvim-surround',
      version = '*',
      event = 'BufEnter',
      opts = {},
    },
    {
      'numToStr/Comment.nvim',
      opts = {
        mappings = {
          basic = false,
          extra = false,
        },
      },
      keys = comment_nvim_keys(),
    },
    { 'ntpeters/vim-better-whitespace', event = 'BufEnter' },
    { 'wellle/targets.vim', event = 'BufEnter' },
    {
      'lukas-reineke/indent-blankline.nvim',
      main = 'ibl',
      opts = {
        exclude = {
          buftypes = { 'terminal', 'nofile', 'quickfix', 'prompt' },
        },
        indent = {
          highlight = {
            'IndentGuidesOdd',
            'IndentGuidesEven',
          },
        },
      },
      event = 'BufEnter',
    },
    {
      'ojroques/vim-oscyank',
      config = function()
        -- Use OSC52 when + register is used
        vim.cmd(
          [[autocmd TextYankPost * if (v:event.operator is 'y' || v:event.operator is 'd') && v:event.regname is '+' | execute 'OSCYankRegister +' | endif]]
        )
      end,
      event = 'BufEnter',
    },
    {
      'phaazon/hop.nvim',
      opts = {
        case_insensitive = false,
      },
      keys = {
        {
          's',
          function()
            require('hop').hint_char2()
          end,
          desc = 'Invoke hop',
        },
      },
      lazy = false,
    },
    {
      'kyazdani42/nvim-tree.lua',
      config = nvim_tree_config,
      cmd = { 'NvimTreeOpen', 'NvimTreeToggle' },
      keys = {
        {
          '<Leader>t',
          function()
            require('nvim-tree.api').tree.toggle()
          end,
          desc = 'Toggle nvim-tree',
        },
      },
    },
    {
      'mbbill/undotree',
      config = function()
        local target_path = vim.fn.expand('~/.local/state/nvim/undodir')
        if not vim.fn.isdirectory(target_path) then
          vim.fn.mkdir(target_path, 'p', tonumber('0700', 8))
        end
        vim.opt.undodir = target_path
      end,
      cmd = { 'UndotreeToggle' },
      lazy = false,
    },
    {
      'famiu/bufdelete.nvim',
      lazy = false,
    },
  }
end

return M
