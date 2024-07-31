local icons = require('meteor.icons')
local get_highlight_color = require('meteor.utils').get_highlight_color

local function bufferline_config()
  local bufferline_groups = {
    'buffer',
    'diagnostic',
    'info',
    'info_diagnostic',
    'hint',
    'hint_diagnostic',
    'warning',
    'warning_diagnostic',
    'error',
    'error_diagnostic',
    'modified',
    'duplicate',
    'separator',
    'indicator',
    'pick',
  }

  local function create_bufferline_highlights()
    local bufferline_highlights = {}
    for _, group in ipairs(bufferline_groups) do
      local guibg = get_highlight_color('TabLine', 'bg')
      local guifg = get_highlight_color('TabLine', 'fg')
      local guibg_sel = get_highlight_color('TabLineSel', 'bg')
      local guifg_sel = get_highlight_color('TabLineSel', 'fg')

      if group == 'separator' then
        guifg = '#000000'
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
        guifg = '#afffff'
        guifg_sel = '#afffff'
      elseif group == 'pick' then
        guifg = '#d05020'
        guifg_sel = '#d05020'
      end

      local normal_group = group
      if group == 'buffer' then
        normal_group = 'background'
      end

      if group ~= 'indicator' then
        bufferline_highlights[normal_group] = { bg = guibg, fg = guifg }
        bufferline_highlights[group .. '_visible'] = {
          bg = guibg,
          fg = guifg,
        }
      end

      bufferline_highlights[group .. '_selected'] = {
        bg = guibg_sel,
        fg = guifg_sel,
      }
    end
    return bufferline_highlights
  end
  local ok, bufferline_highlights = pcall(create_bufferline_highlights)
  if not ok then
    bufferline_highlights = nil
  end

  local buf_sorter = require('meteor.buf_sorter')
  buf_sorter.setup()

  local bufferline = require('bufferline')
  bufferline.setup({
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
      sort_by = buf_sorter.sort_by_last_modify_func,
    },
    highlights = bufferline_highlights,
  })

  vim.keymap.set('n', 'L', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Go to previous buffer' })
  vim.keymap.set(
    'n',
    '<leader>l',
    '<Cmd>BufferLineCycleNext<CR>',
    { desc = 'Go to previous buffer' }
  )
  vim.keymap.set('n', 'H', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Go to previous buffer' })
  vim.keymap.set(
    'n',
    '<leader>h',
    '<Cmd>BufferLineCyclePrev<CR>',
    { desc = 'Go to previous buffer' }
  )
  vim.keymap.set(
    'n',
    '<leader>L',
    '<Cmd>BufferLineMoveNext<CR>',
    { desc = 'Move the current buffer right' }
  )
  vim.keymap.set(
    'n',
    '<leader>H',
    '<Cmd>BufferLineMovePrev<CR>',
    { desc = 'Move the current buffer left' }
  )
  vim.keymap.set('n', 'S', '<Cmd>BufferLinePick<CR>')
end

return {
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = bufferline_config,
    lazy = false,
  },
  {
    'hoob3rt/lualine.nvim',
    dependencies = { 'chmnchiang/lualine-signify-diff' },
    opts = function()
      -- Make it a function so the diagnostic color is queried after our colorscheme loaded.
      local trouble = require('trouble')
      local symbols = trouble.statusline({
        mode = 'lsp_document_symbols',
        groups = {},
        title = false,
        filter = { range = true },
        format = '{kind_icon}{symbol.name:Normal}',
        hl_group = 'lualine_c_normal',
      })
      return {
        options = {
          theme = 'onedark',
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'location', 'progress' },
          lualine_b = { 'filetype' },
          lualine_c = {
            'filename',
            {
              function()
                local result = symbols.get()
                return result:gsub("%%%*", "")
              end,
              cond = symbols.has,
            },
          },
          lualine_x = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              diagnostics_color = {
                error = { fg = get_highlight_color('DiagnosticSignError', 'fg') },
                warn = { fg = get_highlight_color('DiagnosticSignWarn', 'fg') },
                info = { fg = get_highlight_color('DiagnosticSignInfo', 'fg') },
                hint = { fg = get_highlight_color('DiagnosticSignHint', 'fg') },
              },
              symbols = {
                error = icons.error,
                warn = icons.warn,
                info = icons.info,
                hint = icons.hint,
              },
            },
            require('meteor.utils').lsp_readiness,
          },
          lualine_y = {
            { 'signify_diff', symbols = { added = '+', modified = '~', removed = '-' } },
            'branch',
          },
          lualine_z = { 'mode' },
        },
      }
    end,
    lazy = false,
  },
  {
    'chmnchiang/lualine-signify-diff',
    dependencies = { 'mhinz/vim-signify' },
  },
}
