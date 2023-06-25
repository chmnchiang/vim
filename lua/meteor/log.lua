local M = {}

function M.error(msg, ...)
  vim.notify(string.format(msg, ...), vim.log.levels.ERROR)
end

return M
