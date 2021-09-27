return function()
  local get_highlight_color = require'utils'.get_highlight_color

  local function lsp_readiness()
    if #vim.lsp.buf_get_clients(0) == 0 then
      return nil
    end
    local readiness = vim.lsp.buf.server_ready()
    return readiness and ' ' or '痢'
  end

  require('lualine').setup {
    options = {
      theme = 'onedark',
    },
    sections = {
      lualine_a = {'mode', 'location'},
      lualine_b = {'finename'},
      lualine_c = {
        lsp_readiness,
        {
          'diagnostics',
          sources = {'nvim_lsp'},
          color_error = get_highlight_color('LspDiagnosticsSignError', 'fg'),
          color_warn = get_highlight_color('LspDiagnosticsSignWarning', 'fg'),
          color_info = get_highlight_color('LspDiagnosticsSignInformation', 'fg'),
          color_hint = get_highlight_color('LspDiagnosticsSignHint', 'fg'),
          symbols = {error = ' ', warn = ' ', info = ' ', hint = ''}
        },
      },
      lualine_x = {
        {
          'signify_diff',
          color_added = get_highlight_color('DiffSignAdd', 'fg'),
          color_modified = get_highlight_color('DiffSignChange', 'fg'),
          color_removed = get_highlight_color('DiffSignDelete', 'fg'),
          symbols = {added = '+', modified = '~', removed = '-'},
        },
        'branch',
      },
      lualine_y = {'encoding', 'fileformat', 'filetype'},
      lualine_z = {'progress'}
    },
  }
end
