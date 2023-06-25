local M = {}

local function nvim_cmp_setup()
  local cmp = require('cmp')
  local utils = require('meteor.utils')
  local has_lspkind, lspkind = pcall(require, 'lspkind')

  local lspkind_format = nil
  if has_lspkind then
    lspkind_format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        path = '[Path]',
        ultisnips = '[Snip]',
        luasnip = '[Snip]',
      },
    })
    vim.cmd([[highlight CmpItemAbbr guifg=#b0b0b0]])
  end

  local format = function(entry, vim_item)
    vim_item.abbr = utils.trim(vim_item.abbr, 80)
    if has_lspkind then
      return lspkind_format(entry, vim_item)
    else
      return vim_item
    end
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = (function()
      local mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-y>'] = nil,
      })
      mapping['<C-Y>'] = nil
      return mapping
    end)(),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'buffer' },
      { name = 'luasnip' },
    },
    formatting = { format = format },
  })
  cmp.setup.cmdline('/', {
    sources = { { name = 'buffer' } },
    mapping = cmp.mapping.preset.cmdline(),
  })
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
  })
end

function M.packages(opt)
  return {
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'onsails/lspkind-nvim',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
      },
      config = nvim_cmp_setup,
      event = { 'InsertEnter', 'CmdlineEnter' },
    },
  }
end

return M
