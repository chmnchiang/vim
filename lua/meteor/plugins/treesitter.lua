local M = {}

function M.setup(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {"lua", "rust", "cpp", "c", "java", "python", "vim"},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        playground = {
          enable = true,
        }
      }
    end
  }
end

return M
