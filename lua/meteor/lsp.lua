local M = {}

function M.lsp_on_attach(client, bufnr)
  require('meteor.mappings').setup_lsp_keymaps(bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local augroup = vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd('CursorHold', {
      group = augroup,
      buffer = 0,
      desc = 'Highlight cursor variable by LSP document highlight',
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = augroup,
      buffer = 0,
      desc = 'Clear document highlight after cursor moved',
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
