local M = {}

M.floating_window_border = {
  '🭽',
  '▔',
  '🭾',
  '▕',
  '🭿',
  '▁',
  '🭼',
  '▏',
}

M.lsp_enabled_filetypes = {
  'c',
  'cpp',
  'objc',
  'objcpp',
  'javascript',
  'javascriptreact',
  'javascript.jsx',
  'typescript',
  'typescriptreact',
  'typescript.tsx',
  'python',
  'tex',
  'bib',
  'rust',
  'lua',
  'dart',
}

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

local function lsp_config()
  local nvim_lsp = require('lspconfig')
  local icons = require('meteor.icons')

  vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = { priority = 20 },
      underline = false,
      severity_sort = true,
    })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = require('meteor.plugins.lsp').floating_window_border,
  })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = require('meteor.plugins.lsp').floating_window_border }
  )

  local capabilities =
    require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local on_attach = require('meteor.plugins.lsp').lsp_on_attach

  local function setup_lsp(lsp_name, options)
    if options == nil then
      options = {}
    end
    options = vim.tbl_extend('keep', options, {
      on_attach = on_attach,
      capabilities = capabilities,
    })
    nvim_lsp[lsp_name].setup(options)
  end

  setup_lsp('rust_analyzer', {
    settings = { ['rust-analyzer'] = { checkOnSave = { command = 'clippy' } } },
  })

  setup_lsp('tsserver')
  setup_lsp('pyright')
  setup_lsp('texlab')
  setup_lsp('clangd')
  setup_lsp('dartls')

  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  setup_lsp('sumneko_lua', {
    cmd = { 'lua-language-server' },
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', path = runtime_path },
        diagnostics = { globals = { 'vim' } },
        format = {
          enable = true,
          defaultConfig = {
            max_line_length = 100,
          },
        },
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        telemetry = { enable = false },
      },
    },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
  })

  setup_lsp('efm', {
    init_options = { documentFormatting = true },
    on_attach = function() end,
    filetypes = { 'lua' },
    settings = {
      rootMarkers = { '.git/' },
      languages = {
        lua = {
          {
            formatCommand = 'stylua -',
            formatStdin = true,
          },
        },
      },
    },
  })

  local function define_diagnostic_symbol(name, icon)
    vim.fn.sign_define('DiagnosticSign' .. name, {
      text = icon,
      texthl = 'DiagnosticSign' .. name,
      numhl = 'DiagnosticNum' .. name,
    })
  end

  define_diagnostic_symbol('Error', icons.error)
  define_diagnostic_symbol('Warn', icons.warn)
  define_diagnostic_symbol('Info', icons.info)
  define_diagnostic_symbol('Hint', icons.hint)
end

function M.setup(use)
  use({
    'neovim/nvim-lspconfig',
    requires = { 'hrsh7th/cmp-nvim-lsp' },
    config = lsp_config,
    ft = M.lsp_enabled_filetypes,
    module = 'lspconfig',
  })
  use({
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        handler_opts = {
          border = require('meteor.plugins.lsp').floating_window_border,
        },
      })
    end,
    after = 'nvim-lspconfig',
  })
  use({
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup({
        auto_preview = false,
      })
    end,
    cmd = { 'SymbolsOutline' },
  })
end

return M
