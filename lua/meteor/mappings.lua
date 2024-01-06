local M = {}

function M.setup(opt)
  if opt == nil then
    opt = {}
  end
  -- Map leaders. `mapleader` is used for global commands (switching buffers,
  -- etc.), and `maplocalleader` is used for local commands (mainly for LSP
  -- commands).
  vim.g.mapleader = '\\'
  vim.g.maplocalleader = ' '

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

  vim.keymap.set('n', '<Leader>q', '<Cmd>qa<CR>')
  vim.keymap.set('n', '<Localleader>q', '<Cmd>Bdelete<CR>')
  vim.keymap.set('n', '<Leader><leader>', '<Cmd>b #<CR>', { desc = 'Switch to previous buffer' })

  local floating_window_border = require('meteor.plugins.lsp').floating_window_border
  vim.keymap.set('n', '<Localleader>e', function()
    vim.diagnostic.open_float({ border = floating_window_border })
  end, { desc = 'Show error in current line' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[g', function()
    vim.diagnostic.goto_prev({ float = { border = floating_window_border } })
  end, { desc = 'Jump to previous diagnostic' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']g', function()
    vim.diagnostic.goto_next({ float = { border = floating_window_border } })
  end, { desc = 'Jump to next diagnostic' })

  M.setup_lsp_keymap_placeholders()
end

function M.setup_lsp_keymap_placeholders()
  local function keymap_set(mode, lhs)
    vim.keymap.set(mode, lhs, function()
      vim.notify('LSP is not running in this buffer', vim.log.levels.INFO, {})
    end, {})
  end
  keymap_set('n', 'K')
  keymap_set('n', '<C-k>')
  keymap_set('n', '<Localleader>e')
  keymap_set('n', '<Localleader>r')
  keymap_set('n', '<Localleader>o')
  keymap_set('n', '<Localleader>O')
  keymap_set('n', '<Leader>O')
  keymap_set('n', '<Localleader>g')
  keymap_set('n', '<Leader>g')
  keymap_set({ 'n', 'x' }, '<Localleader>a')
  keymap_set({ 'n', 'x' }, '<Localleader>f')
  keymap_set('n', '<Localleader>d')
  keymap_set('n', '<Localleader>vd')
  keymap_set('n', '<Localleader>vr')
  keymap_set('n', '<Localleader>vi')
  keymap_set('n', '<Localleader>vt')
end

function M.setup_lsp_keymaps(bufnr)
  local telescope_builtin = require('telescope.builtin')

  local function keymap_set(mode, lhs, rhs, opts)
    if opts == nil then
      opts = {}
    end
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  keymap_set('n', 'K', vim.lsp.buf.hover, { desc = 'Show LSP hover info' })
  keymap_set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
  keymap_set('n', '<Localleader>r', telescope_builtin.lsp_references, { desc = 'Show references' })
  keymap_set('n', '<Localleader>o', '<Cmd>SymbolsOutline<CR>', { desc = 'Show symbol outline' })
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
  keymap_set(
    'n',
    '<Localleader>g',
    '<Cmd>TroubleToggle document_diagnostics<CR>',
    { desc = 'Toggle diagnostics in current file' }
  )
  keymap_set(
    'n',
    '<Leader>g',
    '<Cmd>TroubleToggle workspace_diagnostics<CR>',
    { desc = 'Toggle diagnostic across project' }
  )
  keymap_set(
    { 'n', 'x' },
    '<Localleader>a',
    vim.lsp.buf.code_action,
    { desc = 'Show code actions' }
  )
  keymap_set({ 'n', 'x' }, '<Localleader>f', function()
    vim.lsp.buf.format({ async = true })
  end, { desc = 'Format current file' })
  keymap_set(
    'n',
    '<Localleader>d',
    telescope_builtin.lsp_definitions,
    { desc = 'Show definitions' }
  )

  keymap_set('n', '<Localleader>vd', vim.lsp.buf.declaration, { desc = 'Show Declaration' })
  keymap_set('n', '<Localleader>vr', vim.lsp.buf.rename, { desc = 'Rename variable' })
  keymap_set(
    'n',
    '<Localleader>vi',
    telescope_builtin.lsp_implementations,
    { desc = 'Show implementations' }
  )
  keymap_set(
    'n',
    '<Localleader>vt',
    telescope_builtin.lsp_type_definitions,
    { desc = 'Show type definition' }
  )
end

return M
