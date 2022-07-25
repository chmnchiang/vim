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

  local simap = require('meteor.utils').simap
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
  simap(
    'n',
    '<Localleader>ca',
    '<Plug>NERDCommenterAltDelims',
    { desc = 'Change the comment chars' }
  )
  simap(
    'n',
    '<Localleader>cA',
    '<Plug>NERDCommenterAppend',
    { desc = 'Add comment at the end of line' }
  )
  simap({'n', 'x'}, '<Localleader>c<Localleader>', '<Plug>NERDCommenterToggle', {desc = 'Toggle comments'})
  simap({'n', 'x'}, '<Localleader>cc', '<Plug>NERDCommenterComment', {desc = 'Comments the current line/selection'})
  if opt.tabline then
    simap('n', '<leader>l', '<Cmd>BufferLineCycleNext<CR>')
    simap('n', 'L', '<Cmd>BufferLineCycleNext<CR>')
    simap('n', '<leader>h', '<Cmd>BufferLineCyclePrev<CR>')
    simap('n', 'H', '<Cmd>BufferLineCyclePrev<CR>')
    simap('n', '<leader>L', '<Cmd>BufferLineMoveNext<CR>')
    simap('n', '<leader>H', '<Cmd>BufferLineMovePrev<CR>')
    simap('n', '<leader>H', '<Cmd>BufferLineMovePrev<CR>')
    simap('n', 'S', '<Cmd>BufferLinePick<CR>')
  else
    simap('n', '<leader>l', ':bnext<CR>')
    simap('n', 'L', ':bnext<CR>')
    simap('n', '<leader>h', ':bprev<CR>')
    simap('n', 'H', ':bprev<CR>')
  end
  simap('n', '<leader>q', '<Cmd>bdelete<CR>')
  simap('n', '<localleader>q', '<Cmd>bdelete<CR>')
  simap('n', '<leader><leader>', '<Cmd>b #<CR>', {desc = 'Switch to previous buffer'})
  if opt.telescope then
    simap('n', '<leader>b', '<Cmd>Telescope buffers<CR>')
    simap('n', '<leader>s', '<Cmd>Telescope live_grep<CR>')
    simap('n', '<leader>f', '<Cmd>Telescope find_files<CR>')
    simap('n', '<leader>r', '<Cmd>Telescope resume<CR>', {desc = 'Resume the last Telescope'})
    simap('n', '<leader>c', '<Cmd>Telescope command_history<CR>')
  end
  if opt.nvim_tree then
    simap('n', '<leader>t', '<Cmd>NvimTreeToggle<CR>')
  end
  if opt.dap then
    simap('n', '<leader>dt', [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]])
    simap('n', '<leader>dc', [[<Cmd>lua require('dap').continue()<CR>]])
    simap('n', '<leader>ds', [[<Cmd>lua require('dap').step_over()<CR>]])
    simap('n', '<leader>di', [[<Cmd>lua require('dap').step_into()<CR>]])
    simap('n', '<leader>do', [[<Cmd>lua require('dap').step_out()<CR>]])
    simap('n', '<leader>du', [[<Cmd>lua require('dap').up()<CR>]])
    simap('n', '<leader>dd', [[<Cmd>lua require('dap').down()<CR>]])
    simap('n', '<leader>dC', [[<Cmd>lua require('dap').run_to_cursor()<CR>]])
    simap('n', '<leader>de', [[<Cmd>lua require('dapui').eval()<CR>]])
  end
  simap('', 's', [[<Cmd>lua require'hop'.hint_char2()<Cr>]])
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
    '<Cmd>Trouble document_diagnostics<CR>',
    { desc = 'Show diagnostics in current file' }
  )
  keymap_set(
    'n',
    '<Leader>g',
    '<Cmd>Trouble workspace_diagnostics<CR>',
    { desc = 'Show diagnostic across project' }
  )
  keymap_set('', '[g', function()
    vim.diagnostic.goto_prev({ float = { border = floating_window_border } })
  end, { desc = 'Jump to previous diagnostic' })
  keymap_set('', ']g', function()
    vim.diagnostic.goto_next({ float = { border = floating_window_border } })
  end, { desc = 'Jump to next diagnostic' })
  keymap_set('n', '<Localleader>a', vim.lsp.buf.code_action, { desc = 'Show code actions' })
  keymap_set('v', '<Localleader>a', vim.lsp.buf.range_code_action, { desc = 'Show code actions' })
  keymap_set('n', '<Localleader>f', vim.lsp.buf.formatting, { desc = 'Format current file' })
  keymap_set('v', '<Localleader>f', vim.lsp.buf.range_formatting, { desc = 'Format current range' })
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
