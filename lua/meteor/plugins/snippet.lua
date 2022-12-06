local M = {}

function M.setup(use)
  use({
    'L3MON4D3/LuaSnip',
    tag = 'v1.*',
    event = 'InsertEnter',
    module = 'luasnip',
    config = function()
      require('luasnip.loaders.from_snipmate').lazy_load()
      local luasnip = require('luasnip')
      vim.keymap.set('i', '<Tab>', function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes('<Tab>', true, false, true),
            'n',
            false
          )
        end
      end, { silent = true })
      vim.keymap.set('s', '<Tab>', function()
        luasnip.jump(1)
      end, { silent = true })
      vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
        luasnip.jump(-1)
      end, { silent = true })
    end,
  })
  use({ 'honza/vim-snippets', event = 'InsertEnter' })
end

return M
