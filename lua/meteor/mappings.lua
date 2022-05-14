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

  local noremap = require'meteor.utils'.noremap
  local simap = require'meteor.utils'.simap
  local noresimap = require'meteor.utils'.noresimap
  -- Swap j <-> gj, k <-> gk. It is more intuitive when moving in long lines.
  vim.keymap.set('n', 'j', 'gj')
  vim.keymap.set('n', 'k', 'gk')
  vim.keymap.set('n', 'gj', 'j')
  vim.keymap.set('n', 'gk', 'k')
  -- Swap 0 <-> ^. 0 is easier to press while the original ^ is more useful.
  noremap('n', '0', '^')
  noremap('n', '^', '0')
  noremap('v', '0', '^')
  noremap('v', '^', '0')
  -- Swap : <-> ,. We use : more often so it deserves a non-shift modified key.
  vim.keymap.set('n', ':', ',')
  noremap('n', ',', ':')
  noremap('v', ':', ',')
  noremap('v', ',', ':')
  -- Make +/- be increasing/decreasing the number.
  noremap('n', '+', '<C-a>')
  noremap('n', '-', '<C-x>')
  -- Tmux uses <C-a>. Let's use <C-b> instead.
  noremap('i', '<C-b>', '<C-a>')
  -- Make window resizing easier.
  noremap('n', '<C-Right>', '<C-w>2>')
  noremap('n', '<C-Left>', '<C-w>2<')
  noremap('n', '<C-Up>', '<C-w>+')
  noremap('n', '<C-Down>', '<C-w>-')
  -- Make H and L navigate buffers.
  -- Nerd Commenter
  simap('n', '<Localleader>ca', '<Plug>NERDCommenterAltDelims')
  simap('n', '<Localleader>cA', '<Plug>NERDCommenterAppend')
  simap('n', '<Localleader>c<Localleader>', '<Plug>NERDCommenterToggle')
  simap('x', '<Localleader>c<Localleader>', '<Plug>NERDCommenterToggle')
  simap('n', '<Localleader>cc', '<Plug>NERDCommenterComment')
  simap('x', '<Localleader>cc', '<Plug>NERDCommenterComment')
  if opt.tabline then
    noresimap('n', '<leader>l', '<Cmd>BufferLineCycleNext<CR>')
    noresimap('n', 'L', '<Cmd>BufferLineCycleNext<CR>')
    noresimap('n', '<leader>h', '<Cmd>BufferLineCyclePrev<CR>')
    noresimap('n', 'H', '<Cmd>BufferLineCyclePrev<CR>')
    noresimap('n', '<leader>L', '<Cmd>BufferLineMoveNext<CR>')
    noresimap('n', '<leader>H', '<Cmd>BufferLineMovePrev<CR>')
    noresimap('n', '<leader>H', '<Cmd>BufferLineMovePrev<CR>')
    noresimap('n', '<leader>a', '<Cmd>BufferLinePick<CR>')
  else
    noresimap('n', '<leader>l', ':bnext<CR>')
    noresimap('n', 'L', ':bnext<CR>')
    noresimap('n', '<leader>h', ':bprev<CR>')
    noresimap('n', 'H', ':bprev<CR>')
    noresimap('n', '<leader>q', ':bdelete<CR>')
  end
  noresimap('n', '<leader>q', '<Cmd>:bdelete<CR>')
  noresimap('n', '<localleader>q', '<Cmd>:bdelete<CR>')
  noresimap('n', '<leader><leader>', '<Cmd>b #<CR>')
  if opt.telescope then
    noresimap('n', '<leader>b', '<Cmd>Telescope buffers<CR>')
    noresimap('n', '<leader>s', '<Cmd>Telescope live_grep<CR>')
    noresimap('n', '<leader>f', '<Cmd>Telescope find_files<CR>')
    noresimap('n', '<leader>r', '<Cmd>Telescope resume<CR>')
    noresimap('n', '<leader>c', '<Cmd>Telescope command_history<CR>')
  end
  if opt.nvim_tree then
    noresimap('n', '<leader>t', '<Cmd>NvimTreeToggle<CR>')
  end
  if opt.dap then
    noresimap('n', '<leader>dt',
        [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]])
    noresimap('n', '<leader>dc', [[<Cmd>lua require('dap').continue()<CR>]])
    noresimap('n', '<leader>ds', [[<Cmd>lua require('dap').step_over()<CR>]])
    noresimap('n', '<leader>di', [[<Cmd>lua require('dap').step_into()<CR>]])
    noresimap('n', '<leader>do', [[<Cmd>lua require('dap').step_out()<CR>]])
    noresimap('n', '<leader>du', [[<Cmd>lua require('dap').up()<CR>]])
    noresimap('n', '<leader>dd', [[<Cmd>lua require('dap').down()<CR>]])
    noresimap('n', '<leader>dC', [[<Cmd>lua require('dap').run_to_cursor()<CR>]])
    noresimap('n', '<leader>de', [[<Cmd>lua require('dapui').eval()<CR>]])
  end
end

return M
