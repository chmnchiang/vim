local M = {}

M.floating_window_border = {
  '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏',
}

local function lsp_config()
  local nvim_lsp = require('lspconfig')
  local icons = require('meteor.icons')

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local has_telescope = pcall(require, 'telescope')
    local opts = {noremap = true, silent = true}

    buf_set_keymap('n', '<Localleader>D',
        '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>',
        opts)
    buf_set_keymap('n', '<Localleader>e',
        [[<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = require'meteor.plugins.lsp'.floating_window_border })<CR>]],
        opts)
    buf_set_keymap('n', '<Localleader>R', '<Cmd>lua vim.lsp.buf.rename()<CR>',
        opts)
    buf_set_keymap('n', '[g',
        [[<Cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = require'meteor.plugins.lsp'.floating_window_border }})<CR>]],
        opts)
    buf_set_keymap('n', ']g',
        [[<Cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = require'meteor.plugins.lsp'.floating_window_border }})<CR>]],
        opts)

    if not has_telescope then
      buf_set_keymap('n', '<Localleader>d',
          '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', '<Localleader>i',
          '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<Localleader>t',
          '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<Localleader>r',
          '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<Localleader>a',
          '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    else
      buf_set_keymap('n', '<Localleader>d',
          '<Cmd>Telescope lsp_definitions<CR>', opts)
      buf_set_keymap('n', '<Localleader>i',
          '<Cmd>Telescope lsp_implementations<CR>', opts)
      buf_set_keymap('n', '<Localleader>t',
          '<Cmd>Telescope lsp_type_definitions<CR>', opts)
      buf_set_keymap('n', '<Localleader>r', '<Cmd>Telescope lsp_references<CR>',
          opts)
      buf_set_keymap('n', '<Localleader>a',
          '<Cmd>Telescope lsp_code_actions<CR>', opts)
      buf_set_keymap('v', '<Localleader>a',
          [[<Cmd>'<,'>Telescope lsp_range_code_actions<CR>]], opts)
      buf_set_keymap('n', '<Localleader>o',
          '<Cmd>Telescope lsp_document_symbols<CR>', opts)
      buf_set_keymap('n', '<Leader>o',
          '<Cmd>Telescope lsp_workspace_symbols<CR>', opts)
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

  local function get_capabilities()
    return require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
                                                           .make_client_capabilities())
  end

  local servers = {'rust_analyzer', 'tsserver', 'pyright', 'texlab', 'clangd'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      capabilities = get_capabilities(),
    }
  end

  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  nvim_lsp['sumneko_lua'].setup {
    on_attach = on_attach,
    capabilities = get_capabilities(),
    cmd = {'lua-language-server'},
    settings = {
      Lua = {
        runtime = {version = 'LuaJIT', path = runtime_path},
        diagnostics = {globals = {'vim'}},
        workspace = {library = vim.api.nvim_get_runtime_file('', true)},
        telemetry = {enable = false},
      },
    },
  }

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

  nvim_lsp['efm'].setup {
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
  }

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
    require = {'hrsh7th/cmp-nvim-lsp'},
    after = 'lsp_signature.nvim',
    config = lsp_config,
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
  }
end

return M
