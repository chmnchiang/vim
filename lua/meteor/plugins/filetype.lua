return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    init = function()
      vim.g.rustaceanvim = {
        server = {
          cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
          on_attach = function(client, bufnr)
            require('meteor.lsp').lsp_on_attach(client, bufnr)

            local function keymap_set(mode, lhs, rhs, opts)
              if opts == nil then
                opts = {}
              end
              opts.buffer = bufnr
              vim.keymap.set(mode, lhs, rhs, opts)
            end

            keymap_set('n', 'K', function()
              vim.cmd.RustLsp({ 'hover', 'actions' })
            end, { desc = 'Show LSP hover info' })
            keymap_set('x', 'K', function()
              vim.cmd.RustLsp({ 'hover', 'range' })
            end, { desc = 'Show LSP hover info' })

            vim.keymap.set('n', '<Localleader>e', function()
              vim.cmd.RustLsp({ 'renderDiagnostic', 'current' })
            end, { desc = 'Show error in current line' })
          end,
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = { command = 'clippy' },
              procMacro = { enable = true },
            },
          },
        },
      }
    end,
    lazy = false,
  },
  {
    'Julian/lean.nvim',
    ft = { 'lean' },
    opts = {
      lsp = {
        on_attach = require('meteor.lsp').lsp_on_attach,
      },
      mappings = true,
    },
    enabled = require('meteor').is_personal(),
  },
}
