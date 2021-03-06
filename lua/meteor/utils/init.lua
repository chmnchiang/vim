local M = {}

function M.noremap(mode, lhs, rhs, opts)
  if opts == nil then
    opts = {}
  end
  opts.noremap = true
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function M.simap(mode, lhs, rhs, opts)
  if opts == nil then
    opts = {}
  end
  opts.silent = true
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function M.noresimap(mode, lhs, rhs, opts)
  if opts == nil then
    opts = {}
  end
  opts.noremap = true
  opts.silent = true
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function M.get_highlight_color(name, typ)
  if typ == 'fg' then
    return string.format('#%06x',
        vim.api.nvim_get_hl_by_name(name, true).foreground)
  elseif typ == 'bg' then
    return string.format('#%06x',
        vim.api.nvim_get_hl_by_name(name, true).background)
  end
end

local last_readiness_check_time = nil
local last_readiness = false

function M.lsp_readiness()
  if next(vim.lsp.buf_get_clients(0)) == nil then
    return ' '
  end
  local current_time = os.time()
  if last_readiness_check_time == nil or
      os.difftime(current_time, last_readiness_check_time) >= 5 then
    last_readiness = vim.lsp.buf.server_ready()
    last_readiness_check_time = current_time
  end
  return 'LSP ' .. (last_readiness and ' ' or '痢')
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
