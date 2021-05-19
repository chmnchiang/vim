" meteor.vim -- Vim color scheme.
" Author:       ()
" Webpage:     
" Description: 
" Last Change: 2021-04-17

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "meteor"

if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
    hi Normal ctermbg=NONE ctermfg=254 cterm=NONE guibg=NONE guifg=#e4e4e4 gui=NONE
    hi SpecialKey ctermbg=NONE ctermfg=168 cterm=NONE guibg=NONE guifg=#d75f87 gui=NONE
    hi VertSplit ctermbg=NONE ctermfg=227 cterm=NONE guibg=NONE guifg=#ffff5f gui=NONE
    hi SignColumn ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
    hi NonText ctermbg=NONE ctermfg=168 cterm=NONE guibg=NONE guifg=#d75f87 gui=NONE
    hi Directory ctermbg=NONE ctermfg=39 cterm=NONE guibg=NONE guifg=#00afff gui=NONE
    hi Title ctermbg=NONE ctermfg=178 cterm=bold guibg=NONE guifg=#d7af00 gui=bold
    hi Cursor ctermbg=15 ctermfg=NONE cterm=NONE guibg=#ffffff guifg=NONE gui=NONE
    hi CursorIM ctermbg=15 ctermfg=NONE cterm=NONE guibg=#ffffff guifg=NONE gui=NONE
    hi CursorColumn ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1c1c1c guifg=NONE gui=NONE
    hi CursorLine ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1c1c1c guifg=NONE gui=NONE
    hi MatchParen ctermbg=240 ctermfg=NONE cterm=NONE guibg=#585858 guifg=NONE gui=NONE
    hi FoldColumn ctermbg=234 ctermfg=81 cterm=NONE guibg=#1c1c1c guifg=#5fd7ff gui=NONE
    hi Folded ctermbg=17 ctermfg=81 cterm=NONE guibg=#000040 guifg=#5fd7ff gui=NONE
    hi LineNr ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
    hi StatusLine ctermbg=237 ctermfg=247 cterm=NONE guibg=#3a3a3a guifg=#9e9e9e gui=NONE
    hi StatusLineNC ctermbg=233 ctermfg=247 cterm=NONE guibg=#121212 guifg=#9e9e9e gui=NONE
    hi ColorColumn ctermbg=240 ctermfg=NONE cterm=NONE guibg=#585858 guifg=NONE gui=NONE
    hi ErrorMsg ctermbg=124 ctermfg=254 cterm=NONE guibg=#af0000 guifg=#e4e4e4 gui=NONE
    hi Question ctermbg=NONE ctermfg=178 cterm=bold guibg=NONE guifg=#d7af00 gui=bold
    hi WarningMsg ctermbg=166 ctermfg=254 cterm=NONE guibg=#d75f00 guifg=#e4e4e4 gui=NONE
    hi MoreMsg ctermbg=NONE ctermfg=178 cterm=NONE guibg=NONE guifg=#d7af00 gui=NONE
    hi ModeMsg ctermbg=NONE ctermfg=178 cterm=NONE guibg=NONE guifg=#d7af00 gui=NONE
    hi Search ctermbg=240 ctermfg=227 cterm=underline guibg=#585858 guifg=#ffff5f gui=underline
    hi IncSearch ctermbg=28 ctermfg=227 cterm=NONE guibg=#008700 guifg=#ffff5f gui=NONE
    hi DiffAdd ctermbg=22 ctermfg=214 cterm=NONE guibg=#005f00 guifg=#ffaf00 gui=NONE
    hi DiffChange ctermbg=17 ctermfg=166 cterm=NONE guibg=#000040 guifg=#d75f00 gui=NONE
    hi DiffDelete ctermbg=NONE ctermfg=125 cterm=NONE guibg=NONE guifg=#af005f gui=NONE
    hi DiffText ctermbg=23 ctermfg=214 cterm=NONE guibg=#005f5f guifg=#ffaf00 gui=NONE
    hi Visual ctermbg=238 ctermfg=NONE cterm=NONE guibg=#444444 guifg=NONE gui=NONE
    hi VisualNOS ctermbg=238 ctermfg=NONE cterm=NONE guibg=#444444 guifg=NONE gui=NONE
    hi Pmenu ctermbg=236 ctermfg=250 cterm=NONE guibg=#3e2d20 guifg=#bcbcbc gui=NONE
    hi PmenuSel ctermbg=238 ctermfg=250 cterm=NONE guibg=#6c4822 guifg=#bcbcbc gui=NONE
    hi PmenuSbar ctermbg=244 ctermfg=15 cterm=NONE guibg=#808080 guifg=#ffffff gui=NONE
    hi TabLine ctermbg=236 ctermfg=242 cterm=NONE guibg=#303030 guifg=#6c6c6c gui=NONE
    hi TabLineSel ctermbg=190 ctermfg=237 cterm=NONE guibg=#d7ff00 guifg=#3a3a3a gui=NONE
    hi TabLineFill ctermbg=235 ctermfg=NONE cterm=NONE guibg=#262626 guifg=NONE gui=NONE
    hi Comment ctermbg=NONE ctermfg=244 cterm=NONE guibg=NONE guifg=#808080 gui=NONE
    hi Constant ctermbg=NONE ctermfg=166 cterm=NONE guibg=NONE guifg=#d75f00 gui=NONE
    hi String ctermbg=NONE ctermfg=215 cterm=NONE guibg=NONE guifg=#ffaf5f gui=NONE
    hi Character ctermbg=NONE ctermfg=221 cterm=NONE guibg=NONE guifg=#ffd75f gui=NONE
    hi Number ctermbg=NONE ctermfg=129 cterm=NONE guibg=NONE guifg=#af00ff gui=NONE
    hi Identifier ctermbg=NONE ctermfg=159 cterm=NONE guibg=NONE guifg=#afffff gui=NONE
    hi Function ctermbg=NONE ctermfg=87 cterm=NONE guibg=NONE guifg=#5fffff gui=NONE
    hi Statement ctermbg=NONE ctermfg=33 cterm=NONE guibg=NONE guifg=#0087ff gui=NONE
    hi Exception ctermbg=NONE ctermfg=69 cterm=NONE guibg=NONE guifg=#5f87ff gui=NONE
    hi PreProc ctermbg=NONE ctermfg=112 cterm=NONE guibg=NONE guifg=#87d700 gui=NONE
    hi Type ctermbg=NONE ctermfg=221 cterm=NONE guibg=NONE guifg=#ffd75f gui=NONE
    hi Special ctermbg=NONE ctermfg=168 cterm=NONE guibg=NONE guifg=#d75f87 gui=NONE
    hi Delimiter ctermbg=NONE ctermfg=198 cterm=NONE guibg=NONE guifg=#ff0087 gui=NONE
    hi Underlined ctermbg=NONE ctermfg=153 cterm=underline guibg=NONE guifg=#afd7ff gui=underline
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi Error ctermbg=88 ctermfg=NONE cterm=NONE guibg=#870000 guifg=NONE gui=NONE
    hi Todo ctermbg=NONE ctermfg=203 cterm=bold guibg=NONE guifg=#ff5f5f gui=bold
    hi Prompt ctermbg=235 ctermfg=254 cterm=NONE guibg=#262626 guifg=#e4e4e4 gui=NONE
    hi LspSignError ctermbg=234 ctermfg=160 cterm=NONE guibg=#1c1c1c guifg=#d70000 gui=NONE
    hi LspNumError ctermbg=88 ctermfg=NONE cterm=NONE guibg=#870000 guifg=NONE gui=NONE
    hi LspSignWarning ctermbg=234 ctermfg=208 cterm=NONE guibg=#1c1c1c guifg=#ff8700 gui=NONE
    hi LspNumWarning ctermbg=130 ctermfg=NONE cterm=NONE guibg=#af5f00 guifg=NONE gui=NONE
    hi LspSignInfo ctermbg=234 ctermfg=81 cterm=NONE guibg=#1c1c1c guifg=#5fd7ff gui=NONE
    hi LspNumInfo ctermbg=25 ctermfg=NONE cterm=NONE guibg=#005faf guifg=NONE gui=NONE

elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16

    hi Normal ctermbg=NONE ctermfg=white cterm=NONE
    hi SpecialKey ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi VertSplit ctermbg=NONE ctermfg=yellow cterm=NONE
    hi SignColumn ctermbg=black ctermfg=darkgray cterm=NONE
    hi NonText ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Directory ctermbg=NONE ctermfg=cyan cterm=NONE
    hi Title ctermbg=NONE ctermfg=yellow cterm=bold
    hi Cursor ctermbg=white ctermfg=NONE cterm=NONE
    hi CursorIM ctermbg=white ctermfg=NONE cterm=NONE
    hi CursorColumn ctermbg=black ctermfg=NONE cterm=NONE
    hi CursorLine ctermbg=black ctermfg=NONE cterm=NONE
    hi MatchParen ctermbg=darkgray ctermfg=NONE cterm=NONE
    hi FoldColumn ctermbg=black ctermfg=cyan cterm=NONE
    hi Folded ctermbg=blue ctermfg=cyan cterm=NONE
    hi LineNr ctermbg=black ctermfg=darkgray cterm=NONE
    hi StatusLine ctermbg=black ctermfg=darkgray cterm=NONE
    hi StatusLineNC ctermbg=black ctermfg=darkgray cterm=NONE
    hi ColorColumn ctermbg=darkgray ctermfg=NONE cterm=NONE
    hi ErrorMsg ctermbg=darkred ctermfg=white cterm=NONE
    hi Question ctermbg=NONE ctermfg=yellow cterm=bold
    hi WarningMsg ctermbg=darkyellow ctermfg=white cterm=NONE
    hi MoreMsg ctermbg=NONE ctermfg=yellow cterm=NONE
    hi ModeMsg ctermbg=NONE ctermfg=yellow cterm=NONE
    hi Search ctermbg=darkgray ctermfg=yellow cterm=underline
    hi IncSearch ctermbg=darkgreen ctermfg=yellow cterm=NONE
    hi DiffAdd ctermbg=darkgreen ctermfg=yellow cterm=NONE
    hi DiffChange ctermbg=blue ctermfg=darkyellow cterm=NONE
    hi DiffDelete ctermbg=NONE ctermfg=darkmagenta cterm=NONE
    hi DiffText ctermbg=darkcyan ctermfg=yellow cterm=NONE
    hi Visual ctermbg=darkgray ctermfg=NONE cterm=NONE
    hi VisualNOS ctermbg=darkgray ctermfg=NONE cterm=NONE
    hi Pmenu ctermbg=darkgray ctermfg=gray cterm=NONE
    hi PmenuSel ctermbg=gray ctermfg=gray cterm=NONE
    hi PmenuSbar ctermbg=darkgray ctermfg=white cterm=NONE
    hi TabLine ctermbg=black ctermfg=darkgray cterm=NONE
    hi TabLineSel ctermbg=yellow ctermfg=black cterm=NONE
    hi TabLineFill ctermbg=black ctermfg=NONE cterm=NONE
    hi Comment ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Constant ctermbg=NONE ctermfg=darkyellow cterm=NONE
    hi String ctermbg=NONE ctermfg=gray cterm=NONE
    hi Character ctermbg=NONE ctermfg=yellow cterm=NONE
    hi Number ctermbg=NONE ctermfg=magenta cterm=NONE
    hi Identifier ctermbg=NONE ctermfg=white cterm=NONE
    hi Function ctermbg=NONE ctermfg=cyan cterm=NONE
    hi Statement ctermbg=NONE ctermfg=cyan cterm=NONE
    hi Exception ctermbg=NONE ctermfg=gray cterm=NONE
    hi PreProc ctermbg=NONE ctermfg=darkyellow cterm=NONE
    hi Type ctermbg=NONE ctermfg=yellow cterm=NONE
    hi Special ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Delimiter ctermbg=NONE ctermfg=magenta cterm=NONE
    hi Underlined ctermbg=NONE ctermfg=gray cterm=underline
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE
    hi Error ctermbg=darkred ctermfg=NONE cterm=NONE
    hi Todo ctermbg=NONE ctermfg=red cterm=bold
    hi Prompt ctermbg=black ctermfg=white cterm=NONE
    hi LspSignError ctermbg=black ctermfg=red cterm=NONE
    hi LspNumError ctermbg=darkred ctermfg=NONE cterm=NONE
    hi LspSignWarning ctermbg=black ctermfg=yellow cterm=NONE
    hi LspNumWarning ctermbg=darkyellow ctermfg=NONE cterm=NONE
    hi LspSignInfo ctermbg=black ctermfg=cyan cterm=NONE
    hi LspNumInfo ctermbg=darkcyan ctermfg=NONE cterm=NONE
endif

hi link Float Number
hi link Typedef Keyword

let g:terminal_ansi_colors = [ '#000000', '#870000', '#005f00', '#808000', '#000087', '#8700af', '#00af87', '#c0c0c0', '#808080', '#ff0000', '#008000', '#ffff00', '#0000ff', '#ff00ff', '#00ffff', '#ffffff', ]

" Generated with RNB (https://github.com/romainl/vim-rnb)
