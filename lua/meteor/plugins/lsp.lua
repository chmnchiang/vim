local M = {}

M.floating_window_border = {
  '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏',
}

M.lsp_enabled_filetypes = {
  'c', 'cpp', 'objc', 'objcpp', 'javascript', 'javascriptreact',
  'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'python',
  'tex', 'bib', 'rust', 'lua',
}

function M.lsp_on_attach(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local has_telescope = pcall(require, 'telescope')
  local opts = {noremap = true, silent = true}

  buf_set_keymap('n', '<Localleader>D',
      '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Localleader>e',
      [[<Cmd>lua vim.diagnostic.open_float({ border = require'meteor.plugins.lsp'.floating_window_border })<CR>]],
      opts)
  buf_set_keymap('n', '<Localleader>R', '<Cmd>lua vim.lsp.buf.rename()<CR>',
      opts)
  buf_set_keymap('n', '[g',
      [[<Cmd>lua vim.diagnostic.goto_prev({ float = { border = require'meteor.plugins.lsp'.floating_window_border }})<CR>]],
      opts)
  buf_set_keymap('n', ']g',
      [[<Cmd>lua vim.diagnostic.goto_next({ float = { border = require'meteor.plugins.lsp'.floating_window_border }})<CR>]],
      opts)
  buf_set_keymap('n', '<Localleader>a',
      [[<Cmd>lua vim.lsp.buf.code_action()<CR>]], opts)
  buf_set_keymap('v', '<Localleader>a',
      [[<Cmd>lua vim.lsp.buf.range_code_action()<CR>]], opts)

  if not has_telescope then
    buf_set_keymap('n', '<Localleader>d',
        '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<Localleader>i',
        '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<Localleader>t',
        '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<Localleader>r',
        '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  else
    buf_set_keymap('n', '<Localleader>d', '<Cmd>Telescope lsp_definitions<CR>',
        opts)
    buf_set_keymap('n', '<Localleader>i',
        '<Cmd>Telescope lsp_implementations<CR>', opts)
    buf_set_keymap('n', '<Localleader>t',
        '<Cmd>Telescope lsp_type_definitions<CR>', opts)
    buf_set_keymap('n', '<Localleader>r', '<Cmd>Telescope lsp_references<CR>',
        opts)
    buf_set_keymap('n', '<Localleader>o',
        '<Cmd>Telescope lsp_document_symbols<CR>', opts)
    buf_set_keymap('n', '<Leader>o', '<Cmd>Telescope lsp_workspace_symbols<CR>',
        opts)
    buf_set_keymap('n', '<Localleader>g',
        '<Cmd>Telescope diagnostics bufnr=0<CR>', opts)
    buf_set_keymap('n', '<Leader>g', '<Cmd>Telescope diagnostics<CR>', opts)
  end

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<Localleader>f',
        '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('v', '<Localleader>f',
        '<Cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi link LspReferenceRead Search
      hi link LspReferenceText Search
      hi link LspReferenceWrite Search
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
  end
end

local function lsp_config()
  local nvim_lsp = require('lspconfig')
  local icons = require('meteor.icons')

  vim.lsp.handlers['textDocument/publishDiagnostics'] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = {priority = 20},
        underline = false,
        severity_sort = true,
      })

  vim.lsp.handlers['textDocument/hover'] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = require'meteor.plugins.lsp'.floating_window_border,
      })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      {border = require'meteor.plugins.lsp'.floating_window_border})

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                       .protocol
                                                                       .make_client_capabilities())
  local on_attach = require('meteor.plugins.lsp').lsp_on_attach

  local function setup_lsp(lsp_name, options)
    if options == nil then
      options = {}
    end
    options = vim.tbl_extend('keep', options, {
      on_attach = on_attach,
      capabilities = capabilities,
    })
    nvim_lsp[lsp_name].setup {}
  end

  setup_lsp('rust_analyzer', {
    settings = {['rust-analyzer'] = {checkOnSave = {command = 'clippy'}}},
  })

  setup_lsp('tsserver')
  setup_lsp('pyright')
  setup_lsp('textlab')
  setup_lsp('clangd')

  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  setup_lsp('sumneko_lua', {
    cmd = {'lua-language-server'},
    settings = {
      Lua = {
        runtime = {version = 'LuaJIT', path = runtime_path},
        diagnostics = {globals = {'vim'}},
        workspace = {library = vim.api.nvim_get_runtime_file('', true)},
        telemetry = {enable = false},
      },
    },
  })

  local lua_format_options = {
    ['column-limit'] = 80,
    ['indent-width'] = 2,
    ['keep-simple-control-block-one-line'] = false,
    ['keep-simple-function-one-line'] = false,
    ['double-quote-to-single-quote'] = true,
    ['extra-sep-at-table-end'] = true,
    ['align-args'] = false,
    ['align-parameter'] = false,
  }
  local lua_format_options_str_list = {}
  for name, value in pairs(lua_format_options) do
    local option_str
    if type(value) == 'boolean' then
      if value then
        option_str = '--' .. name
      else
        option_str = '--no-' .. name
      end
    elseif type(value) == 'number' then
      option_str = string.format('--%s=%d', name, value)
    else
      error('expect option value to have type string|number')
    end
    table.insert(lua_format_options_str_list, option_str)
  end
  local lua_format_options_str = table.concat(lua_format_options_str_list, ' ')

  setup_lsp('efm', {
    init_options = {documentFormatting = true},
    on_attach = on_attach,
    filetypes = {'lua'},
    settings = {
      rootMarkers = {'.git/'},
      languages = {
        lua = {
          {
            formatCommand = '/home/meteor/.luarocks/bin/lua-format -i ' ..
                lua_format_options_str,
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
  use {
    'neovim/nvim-lspconfig',
    requires = {'hrsh7th/cmp-nvim-lsp'},
    config = lsp_config,
    ft = M.lsp_enabled_filetypes,
    module = 'lspconfig',
  }
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require'lsp_signature'.setup {
        handler_opts = {
          border = require'meteor.plugins.lsp'.floating_window_border,
        },
      }
    end,
    after = 'nvim-lspconfig',
  }
  use {
    'simrat39/symbols-outline.nvim',
    setup = function()
      vim.g.symbols_outline = {auto_preview = false}
    end,
    cmd = {'SymbolsOutline'},
  }
end

return M
