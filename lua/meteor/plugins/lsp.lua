local floating_window_border = require('meteor.settings').floating_window_border

local function lsp_config()
  local on_attach = require('meteor.lsp').lsp_on_attach

  vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
  })

  local function setup_lsp(lsp_name, options)
    if options ~= nil then
      vim.lsp.config(lsp_name, options)
    end
    vim.lsp.enable(lsp_name)
  end

  -- JavaScript / TypeScript
  setup_lsp('ts_ls', {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })
  setup_lsp('oxlint')
  setup_lsp('oxfmt')
  setup_lsp('graphql')
  setup_lsp('svelte')

  -- Python
  setup_lsp('pyright')
  setup_lsp('ruff', {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.hoverProvider = false
    end,
  })

  -- Lua
  setup_lsp('lua_ls')

  -- C / C++
  setup_lsp('clangd')

  -- Dart
  setup_lsp('dartls')

  -- YAML
  setup_lsp('yamlls')

  -- Terraform / OpenTofu
  setup_lsp('tofu_ls', {
    cmd = { 'tofu-ls', 'serve' },
    filetypes = { 'terraform', 'terraform-vars' },
    root_markers = { '.terraform', '.git' },
  })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'creativenull/efmls-configs-nvim',
    },
    config = lsp_config,
    lazy = false,
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
    event = { 'BufReadPost', 'BufNewFile' },
    tag = 'v1.0.0',
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {},
  }
}
