require 'meteor'

local opt = vim.opt

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

opt.number = true
opt.relativenumber = true

opt.cursorline = true

opt.whichwrap = 'b,s,<,>,[,]'

opt.timeoutlen = 300
opt.ttimeoutlen = 20
-- Keep four lines above and below the cursor
opt.scrolloff = 4
opt.startofline = false
-- Keep buffer when not active
opt.hidden = true
-- Disable conceal (some plugin might set it, force it to be 0)
opt.conceallevel = 0

opt.foldenable = true
opt.foldmethod = 'marker'
-- Remove the annoying preview window
opt.completeopt:remove('preview')
opt.pumheight = 15

opt.signcolumn = 'yes'
-- Incremental replace with preview
opt.inccommand = 'nosplit'
-- Default to split to the right.
opt.splitright = true
-- Restore the cursor to the line when reopen a file.
vim.cmd[[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]]
-- Map leaders. `mapleader` is used for global commands (switching buffers,
-- etc.), and `maplocalleader` is used for local commands (mainly for LSP
-- commands).
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local noremap = require'meteor.utils'.noremap
local noresimap = require'meteor.utils'.noresimap

noremap('n', 'j', 'gj')
noremap('n', 'k', 'gk')
noremap('n', '0', '^')
noremap('n', '^', '0')
noremap('n', ':', ',')
noremap('n', ',', ':')
noremap('v', ':', ',')
noremap('v', ',', ':')
noremap('n', '+', '<C-a>')
noremap('n', '-', '<C-x>')
noremap('i', '<C-b>', '<C-a>')

noresimap('n', '<leader>l', ':bnext<CR>')
noresimap('n', '<leader>h', ':bprev<CR>')
noresimap('n', '<leader>q', ':bdelete<CR>')
