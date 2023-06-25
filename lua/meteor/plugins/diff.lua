local M = {}

function M.packages(opt)
  return {
    {
      'mhinz/vim-signify',
      config = function()
        vim.g.signify_sign_add = '│'
        vim.g.signify_sign_change = '│'
        vim.g.signify_priority = 5
      end,
      lazy = false,
    }
  }
end

return M
