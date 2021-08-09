" Plugins (with vim-plug) {{{

if &compatible
    set nocompatible
endif

let g:plugin_base_path = $HOME.'/.vim/plugged'

call plug#begin(g:plugin_base_path)

" Icons (Used by cool-looking plugins)
Plug 'https://github.com/kyazdani42/nvim-web-devicons'
" Buffer line
Plug 'https://github.com/akinsho/nvim-bufferline.lua'
" Status line
Plug 'https://github.com/hoob3rt/lualine.nvim'

" Snippets (press tab to expand)
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/garbas/vim-snipmate'
Plug 'https://github.com/marcweber/vim-addon-mw-utils'
Plug 'https://github.com/tomtom/tlib_vim'

" Working with deliminators
Plug 'https://github.com/tpope/vim-surround'
" Working with comments
Plug 'https://github.com/scrooloose/nerdcommenter'

" File viewer (better than netrw!)
Plug 'https://github.com/kyazdani42/nvim-tree.lua'

" Indent guide
Plug 'https://github.com/nathanaelkane/vim-indent-guides'
" Trailing whitespaces
Plug 'https://github.com/ntpeters/vim-better-whitespace'

" Nvim language server config (nvim-lsp)
if has('nvim')
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/Shougo/deoplete-lsp'
Plug 'https://github.com/glepnir/lspsaga.nvim'
endif
" TODO: Support vim?

" Deoplete
if has('nvim')
Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
Plug 'https://github.com/roxma/nvim-yarp'
Plug 'https://github.com/roxma/vim-hug-neovim-rpc'
Plug 'https://github.com/Shougo/deoplete.nvim'
endif

" git +/- signs
Plug 'https://github.com/airblade/vim-gitgutter'
" git operations
Plug 'https://github.com/tpope/vim-fugitive'

" fzf
if !filereadable('/usr/share/vim/vimfiles/plugin/fzf.vim')
  Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
endif

" Fuzzy searcher
if has('nvim')
Plug 'https://github.com/nvim-lua/popup.nvim'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
else
Plug 'https://github.com/junegunn/fzf.vim'
endif

" Plugins for different filetypes
let g:polyglot_disabled = ['rust'] " not working good with lsp
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/ARM9/arm-syntax-vim'

" For developing colorscheme
Plug 'https://github.com/rktjmp/lush.nvim'

" My colorscheme
if has('nvim')
Plug 'https://github.com/chmnchiang/vim-color-scheme-meteor'
endif

call plug#end()

"}}}

" Basic Settings {{{

filetype plugin indent on
syntax enable

if has('nvim')
colorscheme meteor-nvim
else
colorscheme meteor
endif

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
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Set cursor to last known position in Neovim
if has('nvim')
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
endif
" TODO: rmagatti/auto-session?

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
" TODO: work with nvim-buffer
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

  -- Mappings (some moved to lspsaga...)
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>;i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>;t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<leader>;r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>;a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    -- buf_set_keymap("n", "<leader>;f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    -- buf_set_keymap("v", "<leader>;f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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
    underline = false,
    severity_sort = true,
  }
)

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
  "rust_analyzer",
  "tsserver",
  "pylsp",
  "texlab",
  "clangd"
}
for _, lsp in ipairs(servers) do
   nvim_lsp[lsp].setup { on_attach = on_attach }
end

require('lspsaga').init_lsp_saga {
  use_saga_diagnostic_sign = false,
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = false,
  },
}

EOF

nnoremap <silent> gr :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>;a :Lspsaga code_action<CR>
vnoremap <silent><leader>;a :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent><C-k> :Lspsaga signature_help<CR>
nnoremap <silent><leader>;r :Lspsaga rename<CR>
nnoremap <silent><leader>e :Lspsaga show_line_diagnostics<CR>
nnoremap <silent>[g :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>]g :Lspsaga diagnostic_jump_prev<CR>

sign define LspDiagnosticsSignError         text=  texthl=LspDiagnosticsSignError        numhl=LspNumError
sign define LspDiagnosticsSignWarning       text=  texthl=LspDiagnosticsSignWarning      numhl=LspNumWarning
sign define LspDiagnosticsSignInformation   text=  texthl=LspDiagnosticsSignInformation  numhl=LspNumInformation
sign define LspDiagnosticsSignHint          text=  texthl=LspDiagnosticsSignHint         numhl=LspNumHint

endif

"}}}

" Other Plugin Settings {{{

" Fuzzy finder
if has('nvim')
nnoremap <leader>b <cmd>Telescope buffers<CR>
nnoremap <leader>g <cmd>Telescope live_grep<CR>
nnoremap <leader>f <cmd>Telescope find_files<CR>
else
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>f :Files<CR>
endif

" File tree viewer
if has('nvim')
nnoremap <leader>t <cmd>:NvimTreeToggle <CR>
else
nnoremap <leader>n :Explore <CR>
endif

" vim-airline
if !has('nvim')
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
endif

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
let g:gitgutter_set_sign_backgrounds = 1
let g:gitgutter_map_keys = 0

" python-syntax
let g:python_highlight_all = 1

" snipMate
let g:snipMate = { 'snippet_version' : 1 }

if has('nvim')

lua << EOF
local function get_highlight_fg (name)
  return string.format("#%06x",
    vim.api.nvim_get_hl_by_name(name, true).foreground)
end

local bufferline_groups = {
  'buffer', 'diagnostic', 'info', 'info_diagnostic', 'warning',
  'warning_diagnostic', 'error', 'error_diagnostic', 'modified', 'duplicate',
  'separator', 'indicator', 'pick'
}
local bufferline_highlights = { }
for _, group in ipairs(bufferline_groups) do

  local guibg = { attribute = "bg", highlight = "TabLine" }
  local guifg = { attribute = "fg", highlight = "TabLine" }
  local guibg_sel = { attribute = "bg", highlight = "TabLineSel" }
  local guifg_sel = { attribute = "fg", highlight = "TabLineSel" }

  if group == 'separator' then
    guifg = '#000000'; guifg_sel = '#000000'
  elseif group == 'error_diagnostic' then
    guifg = get_highlight_fg('LspDiagnosticsSignError')
    guifg_sel = guifg
  elseif group == 'warning_diagnostic' then
    guifg = get_highlight_fg('LspDiagnosticsSignWarning')
    guifg_sel = guifg
  elseif group == 'info_diagnostic' then
    guifg = get_highlight_fg('LspDiagnosticsSignInformation')
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
  highlights = bufferline_highlights
}

require('lualine').setup {
  options = {
    theme = 'onedark',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      'filename',
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        color_error = get_highlight_fg('LspDiagnosticsSignError'),
        color_warn = get_highlight_fg('LspDiagnosticsSignWarning'),
        color_info = get_highlight_fg('LspDiagnosticsSignInformation'),
        color_hint = get_highlight_fg('LspDiagnosticsSignHint'),
        symbols = {error = ' ', warn = ' ', info = ' ', hint = ''}
      },
      {
        'diff',
        color_added = get_highlight_fg('GitGutterAdd'),
        color_modified = get_highlight_fg('GitGutterChange'),
        color_removed = get_highlight_fg('GitGutterDelete'),
      },
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      }
    }
  }
}
EOF
endif


"}}}
