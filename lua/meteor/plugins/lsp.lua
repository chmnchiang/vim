local floating_window_border = require('meteor').floating_window_border

local function lsp_config()
  local nvim_lsp = require('lspconfig')

  vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = { priority = 20 },
      underline = false,
      severity_sort = true,
    })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = floating_window_border,
  })
  vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = floating_window_border })

  local capabilities =
    require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local on_attach = require('meteor.lsp').lsp_on_attach

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

  setup_lsp('tsserver')
  setup_lsp('graphql')
  setup_lsp('pyright')
  setup_lsp('texlab')
  setup_lsp('clangd')
  setup_lsp('dartls')
  setup_lsp('taplo')
  setup_lsp('svelte')
  setup_lsp('vuels', { cmd = { 'vue-language-server', '--stdio' } })
  setup_lsp('lua_ls')
  setup_lsp('efm', {
    init_options = { documentFormatting = true },
    filetypes = {
      'lua',
      'python',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
    },
    settings = {
      rootMarkers = { '.git/' },
      languages = {
        lua = {
          {
            formatCommand = 'stylua -',
            formatStdin = true,
          },
        },
        python = {
          {
            formatCommand = 'black --quiet -',
            formatStdin = true,
          },
        },
        typescript = {
          require('efmls-configs.formatters.prettier'),
        },
        typescriptreact = {
          require('efmls-configs.formatters.prettier'),
        },
      },
    },
  })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'folke/neodev.nvim', 'creativenull/efmls-configs-nvim' },
    config = lsp_config,
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'ray-x/lsp_signature.nvim',
    dependencies = { 'nvim-lspconfig' },
    opts = {
      handler_opts = {
        border = floating_window_border,
      },
    },
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    cmd = { 'AerialToggle', 'AerialOpen' },
  },
  {
    'j-hui/fidget.nvim',
    opts = {},
    lazy = { 'BufReadPost', 'BufNewFile' },
    tag = 'v1.0.0',
  },
}
