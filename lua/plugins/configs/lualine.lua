return function()
  local get_highlight_color = require'utils'.get_highlight_color

  require('lualine').setup {
    options = {
      theme = 'onedark',
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {
        'filename',
        {
          'diagnostics',
          sources = {'nvim_lsp'},
          color_error = get_highlight_color('LspDiagnosticsSignError', 'fg'),
          color_warn = get_highlight_color('LspDiagnosticsSignWarning', 'fg'),
          color_info = get_highlight_color('LspDiagnosticsSignInformation', 'fg'),
          color_hint = get_highlight_color('LspDiagnosticsSignHint', 'fg'),
          symbols = {error = ' ', warn = ' ', info = ' ', hint = ''}
        },
        {
          'signify_diff',
          color_added = get_highlight_color('DiffSignAdd', 'fg'),
          color_modified = get_highlight_color('DiffSignChange', 'fg'),
          color_removed = get_highlight_color('DiffSignDelete', 'fg'),
          symbols = {added = '+', modified = '~', removed = '-'},
        },
      },
      -- lualine_x = { require'lsp-status'.status },
      -- lualine_y = {'encoding', 'fileformat', 'filetype'},
      -- lualine_z = {'progress', 'location'}
    },
  }
end
