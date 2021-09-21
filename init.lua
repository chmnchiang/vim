require 'plugins'

local opt = vim.opt

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

opt.number = true
opt.relativenumber = true

opt.whichwrap = 'b,s,<,>,[,]'

opt.timeoutlen = 300
opt.ttimeoutlen = 20

opt.scrolloff = 4
opt.startofline = false

opt.hidden = true

opt.conceallevel = 0

opt.foldenable = true
opt.foldmethod = 'marker'
opt.completeopt:remove('preview')

opt.signcolumn = 'yes'

opt.inccommand = 'nosplit'

vim.cmd[[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local noremap = require'utils'.noremap
local noresimap = require'utils'.noresimap

noremap('n', 'j', 'gj')
noremap('n', 'k', 'gk')
noremap('n', '0', '^')
noremap('n', '^', '0')
noremap('n', ':', ',')
noremap('n', ',', ':')
noremap('n', '+', '<C-a>')
noremap('n', '-', '<C-x>')
noremap('i', '<C-b>', '<C-a>')

noresimap('n', '<leader>l', ':bnext<CR>')
noresimap('n', '<leader>h', ':bprev<CR>')
noresimap('n', '<leader>q', ':bdelete<CR>')
