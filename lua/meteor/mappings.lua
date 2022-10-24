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
  vim.keymap.set('', 'j', 'gj')
  vim.keymap.set('', 'k', 'gk')
  vim.keymap.set('', 'gj', 'j')
  vim.keymap.set('', 'gk', 'k')
  -- Swap 0 <-> ^. 0 is easier to press while the original ^ is more useful.
  vim.keymap.set('', '0', '^')
  vim.keymap.set('', '^', '0')
  -- Swap : <-> ,. We use : more often so it deserves a non-shift modified key.
  vim.keymap.set('', ':', ',')
  vim.keymap.set('', ',', ':')
  vim.keymap.set('', ':', ',')
  vim.keymap.set('', ',', ':')
  -- Make +/- be increasing/decreasing the number.
  vim.keymap.set({ 'n', 'v' }, '+', '<C-a>')
  vim.keymap.set({ 'n', 'v' }, '-', '<C-x>')
  -- Tmux uses <C-a>. Let's use <C-b> instead.
  vim.keymap.set('i', '<C-b>', '<C-a>')
  -- Make window resizing easier.
  vim.keymap.set('n', '<C-Right>', '<C-w>2>')
  vim.keymap.set('n', '<C-Left>', '<C-w>2<')
  vim.keymap.set('n', '<C-Up>', '<C-w>+')
  vim.keymap.set('n', '<C-Down>', '<C-w>-')
  -- Make H and L navigate buffers.
  -- Nerd Commenter
  vim.keymap.set(
    'n',
    '<Localleader>ca',
    '<Plug>NERDCommenterAltDelims',
    { desc = 'Change the comment chars' }
  )
  vim.keymap.set(
    'n',
    '<Localleader>cA',
    '<Plug>NERDCommenterAppend',
    { desc = 'Add comment at the end of line' }
  )
  vim.keymap.set(
    { 'n', 'x' },
    '<Localleader>c<Localleader>',
    '<Plug>NERDCommenterToggle',
    { desc = 'Toggle comments' }
  )
  vim.keymap.set(
    { 'n', 'x' },
    '<Localleader>cc',
    '<Plug>NERDCommenterComment',
    { desc = 'Comments the current line/selection' }
  )
  if opt.tabline then
    vim.keymap.set('n', '<leader>l', '<Cmd>BufferLineCycleNext<CR>')
    vim.keymap.set('n', 'L', '<Cmd>BufferLineCycleNext<CR>')
    vim.keymap.set('n', '<leader>h', '<Cmd>BufferLineCyclePrev<CR>')
    vim.keymap.set('n', 'H', '<Cmd>BufferLineCyclePrev<CR>')
    vim.keymap.set('n', '<leader>L', '<Cmd>BufferLineMoveNext<CR>')
    vim.keymap.set('n', '<leader>H', '<Cmd>BufferLineMovePrev<CR>')
    vim.keymap.set('n', '<leader>H', '<Cmd>BufferLineMovePrev<CR>')
    vim.keymap.set('n', 'S', '<Cmd>BufferLinePick<CR>')
  else
    vim.keymap.set('n', '<leader>l', ':bnext<CR>')
    vim.keymap.set('n', 'L', ':bnext<CR>')
    vim.keymap.set('n', '<leader>h', ':bprev<CR>')
    vim.keymap.set('n', 'H', ':bprev<CR>')
  end
  vim.keymap.set('n', '<leader>q', '<Cmd>bdelete<CR>')
  vim.keymap.set('n', '<localleader>q', '<Cmd>bdelete<CR>')
  vim.keymap.set('n', '<leader><leader>', '<Cmd>b #<CR>', { desc = 'Switch to previous buffer' })
  if opt.telescope then
    vim.keymap.set('n', '<leader>b', '<Cmd>Telescope buffers<CR>')
    vim.keymap.set('n', '<leader>s', '<Cmd>Telescope live_grep<CR>')
    vim.keymap.set('n', '<leader>f', '<Cmd>Telescope find_files<CR>')
    vim.keymap.set(
      'n',
      '<leader>r',
      '<Cmd>Telescope resume<CR>',
      { desc = 'Resume the last Telescope' }
    )
    vim.keymap.set('n', '<leader>c', '<Cmd>Telescope command_history<CR>')
  end
  if opt.nvim_tree then
    vim.keymap.set('n', '<leader>t', '<Cmd>NvimTreeToggle<CR>')
  end
  if opt.dap then
    vim.keymap.set('n', '<leader>dt', [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]])
    vim.keymap.set('n', '<leader>dc', [[<Cmd>lua require('dap').continue()<CR>]])
    vim.keymap.set('n', '<leader>ds', [[<Cmd>lua require('dap').step_over()<CR>]])
    vim.keymap.set('n', '<leader>di', [[<Cmd>lua require('dap').step_into()<CR>]])
    vim.keymap.set('n', '<leader>do', [[<Cmd>lua require('dap').step_out()<CR>]])
    vim.keymap.set('n', '<leader>du', [[<Cmd>lua require('dap').up()<CR>]])
    vim.keymap.set('n', '<leader>dd', [[<Cmd>lua require('dap').down()<CR>]])
    vim.keymap.set('n', '<leader>dC', [[<Cmd>lua require('dap').run_to_cursor()<CR>]])
    vim.keymap.set('n', '<leader>de', [[<Cmd>lua require('dapui').eval()<CR>]])
  end
  vim.keymap.set('', 's', [[<Cmd>lua require'hop'.hint_char2()<Cr>]])
end

function M.setup_lsp_keymaps(bufnr)
  local floating_window_border = require('meteor.plugins.lsp').floating_window_border
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
  keymap_set('n', '<Localleader>e', function()
    vim.diagnostic.open_float({ border = floating_window_border })
  end, { desc = 'Show error in current line' })
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
  keymap_set('', '[g', function()
    vim.diagnostic.goto_prev({ float = { border = floating_window_border } })
  end, { desc = 'Jump to previous diagnostic' })
  keymap_set('', ']g', function()
    vim.diagnostic.goto_next({ float = { border = floating_window_border } })
  end, { desc = 'Jump to next diagnostic' })
  keymap_set(
    { 'n', 'v' },
    '<Localleader>a',
    vim.lsp.buf.code_action,
    { desc = 'Show code actions' }
  )
  keymap_set({ 'n', 'v' }, '<Localleader>f', function()
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
