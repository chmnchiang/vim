local M = {}

function M.error(msg, ...)
  vim.notify(vim.log.levels.ERROR, string.format(msg, ...))
end

return M
