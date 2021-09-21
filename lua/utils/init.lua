local M = {}

M.noremap = function(mode, lhs, rhs, opts)
  if opts == nil then
    opts = {}
  end
  opts.noremap = true
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

M.noresimap = function(mode, lhs, rhs, opts)
  if opts == nil then
    opts = {}
  end
  opts.noremap = true
  opts.silent = true
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

M.get_highlight_color = function(name, typ)
  if typ == 'fg' then
    return string.format("#%06x",
      vim.api.nvim_get_hl_by_name(name, true).foreground)
  elseif typ == 'bg' then
    return string.format("#%06x",
      vim.api.nvim_get_hl_by_name(name, true).background)
  end
end

return M
