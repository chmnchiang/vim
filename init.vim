" Plugins (with vim-plug) {{{

if &compatible
    set nocompatible
endif

let g:plugin_base_path = $HOME.'/.vim/plugged'

call plug#begin(g:plugin_base_path)

" snippets
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/garbas/vim-snipmate'
Plug 'https://github.com/marcweber/vim-addon-mw-utils'
Plug 'https://github.com/tomtom/tlib_vim'

" fast deliminators
Plug 'https://github.com/tpope/vim-surround'

" comment shortcut
Plug 'https://github.com/scrooloose/nerdcommenter'

" powerline
Plug 'https://github.com/vim-airline/vim-airline'

" indent guide
Plug 'https://github.com/nathanaelkane/vim-indent-guides'

" deoplete
if has('nvim')
  Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'https://github.com/Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'https://github.com/Shougo/deoplete.nvim'
  Plug 'https://github.com/Shougo/denite.nvim'
  Plug 'https://github.com/roxma/nvim-yarp'
  Plug 'https://github.com/roxma/vim-hug-neovim-rpc'
endif

" neovim language server (nvim-lsp)
if has('nvim')
  Plug 'https://github.com/neovim/nvim-lsp'
  Plug 'https://github.com/neovim/nvim-lspconfig'
  Plug 'https://github.com/Shougo/deoplete-lsp'
endif

" git +/- sign
Plug 'https://github.com/airblade/vim-gitgutter'
" git operations
Plug 'https://github.com/tpope/vim-fugitive'

" fzf
if !filereadable('/usr/share/vim/vimfiles/plugin/fzf.vim')
  Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'https://github.com/junegunn/fzf.vim'

" plugins for different filetypes
let g:polyglot_disabled = ['rust']
Plug 'https://github.com/sheerun/vim-polyglot'

Plug 'https://github.com/ARM9/arm-syntax-vim'

call plug#end()

"}}}

" Basic Settings {{{

filetype plugin indent on
syntax enable
colorscheme meteor

" expand tabs to spaces.
set expandtab
" use 2 spaces for a tab
set tabstop=2 shiftwidth=2 softtabstop=2
" enable line number column
set number relativenumber
" allow cursor to move over lines
set whichwrap+=<,>,[,]
" key stroke timeout
set timeoutlen=300
" key sequence timeout, important for meta key to work
set ttimeoutlen=20
" preserve some lines above and below the cursor
set scrolloff=4
" don't move to start of line for commands G, gg ...
set nostartofline
" allow hidden buffers that have not been saved
set hidden
" always show the status line
set laststatus=2
" add current path to path
set path+=$PWD/**
" no conceal characters
set conceallevel=0
" enable fold
set foldenable
" set fold method
set foldmethod=marker
" do not show the annoying preview window
set completeopt-=preview
" always show the sign column
set signcolumn=yes
" enable true color if possible
if has("termguicolors")
    set termguicolors
endif

" Set cursor to last known position in Neovim
if has('nvim')
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
endif

"}}}

" Key Settings {{{

" set mapleader to be <space>
let mapleader=' '
" Define {j,k} to g{j,k}, useful when long lines
noremap j gj
noremap k gk
" ^ is more useful but hard to reach
noremap 0 ^
noremap ^ 0
" swap : and ,
noremap : ,
noremap , :
" ^A is used by tmux, change to + -
noremap + <C-a>
noremap - <C-x>
" ^A is used by tmux, change to ^B
inoremap <C-b> <C-a>
" buffer 
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>q :bd<CR>
" Terminal
if has("nvim")
  " tie usual escape to vim
  tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
  " use C-\ instead in terminal
  tnoremap <C-\> <C-[>
endif

"}}}

"{{{ Language client settings

if has('nvim')

lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<leader>;D', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>;d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>;i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>;t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>;r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>;a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>;f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader>;f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi link LspReferenceRead Search
      hi link LspReferenceText Search
      hi link LspReferenceWrite Search
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
  }
)

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { 
  "rust_analyzer",
  "tsserver",
  "pyls",
  "texlab",
  "clangd"
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

hi InfoSignText      guibg=#0087ff ctermbg=33
hi SignText          ctermbg=235
hi WarningSignNum    ctermbg=172

sign define LspDiagnosticsSignError         text=\ ✗  texthl=LspSignError     numhl=LspNumError
sign define LspDiagnosticsSignWarning       text=\ ‼  texthl=LspSignWarning   numhl=LspNumWarning
sign define LspDiagnosticsSignInformation   text=\ ℹ  texthl=LspSignInfo      numhl=LspNumInfo 
sign define LspDiagnosticsSignHint          text=\ ℹ  texthl=LspSignInfo      numhl=LspNumInfo

endif

"}}}

"{{{ Denite Settings (experimental, not used...)

call denite#custom#var('file/rec', 'command', ['rg', '--files'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#option('default', {
    \ 'split': 'floating',
    \ 'start_filter': 1,
    \ 'prompt': '/',
    \ 'highlight_filter_background': 'Prompt',
    \ 'highlight_matched_range': 'Underlined',
    \ 'match_highlight': 1
    \ })

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> o denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <C-[> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <leader>n denite#do_map('quit')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> / denite#do_map('open_filter_buffer')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <C-u><CR>
  imap <silent><buffer> <C-[> <Plug>(denite_filter_quit)
endfunction"}}}

" Other Plugin Settings {{{

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>f :Files<CR>

" netrw
nnoremap <leader>n :Explore <CR>

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" vim-indent-guide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=#242424 ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   guibg=#2c2c2c ctermbg=234

" deoplete.nvim
let g:deoplete#enable_at_startup = 1

" vim-gitgutter
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
let g:gitgutter_set_sign_backgrounds = 1
let g:gitgutter_map_keys = 0

" python-syntax
let g:python_highlight_all = 1

"}}}
