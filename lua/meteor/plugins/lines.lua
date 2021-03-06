local M = {}

local function bufferline_config()
  local icons = require('meteor.icons')
  local get_highlight_color = require'meteor.utils'.get_highlight_color

  local bufferline_groups = {
    'buffer', 'diagnostic', 'info', 'info_diagnostic', 'hint',
    'hint_diagnostic', 'warning', 'warning_diagnostic', 'error',
    'error_diagnostic', 'modified', 'duplicate', 'separator', 'indicator',
    'pick',
  }

  local bufferline_highlights = {}

  for _, group in ipairs(bufferline_groups) do
    local guibg = get_highlight_color('TabLine', 'bg')
    local guifg = get_highlight_color('TabLine', 'fg')
    local guibg_sel = get_highlight_color('TabLineSel', 'bg')
    local guifg_sel = get_highlight_color('TabLineSel', 'fg')

    if group == 'separator' then
      guifg = '#000000';
      guifg_sel = '#000000'
    elseif group == 'error_diagnostic' then
      guifg = get_highlight_color('DiagnosticSignError', 'fg')
      guifg_sel = guifg
    elseif group == 'warning_diagnostic' then
      guifg = get_highlight_color('DiagnosticSignWarn', 'fg')
      guifg_sel = guifg
    elseif group == 'info_diagnostic' or group == 'diagnostic' then
      guifg = get_highlight_color('DiagnosticSignInfo', 'fg')
      guifg_sel = guifg
    elseif group == 'hint_diagnostic' or group == 'diagnostic' then
      guifg = get_highlight_color('DiagnosticSignHint', 'fg')
      guifg_sel = guifg
    elseif group == 'modified' then
      guifg = '#afffff';
      guifg_sel = '#afffff'
    elseif group == 'pick' then
      guifg = '#d05020'
      guifg_sel = '#d05020'
    end

    local normal_group = group;
    if group == 'buffer' then
      normal_group = 'background'
    end

    if group ~= 'indicator' then
      bufferline_highlights[normal_group] = {guibg = guibg, guifg = guifg}
      bufferline_highlights[group .. '_visible'] = {
        guibg = guibg,
        guifg = guifg,
      }
    end

    bufferline_highlights[group .. '_selected'] = {
      guibg = guibg_sel,
      guifg = guifg_sel,
    }
  end

  require'bufferline'.setup {
    options = {
      separator_style = 'slant',
      show_buffer_close_icons = false,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level)
        local icon = ({
          error = icons.error,
          warning = icons.warn,
          info = icons.info,
          hint = icons.hint,
          other = icons.question,
        })[level]
        return ' ' .. icon .. count
      end,
    },
    highlights = bufferline_highlights,
  }
end

local function lualine_config()
  local icons = require('meteor.icons')
  local get_highlight_color = require'meteor.utils'.get_highlight_color

  require('lualine').setup {
    options = {theme = 'onedark', disabled_filetypes = {'dapui_watches', 'dapui_stacks', 'dapui_breakpoints', 'dapui_scopes'}},
    sections = {
      lualine_a = {'mode', 'location'},
      lualine_b = {'finename'},
      lualine_c = {
        require('meteor.utils').lsp_readiness, {
          'diagnostics',
          sources = {'nvim_diagnostic'},
          diagnostics_color = {
            error = {fg = get_highlight_color('DiagnosticSignError', 'fg')},
            warn = {fg = get_highlight_color('DiagnosticSignWarn', 'fg')},
            info = {fg = get_highlight_color('DiagnosticSignInfo', 'fg')},
            hint = {fg = get_highlight_color('DiagnosticSignHint', 'fg')},
          },
          symbols = {
            error = icons.error,
            warn = icons.warn,
            info = icons.info,
            hint = icons.hint,
          },
        },
      },
      lualine_x = {
        {'signify_diff', symbols = {added = '+', modified = '~', removed = '-'}},
        'branch',
      },
      lualine_y = {'encoding', 'fileformat', 'filetype'},
      lualine_z = {'progress'},
    },
  }
end

function M.setup(use)
  use {
    'akinsho/bufferline.nvim',
    -- after = 'colorscheme',
    requires = 'kyazdani42/nvim-web-devicons',
    config = bufferline_config,
  }
  use {
    'hoob3rt/lualine.nvim',
    after = {'lualine-signify-diff'},
    config = lualine_config,
  }
  use {'chmnchiang/lualine-signify-diff', requires = 'mhinz/vim-signify'}
end

return M
