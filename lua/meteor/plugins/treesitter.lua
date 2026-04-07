local function treesitter_textobjects_config() end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install(require('meteor.settings').get_opt().treesitter.installed_parsers)
    end,
    lazy = false,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })
      require('meteor.mappings').setup_treesitter_keymaps()
    end,
    event = 'VeryLazy',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      multiline_threshold = 8,
    },
    event = 'VeryLazy',
  },
}
