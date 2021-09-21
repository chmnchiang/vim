return function()
  local get_highlight_color = require'utils'.get_highlight_color

  local bufferline_groups = {
    'buffer', 'diagnostic', 'info', 'info_diagnostic', 'warning',
    'warning_diagnostic', 'error', 'error_diagnostic', 'modified', 'duplicate',
    'separator', 'indicator', 'pick',
  }

  local bufferline_highlights = { }

  for _, group in ipairs(bufferline_groups) do
    local guibg = get_highlight_color('TabLine', 'bg')
    local guifg = get_highlight_color('TabLine', 'fg')
    local guibg_sel = get_highlight_color('TabLineSel', 'bg')
    local guifg_sel = get_highlight_color('TabLineSel', 'fg')

    if group == 'separator' then
      guifg = '#000000'; guifg_sel = '#000000'
    elseif group == 'error_diagnostic' then
      guifg = get_highlight_color('LspDiagnosticsSignError', 'fg')
      guifg_sel = guifg
    elseif group == 'warning_diagnostic' then
      guifg = get_highlight_color('LspDiagnosticsSignWarning', 'fg')
      guifg_sel = guifg
    elseif group == 'info_diagnostic' then
      guifg = get_highlight_color('LspDiagnosticsSignInformation', 'fg')
      guifg_sel = guifg
    elseif group == 'modified' then
      guifg = '#afffff'; guifg_sel = '#afffff'
    end

    local normal_group = group;
    if group == 'buffer' then normal_group = 'background' end

    if group ~= 'indicator' then
      bufferline_highlights[normal_group] = { guibg = guibg, guifg = guifg }
      bufferline_highlights[group..'_visible'] = { guibg = guibg, guifg = guifg }
    end

    bufferline_highlights[group..'_selected'] = { guibg = guibg_sel, guifg = guifg_sel }
  end

  require("bufferline").setup {
    options = {
      separator_style = "slant",
      show_buffer_close_icons = false,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
      end
    },
    highlights = bufferline_highlights,
  }

  local noresimap = require'utils'.noresimap

  noresimap('n', '<leader>l', ':BufferLineCycleNext<CR>')
  noresimap('n', '<leader>h', ':BufferLineCyclePrev<CR>')
  noresimap('n', '<leader><M-l>', ':BufferLineMoveNext<CR>')
  noresimap('n', '<leader><M-h>', ':BufferLineMovePrev<CR>')
end
