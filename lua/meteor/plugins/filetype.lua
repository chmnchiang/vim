local M = {}

local function rust_tools_config()
  require('rust-tools').setup({
    tools = {
      hover_actions = {
        border = require('meteor.plugins.lsp').floating_window_border,
      },
      inlay_hints = { highlight = 'SpecialHint' },
    },
    server = {
      cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
      on_attach = require('meteor.plugins.lsp').lsp_on_attach,
      settings = { ['rust-analyzer'] = {
        checkOnSave = { command = 'clippy' },
        procMacro = { enable = true },
      } },
    },
  })
end

function M.packages()
  return {
    { 'simrat39/rust-tools.nvim', config = rust_tools_config, ft = { 'rust' } },
  }
end

return M
