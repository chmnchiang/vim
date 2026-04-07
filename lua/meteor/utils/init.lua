local M = {}

function M.get_highlight_color(name, typ)
  if typ == 'fg' then
    return string.format('#%06x', vim.api.nvim_get_hl(0, { name = name, link = false }).fg)
  elseif typ == 'bg' then
    return string.format('#%06x', vim.api.nvim_get_hl(0, { name = name, link = false }).bg)
  end
end

function M.lsp_readiness()
  if #vim.lsp.get_clients({ bufnr = 0 }) == 0 then
    return ' '
  end
  return 'LSP  '
end

function M.trim(s, max_len)
  if string.len(s) <= max_len then
    return s
  else
    return string.sub(s, 1, max_len - 1) .. '…'
  end
end

---Get an element in the table with default value.
---@param table table
---@param key any
---@param default any: the default value when `key` is not in `table`.
---@return any
function M.get_or(table, key, default)
  local ret = table[key]
  if ret == nil then
    table[key] = default
    ret = table[key]
  end
  return ret
end

return M
