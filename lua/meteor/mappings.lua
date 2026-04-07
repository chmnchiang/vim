local M = {}

function M.setup()
  -- Swap j <-> gj, k <-> gk. It is more intuitive when moving in long lines.
  vim.keymap.set({ 'n', 'x', 'o' }, 'j', 'gj')
  vim.keymap.set({ 'n', 'x', 'o' }, 'k', 'gk')
  vim.keymap.set({ 'n', 'x', 'o' }, 'gj', 'j')
  vim.keymap.set({ 'n', 'x', 'o' }, 'gk', 'k')
  -- Swap 0 <-> ^. 0 is easier to press while the original ^ is more useful.
  vim.keymap.set({ 'n', 'x', 'o' }, '0', '^')
  vim.keymap.set({ 'n', 'x', 'o' }, '^', '0')
  -- Swap ` <-> '. Jump to the exact location is used more often instead of jumping to the line.
  vim.keymap.set({ 'n', 'x', 'o' }, "'", '`')
  vim.keymap.set({ 'n', 'x', 'o' }, '`', "'")
  -- Swap : <-> ,. We use : more often so it deserves a non-shift modified key.
  vim.keymap.set({ 'n', 'x' }, ':', ',')
  vim.keymap.set({ 'n', 'x' }, ',', ':')
  -- Make +/- be increasing/decreasing the number.
  vim.keymap.set({ 'n', 'x' }, '+', '<C-a>')
  vim.keymap.set({ 'n', 'x' }, '-', '<C-x>')
  -- Tmux uses <C-a>. Let's use <C-b> instead.
  vim.keymap.set('i', '<C-b>', '<C-a>')
  -- Make window resizing easier.
  vim.keymap.set('n', '<C-Right>', '<C-w>2>')
  vim.keymap.set('n', '<C-Left>', '<C-w>2<')
  vim.keymap.set('n', '<C-Up>', '<C-w>+')
  vim.keymap.set('n', '<C-Down>', '<C-w>-')

  vim.keymap.set('n', '<Leader>q', '<Cmd>qa<CR>', { desc = 'Same as :qa' })
  vim.keymap.set('n', '<Localleader>q', '<Cmd>Bdelete<CR>')
  vim.keymap.set('n', '<Leader><leader>', '<Cmd>b #<CR>', { desc = 'Switch to previous buffer' })

  local floating_window_border = require('meteor.settings').floating_window_border
  vim.keymap.set('n', '<Localleader>e', function()
    vim.diagnostic.open_float({ border = floating_window_border })
  end, { desc = 'Show error in current line' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[g', function()
    vim.diagnostic.jump({
      count = -1,
      on_jump = function()
        vim.diagnostic.open_float({ border = floating_window_border })
      end,
    })
  end, { desc = 'Jump to previous diagnostic' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']g', function()
    vim.diagnostic.jump({
      count = 1,
      on_jump = function()
        vim.diagnostic.open_float({ border = floating_window_border })
      end,
    })
  end, { desc = 'Jump to next diagnostic' })
  --
  -- M.setup_lsp_keymap_placeholders()
end

function M.setup_lsp_keymap_placeholders()
  local function keymap_set(mode, lhs)
    vim.keymap.set(mode, lhs, function()
      vim.notify('LSP is not running in this buffer', vim.log.levels.INFO, {})
    end, {})
  end
  keymap_set('n', '<Localleader>o')
  keymap_set('n', '<Localleader>O')
  keymap_set('n', '<Leader>O')
  keymap_set('n', '<Localleader>g')
  keymap_set('n', '<Leader>g')
  keymap_set({ 'n', 'x' }, '<Localleader>f')
  keymap_set('n', '<Localleader>d')
end

function M.setup_treesitter_keymaps()
  local select = require('nvim-treesitter-textobjects.select')
  local move = require('nvim-treesitter-textobjects.move')

  -- Select
  local select_maps = {
    ['ia'] = '@parameter.inner',
    ['aa'] = '@parameter.outer',
    ['af'] = '@function.outer',
    ['if'] = '@function.inner',
    ['ic'] = '@comment.outer',
    ['ac'] = '@comment.outer',
    ['is'] = '@statement.outer',
    ['as'] = '@statement.outer',
  }
  for key, capture in pairs(select_maps) do
    vim.keymap.set({ 'x', 'o' }, key, function()
      select.select_textobject(capture, 'textobjects')
    end, { desc = 'Treesitter: ' .. capture })
  end

  -- Move
  vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
    move.goto_next_start('@function.outer', 'textobjects')
  end, { desc = 'Next function start' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']a', function()
    move.goto_next_start('@parameter.inner', 'textobjects')
  end, { desc = 'Next parameter' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
    move.goto_next_end('@function.outer', 'textobjects')
  end, { desc = 'Next function end' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
    move.goto_previous_start('@function.outer', 'textobjects')
  end, { desc = 'Previous function start' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[a', function()
    move.goto_previous_start('@parameter.inner', 'textobjects')
  end, { desc = 'Previous parameter' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
    move.goto_previous_end('@function.outer', 'textobjects')
  end, { desc = 'Previous function end' })
end

function M.setup_lsp_keymaps(bufnr)
  local telescope_builtin = require('telescope.builtin')
  local floating_window_border = require('meteor.settings').floating_window_border

  local function keymap_set(mode, lhs, rhs, opts)
    if opts == nil then
      opts = {}
    end

    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  keymap_set('n', 'K', function()
    vim.lsp.buf.hover({ border = floating_window_border })
  end, { desc = 'vim.lsp.buf.hover()' })
  keymap_set('n', 'grr', telescope_builtin.lsp_references, { desc = 'Show LSP references' })
  keymap_set(
    'n',
    '<Localleader>o',
    '<Cmd>AerialToggle<CR>',
    { desc = 'Toggle the symbol outline (aerial) window' }
  )
  keymap_set(
    'n',
    '<Localleader>O',
    telescope_builtin.lsp_document_symbols,
    { desc = 'Show symbol outline in this file with telescope' }
  )
  keymap_set(
    'n',
    '<Leader>O',
    telescope_builtin.lsp_workspace_symbols,
    { desc = 'Show workspace symbol outline with telescope' }
  )
  keymap_set('n', '<Localleader>g', function()
    require('trouble').toggle({
      mode = 'diagnostics',
      filter = { buf = 0 },
    })
  end, { desc = 'Toggle diagnostics in current file' })
  keymap_set(
    'n', '<Leader>g',
    function()
      require('trouble').toggle({
        mode = 'diagnostics',
      })
    end,
    { desc = 'Toggle diagnostic across project' }
  )
  keymap_set(
    { 'n', 'x' }, '<Localleader>f',
    function()
      vim.lsp.buf.format({ async = false })
    end,
    { desc = 'Format current file' }
  )
  keymap_set(
    'n',
    '<Localleader>d',
    telescope_builtin.lsp_definitions,
    { desc = 'Show definitions' }
  )
  keymap_set('n', 'grd', vim.lsp.buf.declaration, { desc = 'vim.lsp.buf.declaration()' })
end

return M
