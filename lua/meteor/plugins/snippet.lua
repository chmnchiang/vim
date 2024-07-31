return {
  {
    'L3MON4D3/LuaSnip',
    version = '^1.0',
    event = 'InsertEnter',
    config = function()
      local luasnip = require('luasnip')
      luasnip.setup({
        region_check_events = 'InsertEnter',
      })
      require('luasnip.loaders.from_snipmate').lazy_load()
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
    dependencies = { 'vim-snippets' },
  },
  { 'honza/vim-snippets', event = 'InsertEnter' },
}
