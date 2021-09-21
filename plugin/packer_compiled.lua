-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/meteor/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/meteor/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/meteor/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/meteor/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/meteor/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["auto-session"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/auto-session"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\1\2W\0\2\6\0\5\0\14\16\3\1\0007\2\0\1%\4\1\0>\2\3\2\15\0\2\0T\3\2Ä%\2\2\0T\3\1Ä%\2\3\0%\3\4\0\16\4\2\0\16\5\0\0$\3\5\3H\3\2\0\6 \tÔÅ± \tÔôò \nerror\nmatch–\t\1\0\15\0/\0|4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0002\2\0\0004\3\4\0\16\4\1\0>\3\2\4T\6LÄ\16\b\0\0%\t\5\0%\n\6\0>\b\3\2\16\t\0\0%\n\5\0%\v\a\0>\t\3\2\16\n\0\0%\v\b\0%\f\6\0>\n\3\2\16\v\0\0%\f\b\0%\r\a\0>\v\3\2\a\a\t\0T\f\3Ä%\t\n\0%\v\n\0T\f\31Ä\a\a\v\0T\f\aÄ\16\f\0\0%\r\f\0%\14\a\0>\f\3\2\16\t\f\0\16\v\t\0T\f\22Ä\a\a\r\0T\f\aÄ\16\f\0\0%\r\14\0%\14\a\0>\f\3\2\16\t\f\0\16\v\t\0T\f\rÄ\a\a\15\0T\f\aÄ\16\f\0\0%\r\16\0%\14\a\0>\f\3\2\16\t\f\0\16\v\t\0T\f\4Ä\a\a\17\0T\f\2Ä%\t\18\0%\v\18\0\16\f\a\0\a\a\19\0T\r\1Ä%\f\20\0\6\a\21\0T\r\vÄ3\r\22\0:\b\23\r:\t\24\r9\r\f\2\16\r\a\0%\14\25\0$\r\14\r3\14\26\0:\b\23\14:\t\24\0149\14\r\2\16\r\a\0%\14\27\0$\r\14\r3\14\28\0:\n\23\14:\v\24\0149\14\r\2A\6\3\3N\6≤4\3\0\0%\4\29\0>\3\2\0027\3\30\0033\4\"\0003\5\31\0001\6 \0:\6!\5:\5#\4:\2$\4>\3\2\0014\3\0\0%\4\1\0>\3\2\0027\3%\3\16\4\3\0%\5&\0%\6'\0%\a(\0>\4\4\1\16\4\3\0%\5&\0%\6)\0%\a*\0>\4\4\1\16\4\3\0%\5&\0%\6+\0%\a,\0>\4\4\1\16\4\3\0%\5&\0%\6-\0%\a.\0>\4\4\1G\0\1\0\28:BufferLineMovePrev<CR>\18<leader><M-h>\28:BufferLineMoveNext<CR>\18<leader><M-l>\29:BufferLineCyclePrev<CR>\14<leader>h\29:BufferLineCycleNext<CR>\14<leader>l\6n\14noresimap\15highlights\foptions\1\0\0\26diagnostics_indicator\0\1\0\3\16diagnostics\rnvim_lsp\28show_buffer_close_icons\1\20separator_style\nslant\nsetup\15bufferline\1\0\0\14_selected\1\0\0\r_visible\nguifg\nguibg\1\0\0\14indicator\15background\vbuffer\f#afffff\rmodified\"LspDiagnosticsSignInformation\20info_diagnostic\30LspDiagnosticsSignWarning\23warning_diagnostic\28LspDiagnosticsSignError\21error_diagnostic\f#000000\14separator\15TabLineSel\afg\abg\fTabLine\vipairs\1\14\0\0\vbuffer\15diagnostic\tinfo\20info_diagnostic\fwarning\23warning_diagnostic\nerror\21error_diagnostic\rmodified\14duplicate\14separator\14indicator\tpick\24get_highlight_color\nutils\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/opt/bufferline.nvim"
  },
  colorscheme = {
    after = { "lualine.nvim", "bufferline.nvim" },
    loaded = true,
    only_config = true
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\1\2–\2\0\0\2\0\t\0\0174\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\0\0007\0\1\0%\1\3\0>\0\2\0014\0\0\0007\0\4\0003\1\6\0:\1\5\0004\0\0\0007\0\4\0003\1\b\0:\1\a\0G\0\1\0\1\3\0\0\20IndentGuidesOdd\21IndentGuidesEven)indent_blankline_char_highlight_list\1\2\0\0\rterminal%indent_blankline_buftype_exclude\6gEautocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guifg=#383838Fautocmd VimEnter,Colorscheme * :hi IndentGuidesEven guifg=#282828\bcmd\bvim\0" },
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lualine-signify-diff"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/lualine-signify-diff"
  },
  ["lualine.nvim"] = {
    config = { '\27LJ\1\2ô\6\0\0\t\0&\0B4\0\0\0%\1\1\0>\0\2\0027\0\2\0004\1\0\0%\2\3\0>\1\2\0027\1\4\0013\2\6\0003\3\5\0:\3\a\0023\3\t\0003\4\b\0:\4\n\0033\4\v\0:\4\f\0033\4\r\0003\5\14\0003\6\15\0:\6\16\5\16\6\0\0%\a\17\0%\b\18\0>\6\3\2:\6\19\5\16\6\0\0%\a\20\0%\b\18\0>\6\3\2:\6\21\5\16\6\0\0%\a\22\0%\b\18\0>\6\3\2:\6\23\5\16\6\0\0%\a\24\0%\b\18\0>\6\3\2:\6\25\0053\6\26\0:\6\27\5;\5\2\0043\5\28\0\16\6\0\0%\a\29\0%\b\18\0>\6\3\2:\6\30\5\16\6\0\0%\a\31\0%\b\18\0>\6\3\2:\6 \5\16\6\0\0%\a!\0%\b\18\0>\6\3\2:\6"\0053\6#\0:\6\27\5;\5\3\4:\4$\3:\3%\2>\1\2\1G\0\1\0\rsections\14lualine_c\1\0\3\nadded\6+\rmodified\6~\fremoved\6-\18color_removed\19DiffSignDelete\19color_modified\19DiffSignChange\16color_added\16DiffSignAdd\1\2\0\0\17signify_diff\fsymbols\1\0\4\thint\bÔ†¥\tinfo\tÔÅö \twarn\tÔÅ± \nerror\tÔôò \15color_hint\27LspDiagnosticsSignHint\15color_info"LspDiagnosticsSignInformation\15color_warn\30LspDiagnosticsSignWarning\16color_error\afg\28LspDiagnosticsSignError\fsources\1\2\0\0\rnvim_lsp\1\2\0\0\16diagnostics\1\2\0\0\rfilename\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\1\0\1\ntheme\fonedark\nsetup\flualine\24get_highlight_color\nutils\frequire\0' },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/opt/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/lush.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\1\2›\1\0\0\3\0\n\0\r4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\4\0%\1\5\0>\0\2\0027\0\6\0003\1\a\0003\2\b\0:\2\t\1>\0\2\1G\0\1\0\vsource\1\0\5\14ultisnips\2\rnvim_lsp\2\vbuffer\2\tcalc\2\tpath\2\1\0\4\17autocomplete\2\14preselect\venable\fenabled\2\15min_length\3\1\nsetup\ncompe\frequire\21menuone,noselect\16completeopt\6o\bvim\0" },
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\1\2A\2\0\3\1\3\0\a4\0\0\0007\0\1\0007\0\2\0+\1\0\0C\2\0\0=\0\1\1G\0\1\0\1¿\24nvim_buf_set_keymap\bapi\bvim¯\f\1\2\t\0)\0p1\2\0\0003\3\1\0\16\4\2\0%\5\2\0%\6\3\0%\a\4\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\5\0%\a\6\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\a\0%\a\b\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\t\0%\a\n\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\v\0%\a\f\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\r\0%\a\14\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\15\0%\a\16\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\17\0%\a\18\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\19\0%\a\20\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\21\0%\a\22\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\23\0%\a\24\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\25\0%\a\26\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\27\0%\a\28\0\16\b\3\0>\4\5\0017\4\29\0007\4\30\4\15\0\4\0T\5\6Ä\16\4\2\0%\5\2\0%\6\31\0%\a \0\16\b\3\0>\4\5\0017\4\29\0007\4!\4\15\0\4\0T\5\6Ä\16\4\2\0%\5\"\0%\6\31\0%\a#\0\16\b\3\0>\4\5\0017\4\29\0007\4$\4\15\0\4\0T\5\6Ä4\4%\0007\4&\0047\4'\4%\5(\0)\6\1\0>\4\3\0010\0\0ÄG\0\1\0‹\2      hi link LspReferenceRead Search\n      hi link LspReferenceText Search\n      hi link LspReferenceWrite Search\n      augroup lsp_document_highlight\n      autocmd! * <buffer>\n      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n      augroup END\n      \14nvim_exec\bapi\bvim\23document_highlight0<cmd>lua vim.lsp.buf.range_formatting()<CR>\6v\30document_range_formatting*<cmd>lua vim.lsp.buf.formatting()<CR>\15<leader>;f\24document_formatting\26resolved_capabilities2<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\14<leader>d0<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]g0<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[g<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\14<leader>e*<cmd>lua vim.lsp.buf.references()<CR>\15<leader>gr+<cmd>lua vim.lsp.buf.code_action()<CR>\15<leader>;a&<cmd>lua vim.lsp.buf.rename()<CR>\15<leader>;r/<cmd>lua vim.lsp.buf.type_definition()<CR>\15<leader>;t.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>.<cmd>lua vim.lsp.buf.implementation()<CR>\15<leader>;i%<Cmd>lua vim.lsp.buf.hover()<CR>\6K*<Cmd>lua vim.lsp.buf.definition()<CR>\agd+<Cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\vsilent\2\fnoremap\2\0ı\t\1\0\f\0/\0O4\0\0\0%\1\1\0>\0\2\0021\1\2\0004\2\3\0007\2\4\0027\2\5\0024\3\3\0007\3\4\0037\3\a\0034\4\3\0007\4\4\0047\4\b\0047\4\t\0043\5\n\0>\3\3\2:\3\6\0023\2\v\0004\3\f\0\16\4\2\0>\3\2\4T\6\5Ä6\b\a\0007\b\r\b3\t\14\0:\1\15\t>\b\2\1A\6\3\3N\6˘4\3\3\0007\3\16\0034\4\17\0007\4\18\4%\5\19\0>\3\3\0024\4\20\0007\4\21\4\16\5\3\0%\6\22\0>\4\3\0014\4\20\0007\4\21\4\16\5\3\0%\6\23\0>\4\3\0017\4\24\0007\4\r\0043\5\25\0:\1\15\0053\6\26\0:\6\27\0053\6+\0003\a\29\0003\b\28\0:\3\18\b:\b\30\a3\b \0003\t\31\0:\t!\b:\b\"\a3\b&\0004\t\3\0007\t#\t7\t$\t%\n%\0)\v\2\0>\t\3\2:\t'\b:\b(\a3\b)\0:\b*\a:\a,\6:\6-\5>\4\2\0014\4\3\0007\4\27\4%\5.\0>\4\2\1G\0\1\0÷\3    sign define LspDiagnosticsSignError         text=Ôôò  texthl=LspDiagnosticsSignError        numhl=LspNumError\n    sign define LspDiagnosticsSignWarning       text=ÔÅ±  texthl=LspDiagnosticsSignWarning      numhl=LspNumWarning\n    sign define LspDiagnosticsSignInformation   text=ÔÅö  texthl=LspDiagnosticsSignInformation  numhl=LspNumInformation\n    sign define LspDiagnosticsSignHint          text=Ô†¥  texthl=LspDiagnosticsSignHint         numhl=LspNumHint\n  \rsettings\bLua\1\0\0\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\bcmd\1\2\0\0\24lua-language-server\1\0\0\16sumneko_lua\19lua/?/init.lua\14lua/?.lua\vinsert\ntable\6;\tpath\fpackage\nsplit\14on_attach\1\0\0\nsetup\vipairs\1\6\0\0\18rust_analyzer\rtsserver\fpyright\vtexlab\vclangd\1\0\4\14underline\1\nsigns\2\17virtual_text\1\18severity_sort\2\27on_publish_diagnostics\15diagnostic\twith$textDocument/publishDiagnostics\rhandlers\blsp\bvim\0\14lspconfig\frequire\0" },
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\1\2ı\1\0\0\4\0\r\0\0194\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0%\2\4\0%\3\5\0>\0\4\0014\0\6\0007\0\a\0'\1\1\0:\1\b\0004\0\6\0007\0\a\0003\1\v\0003\2\n\0:\2\f\1:\1\t\0G\0\1\0\blsp\1\0\0\1\0\4\tinfo\tÔÅö \thint\bÔ†¥\nerror\tÔÅó \fwarning\tÔÅ± \20nvim_tree_icons\30nvim_tree_lsp_diagnostics\6g\bvim\29<cmd>:NvimTreeToggle<CR>\14<leader>t\6n\14noresimap\nutils\frequire\0" },
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope.nvim"] = {
    config = { '\27LJ\1\2‡\3\0\0\b\0\28\0+4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0027\2\3\0003\3\r\0003\4\v\0003\5\t\0003\6\5\0007\a\4\1:\a\6\0067\a\a\1:\a\b\6:\6\n\5:\5\f\4:\4\14\0033\4\16\0003\5\15\0:\5\17\4:\4\18\3>\2\2\0014\2\0\0%\3\19\0>\2\2\0027\2\20\2\16\3\2\0%\4\21\0%\5\22\0%\6\23\0>\3\4\1\16\3\2\0%\4\21\0%\5\24\0%\6\25\0>\3\4\1\16\3\2\0%\4\21\0%\5\26\0%\6\27\0>\3\4\1G\0\1\0"<cmd>Telescope find_files<CR>\14<leader>f!<cmd>Telescope live_grep<CR>\14<leader>g\31<cmd>Telescope buffers<CR>\14<leader>b\6n\14noresimap\nutils\fpickers\fbuffers\1\0\0\1\0\1\18sort_lastused\2\rdefaults\1\0\0\rmappings\1\0\0\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\1\0\0\24move_selection_next\nsetup\22telescope.actions\14telescope\frequire\0' },
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-oscyank"] = {
    config = { "\27LJ\1\2à\1\0\0\2\0\3\0\0054\0\0\0007\0\1\0%\1\2\0>\0\2\1G\0\1\0i autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif \bcmd\bvim\0" },
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/vim-oscyank"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-signify"] = {
    config = { "\27LJ\1\2{\0\0\2\0\6\0\r4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0%\1\3\0:\1\4\0004\0\0\0007\0\1\0'\1\n\0:\1\5\0G\0\1\0\21sighify_priority\24signify_sign_change\b‚îÇ\21signify_sign_add\6g\bvim\0" },
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/vim-signify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/meteor/.local/share/nvim/site/pack/packer/start/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: vim-signify
time([[Config for vim-signify]], true)
try_loadstring("\27LJ\1\2{\0\0\2\0\6\0\r4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0%\1\3\0:\1\4\0004\0\0\0007\0\1\0'\1\n\0:\1\5\0G\0\1\0\21sighify_priority\24signify_sign_change\b‚îÇ\21signify_sign_add\6g\bvim\0", "config", "vim-signify")
time([[Config for vim-signify]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\1\2A\2\0\3\1\3\0\a4\0\0\0007\0\1\0007\0\2\0+\1\0\0C\2\0\0=\0\1\1G\0\1\0\1¿\24nvim_buf_set_keymap\bapi\bvim¯\f\1\2\t\0)\0p1\2\0\0003\3\1\0\16\4\2\0%\5\2\0%\6\3\0%\a\4\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\5\0%\a\6\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\a\0%\a\b\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\t\0%\a\n\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\v\0%\a\f\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\r\0%\a\14\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\15\0%\a\16\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\17\0%\a\18\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\19\0%\a\20\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\21\0%\a\22\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\23\0%\a\24\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\25\0%\a\26\0\16\b\3\0>\4\5\1\16\4\2\0%\5\2\0%\6\27\0%\a\28\0\16\b\3\0>\4\5\0017\4\29\0007\4\30\4\15\0\4\0T\5\6Ä\16\4\2\0%\5\2\0%\6\31\0%\a \0\16\b\3\0>\4\5\0017\4\29\0007\4!\4\15\0\4\0T\5\6Ä\16\4\2\0%\5\"\0%\6\31\0%\a#\0\16\b\3\0>\4\5\0017\4\29\0007\4$\4\15\0\4\0T\5\6Ä4\4%\0007\4&\0047\4'\4%\5(\0)\6\1\0>\4\3\0010\0\0ÄG\0\1\0‹\2      hi link LspReferenceRead Search\n      hi link LspReferenceText Search\n      hi link LspReferenceWrite Search\n      augroup lsp_document_highlight\n      autocmd! * <buffer>\n      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n      augroup END\n      \14nvim_exec\bapi\bvim\23document_highlight0<cmd>lua vim.lsp.buf.range_formatting()<CR>\6v\30document_range_formatting*<cmd>lua vim.lsp.buf.formatting()<CR>\15<leader>;f\24document_formatting\26resolved_capabilities2<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\14<leader>d0<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]g0<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[g<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\14<leader>e*<cmd>lua vim.lsp.buf.references()<CR>\15<leader>gr+<cmd>lua vim.lsp.buf.code_action()<CR>\15<leader>;a&<cmd>lua vim.lsp.buf.rename()<CR>\15<leader>;r/<cmd>lua vim.lsp.buf.type_definition()<CR>\15<leader>;t.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>.<cmd>lua vim.lsp.buf.implementation()<CR>\15<leader>;i%<Cmd>lua vim.lsp.buf.hover()<CR>\6K*<Cmd>lua vim.lsp.buf.definition()<CR>\agd+<Cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\vsilent\2\fnoremap\2\0ı\t\1\0\f\0/\0O4\0\0\0%\1\1\0>\0\2\0021\1\2\0004\2\3\0007\2\4\0027\2\5\0024\3\3\0007\3\4\0037\3\a\0034\4\3\0007\4\4\0047\4\b\0047\4\t\0043\5\n\0>\3\3\2:\3\6\0023\2\v\0004\3\f\0\16\4\2\0>\3\2\4T\6\5Ä6\b\a\0007\b\r\b3\t\14\0:\1\15\t>\b\2\1A\6\3\3N\6˘4\3\3\0007\3\16\0034\4\17\0007\4\18\4%\5\19\0>\3\3\0024\4\20\0007\4\21\4\16\5\3\0%\6\22\0>\4\3\0014\4\20\0007\4\21\4\16\5\3\0%\6\23\0>\4\3\0017\4\24\0007\4\r\0043\5\25\0:\1\15\0053\6\26\0:\6\27\0053\6+\0003\a\29\0003\b\28\0:\3\18\b:\b\30\a3\b \0003\t\31\0:\t!\b:\b\"\a3\b&\0004\t\3\0007\t#\t7\t$\t%\n%\0)\v\2\0>\t\3\2:\t'\b:\b(\a3\b)\0:\b*\a:\a,\6:\6-\5>\4\2\0014\4\3\0007\4\27\4%\5.\0>\4\2\1G\0\1\0÷\3    sign define LspDiagnosticsSignError         text=Ôôò  texthl=LspDiagnosticsSignError        numhl=LspNumError\n    sign define LspDiagnosticsSignWarning       text=ÔÅ±  texthl=LspDiagnosticsSignWarning      numhl=LspNumWarning\n    sign define LspDiagnosticsSignInformation   text=ÔÅö  texthl=LspDiagnosticsSignInformation  numhl=LspNumInformation\n    sign define LspDiagnosticsSignHint          text=Ô†¥  texthl=LspDiagnosticsSignHint         numhl=LspNumHint\n  \rsettings\bLua\1\0\0\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\bcmd\1\2\0\0\24lua-language-server\1\0\0\16sumneko_lua\19lua/?/init.lua\14lua/?.lua\vinsert\ntable\6;\tpath\fpackage\nsplit\14on_attach\1\0\0\nsetup\vipairs\1\6\0\0\18rust_analyzer\rtsserver\fpyright\vtexlab\vclangd\1\0\4\14underline\1\nsigns\2\17virtual_text\1\18severity_sort\2\27on_publish_diagnostics\15diagnostic\twith$textDocument/publishDiagnostics\rhandlers\blsp\bvim\0\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: vim-oscyank
time([[Config for vim-oscyank]], true)
try_loadstring("\27LJ\1\2à\1\0\0\2\0\3\0\0054\0\0\0007\0\1\0%\1\2\0>\0\2\1G\0\1\0i autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif \bcmd\bvim\0", "config", "vim-oscyank")
time([[Config for vim-oscyank]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\1\2ı\1\0\0\4\0\r\0\0194\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0%\2\4\0%\3\5\0>\0\4\0014\0\6\0007\0\a\0'\1\1\0:\1\b\0004\0\6\0007\0\a\0003\1\v\0003\2\n\0:\2\f\1:\1\t\0G\0\1\0\blsp\1\0\0\1\0\4\tinfo\tÔÅö \thint\bÔ†¥\nerror\tÔÅó \fwarning\tÔÅ± \20nvim_tree_icons\30nvim_tree_lsp_diagnostics\6g\bvim\29<cmd>:NvimTreeToggle<CR>\14<leader>t\6n\14noresimap\nutils\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: colorscheme
time([[Config for colorscheme]], true)
try_loadstring("\27LJ\1\2]\0\0\2\0\5\0\t4\0\0\0007\0\1\0)\1\2\0:\1\2\0004\0\0\0007\0\3\0%\1\4\0>\0\2\1G\0\1\0\28colorscheme meteor-nvim\bcmd\18termguicolors\bopt\bvim\0", "config", "colorscheme")
time([[Config for colorscheme]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\1\2–\2\0\0\2\0\t\0\0174\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\0\0007\0\1\0%\1\3\0>\0\2\0014\0\0\0007\0\4\0003\1\6\0:\1\5\0004\0\0\0007\0\4\0003\1\b\0:\1\a\0G\0\1\0\1\3\0\0\20IndentGuidesOdd\21IndentGuidesEven)indent_blankline_char_highlight_list\1\2\0\0\rterminal%indent_blankline_buftype_exclude\6gEautocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guifg=#383838Fautocmd VimEnter,Colorscheme * :hi IndentGuidesEven guifg=#282828\bcmd\bvim\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
try_loadstring("\27LJ\1\2›\1\0\0\3\0\n\0\r4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\4\0%\1\5\0>\0\2\0027\0\6\0003\1\a\0003\2\b\0:\2\t\1>\0\2\1G\0\1\0\vsource\1\0\5\14ultisnips\2\rnvim_lsp\2\vbuffer\2\tcalc\2\tpath\2\1\0\4\17autocomplete\2\14preselect\venable\fenabled\2\15min_length\3\1\nsetup\ncompe\frequire\21menuone,noselect\16completeopt\6o\bvim\0", "config", "nvim-compe")
time([[Config for nvim-compe]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring('\27LJ\1\2‡\3\0\0\b\0\28\0+4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0027\2\3\0003\3\r\0003\4\v\0003\5\t\0003\6\5\0007\a\4\1:\a\6\0067\a\a\1:\a\b\6:\6\n\5:\5\f\4:\4\14\0033\4\16\0003\5\15\0:\5\17\4:\4\18\3>\2\2\0014\2\0\0%\3\19\0>\2\2\0027\2\20\2\16\3\2\0%\4\21\0%\5\22\0%\6\23\0>\3\4\1\16\3\2\0%\4\21\0%\5\24\0%\6\25\0>\3\4\1\16\3\2\0%\4\21\0%\5\26\0%\6\27\0>\3\4\1G\0\1\0"<cmd>Telescope find_files<CR>\14<leader>f!<cmd>Telescope live_grep<CR>\14<leader>g\31<cmd>Telescope buffers<CR>\14<leader>b\6n\14noresimap\nutils\fpickers\fbuffers\1\0\0\1\0\1\18sort_lastused\2\rdefaults\1\0\0\rmappings\1\0\0\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\1\0\0\24move_selection_next\nsetup\22telescope.actions\14telescope\frequire\0', "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd bufferline.nvim ]]

-- Config for: bufferline.nvim
try_loadstring("\27LJ\1\2W\0\2\6\0\5\0\14\16\3\1\0007\2\0\1%\4\1\0>\2\3\2\15\0\2\0T\3\2Ä%\2\2\0T\3\1Ä%\2\3\0%\3\4\0\16\4\2\0\16\5\0\0$\3\5\3H\3\2\0\6 \tÔÅ± \tÔôò \nerror\nmatch–\t\1\0\15\0/\0|4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0002\2\0\0004\3\4\0\16\4\1\0>\3\2\4T\6LÄ\16\b\0\0%\t\5\0%\n\6\0>\b\3\2\16\t\0\0%\n\5\0%\v\a\0>\t\3\2\16\n\0\0%\v\b\0%\f\6\0>\n\3\2\16\v\0\0%\f\b\0%\r\a\0>\v\3\2\a\a\t\0T\f\3Ä%\t\n\0%\v\n\0T\f\31Ä\a\a\v\0T\f\aÄ\16\f\0\0%\r\f\0%\14\a\0>\f\3\2\16\t\f\0\16\v\t\0T\f\22Ä\a\a\r\0T\f\aÄ\16\f\0\0%\r\14\0%\14\a\0>\f\3\2\16\t\f\0\16\v\t\0T\f\rÄ\a\a\15\0T\f\aÄ\16\f\0\0%\r\16\0%\14\a\0>\f\3\2\16\t\f\0\16\v\t\0T\f\4Ä\a\a\17\0T\f\2Ä%\t\18\0%\v\18\0\16\f\a\0\a\a\19\0T\r\1Ä%\f\20\0\6\a\21\0T\r\vÄ3\r\22\0:\b\23\r:\t\24\r9\r\f\2\16\r\a\0%\14\25\0$\r\14\r3\14\26\0:\b\23\14:\t\24\0149\14\r\2\16\r\a\0%\14\27\0$\r\14\r3\14\28\0:\n\23\14:\v\24\0149\14\r\2A\6\3\3N\6≤4\3\0\0%\4\29\0>\3\2\0027\3\30\0033\4\"\0003\5\31\0001\6 \0:\6!\5:\5#\4:\2$\4>\3\2\0014\3\0\0%\4\1\0>\3\2\0027\3%\3\16\4\3\0%\5&\0%\6'\0%\a(\0>\4\4\1\16\4\3\0%\5&\0%\6)\0%\a*\0>\4\4\1\16\4\3\0%\5&\0%\6+\0%\a,\0>\4\4\1\16\4\3\0%\5&\0%\6-\0%\a.\0>\4\4\1G\0\1\0\28:BufferLineMovePrev<CR>\18<leader><M-h>\28:BufferLineMoveNext<CR>\18<leader><M-l>\29:BufferLineCyclePrev<CR>\14<leader>h\29:BufferLineCycleNext<CR>\14<leader>l\6n\14noresimap\15highlights\foptions\1\0\0\26diagnostics_indicator\0\1\0\3\16diagnostics\rnvim_lsp\28show_buffer_close_icons\1\20separator_style\nslant\nsetup\15bufferline\1\0\0\14_selected\1\0\0\r_visible\nguifg\nguibg\1\0\0\14indicator\15background\vbuffer\f#afffff\rmodified\"LspDiagnosticsSignInformation\20info_diagnostic\30LspDiagnosticsSignWarning\23warning_diagnostic\28LspDiagnosticsSignError\21error_diagnostic\f#000000\14separator\15TabLineSel\afg\abg\fTabLine\vipairs\1\14\0\0\vbuffer\15diagnostic\tinfo\20info_diagnostic\fwarning\23warning_diagnostic\nerror\21error_diagnostic\rmodified\14duplicate\14separator\14indicator\tpick\24get_highlight_color\nutils\frequire\0", "config", "bufferline.nvim")

vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
try_loadstring('\27LJ\1\2ô\6\0\0\t\0&\0B4\0\0\0%\1\1\0>\0\2\0027\0\2\0004\1\0\0%\2\3\0>\1\2\0027\1\4\0013\2\6\0003\3\5\0:\3\a\0023\3\t\0003\4\b\0:\4\n\0033\4\v\0:\4\f\0033\4\r\0003\5\14\0003\6\15\0:\6\16\5\16\6\0\0%\a\17\0%\b\18\0>\6\3\2:\6\19\5\16\6\0\0%\a\20\0%\b\18\0>\6\3\2:\6\21\5\16\6\0\0%\a\22\0%\b\18\0>\6\3\2:\6\23\5\16\6\0\0%\a\24\0%\b\18\0>\6\3\2:\6\25\0053\6\26\0:\6\27\5;\5\2\0043\5\28\0\16\6\0\0%\a\29\0%\b\18\0>\6\3\2:\6\30\5\16\6\0\0%\a\31\0%\b\18\0>\6\3\2:\6 \5\16\6\0\0%\a!\0%\b\18\0>\6\3\2:\6"\0053\6#\0:\6\27\5;\5\3\4:\4$\3:\3%\2>\1\2\1G\0\1\0\rsections\14lualine_c\1\0\3\nadded\6+\rmodified\6~\fremoved\6-\18color_removed\19DiffSignDelete\19color_modified\19DiffSignChange\16color_added\16DiffSignAdd\1\2\0\0\17signify_diff\fsymbols\1\0\4\thint\bÔ†¥\tinfo\tÔÅö \twarn\tÔÅ± \nerror\tÔôò \15color_hint\27LspDiagnosticsSignHint\15color_info"LspDiagnosticsSignInformation\15color_warn\30LspDiagnosticsSignWarning\16color_error\afg\28LspDiagnosticsSignError\fsources\1\2\0\0\rnvim_lsp\1\2\0\0\16diagnostics\1\2\0\0\rfilename\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\1\0\1\ntheme\fonedark\nsetup\flualine\24get_highlight_color\nutils\frequire\0', "config", "lualine.nvim")

time([[Sequenced loading]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
