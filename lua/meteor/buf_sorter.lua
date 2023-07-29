local bufferline = require('bufferline')

local M = {
  _nonce = 0,
  _buf_last_modify_map = {},
}

local function buf_on_modify(bufnr)
  if M._buf_last_modify_map[bufnr] == M._nonce then
    return
  end
  M._nonce = M._nonce + 1
  M._buf_last_modify_map[bufnr] = M._nonce
  vim.schedule(M.sort_bufferlines)
end

function M.setup()
  local buf_sorter_augroup = vim.api.nvim_create_augroup('BUF_SORTER_AUGROUP', {})
  vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'InsertEnter' }, {
    callback = function(arg)
      if arg.buf == nil then
        return
      end
      if arg.event == 'BufEnter' and M._buf_last_modify_map[arg.buf] ~= nil then
        return
      end
      buf_on_modify(arg.buf)
    end,
    group = buf_sorter_augroup,
  })
end

local function sort_by_last_modify_func_inner(bufid1, bufid2)
  local n1 = M._buf_last_modify_map[bufid1]
  local n2 = M._buf_last_modify_map[bufid2]
  if n1 == nil and n2 == nil then
    return bufid1 < bufid2
  end
  if n1 == nil then
    return true
  end
  if n2 == nil then
    return false
  end
  return n1 > n2
end

function M.sort_by_last_modify_func(b1, b2)
  return sort_by_last_modify_func_inner(b1.id, b2.id)
end

function M.sort_bufferlines()
  bufferline.sort_by(M.sort_by_last_modify_func)
end

return M
