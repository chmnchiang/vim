local M = {}

local function nvim_cmp_setup()
  local cmp = require 'cmp'
  local utils = require 'meteor.utils'
  local has_lspkind, lspkind = pcall(require, 'lspkind')

  local lspkind_format = nil
  if has_lspkind then
    lspkind_format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        path = '[Path]',
        ultisnips = '[Snip]',
      },
    }
    vim.cmd [[highlight CmpItemAbbr guifg=#b0b0b0]]
  end

  local format = function(entry, vim_item)
    vim_item.abbr = utils.trim(vim_item.abbr, 80)
    if has_lspkind then
      return lspkind_format(entry, vim_item)
    else
      return vim_item
    end
  end

  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn['UltiSnips#Anon'](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-f>'] = cmp.mapping.scroll_docs(-4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {select = false},
    },
    sources = {
      {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'path'},
      {name = 'ultisnips'},
    },
    formatting = {format = format},
  }
end

function M.setup(use)
  use {
    'hrsh7th/nvim-cmp',
    require = {'onsails/lspkind-nvim'},
    after = {'ultisnips'},
    config = nvim_cmp_setup,
  }
  use {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-buffer', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-path', after = 'nvim-cmp'}
  use {'quangnguyen30192/cmp-nvim-ultisnips', after = 'nvim-cmp'}
end

return M
