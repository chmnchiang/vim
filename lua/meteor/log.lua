local M = {}

function M.error(msg, ...)
  local text = vim.fn.escape(string.format(msg, ...), [["\]])
  vim.schedule(function()
    vim.cmd [[echohl ErrorMsg]]
    vim.cmd(string.format([[echom "[E] %s"]], text))
    vim.cmd [[echohl NONE]]
  end)
end

return M
