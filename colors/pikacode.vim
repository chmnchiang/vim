" Vim color scheme
" Name:       pikacode.vim
" Author:     Leo Mao

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "pikacode"

set background=dark

if has('gui_running')
  " -> Text; Miscellaneous
  hi Normal         guibg=#1c1c1c guifg=#e4e4e4 gui=NONE
  hi SpecialKey     guibg=#1c1c1c guifg=#d787ff gui=NONE
  hi VertSplit      guibg=#1c1c1c guifg=#ffee68 gui=NONE
  hi SignColumn     guibg=#1c1c1c guifg=#bf81fa gui=NONE
  hi NonText        guibg=#1c1c1c guifg=#fc6984 gui=NONE
  hi Directory      guibg=#1c1c1c guifg=#ffee68 gui=NONE
  hi Title          guibg=#1c1c1c guifg=#d78700 gui=bold

  " -> Cursor
  hi Cursor         guibg=#e4e4e4 guifg=#1c1c1c gui=NONE
  hi CursorIM       guibg=#e4e4e4 guifg=#1c1c1c gui=NONE
  hi CursorColumn   guibg=#000000               gui=NONE
  hi CursorLine     guibg=#303030               gui=NONE
  hi CursorLineNR   guibg=#000000 guifg=#ffff00 gui=bold

  " -> Folding
  hi FoldColumn     guibg=#1c1c1c guifg=#005faf gui=NONE
  hi Folded         guibg=#1c1c1c guifg=#005faf gui=NONE

  " -> Line info
  hi LineNr         guibg=#000000 guifg=#696567 gui=NONE
  hi StatusLine     guibg=#444444 guifg=#a8a8a8 gui=NONE
  hi StatusLineNC   guibg=#262626 guifg=#a8a8a8 gui=NONE
  hi ColorColumn    guibg=#404040               gui=NONE
  hi WildMenu       guibg=#666666 guifg=#ffd75f gui=underline

  " -> Messages
  hi ErrorMsg       guibg=#a32024 guifg=#e4e4e4 gui=NONE
  hi Question       guibg=#1c1c1c guifg=#ffa500 gui=NONE
  hi WarningMsg     guibg=#ffa500 guifg=#000000 gui=NONE
  hi MoreMsg        guibg=#1c1c1c guifg=#ffa500 gui=NONE
  hi ModeMsg        guibg=#1c1c1c guifg=#ffa500 gui=NONE

  " -> Search
  hi Search         guibg=#696567 guifg=#ffee68 gui=NONE
  hi IncSearch      guibg=#696567 guifg=#ffee68 gui=NONE

  " -> Diff
  hi DiffAdd        guibg=#006124 guifg=#ed9000 gui=NONE
  hi DiffChange     guibg=#0b294a guifg=#a36000 gui=NONE
  hi DiffDelete     guibg=#081f38 guifg=#ed9000 gui=NONE
  hi DiffText       guibg=#12457d guifg=#ed9000 gui=underline

  " -> Menu
  hi Pmenu          guibg=#303030 guifg=#bcbcbc gui=NONE
  hi PmenuSel       guibg=#444444 guifg=#ffdf00 gui=NONE
  hi PmenuSbar      guibg=#5f5fff               gui=NONE
  hi PmenuThumb     guibg=#0000d7               gui=NONE

  " -> Tabs
  hi TabLine        guibg=#141414 guifg=#1c1c1c gui=NONE
  hi TabLineFill    guibg=#000000               gui=NONE
  hi TabLineSel     guibg=#1c1c1c guifg=#e4e4e4 gui=bold
  "
  " -> Visual Mode
  hi Visual         guibg=#404040               gui=NONE
  hi VisualNOS      guibg=#404040               gui=NONE

  " -> Code
  hi Number         guibg=#1c1c1c guifg=#af00ff gui=NONE
  hi Constant       guibg=#1c1c1c guifg=#d75f00 gui=NONE
  hi Character      guibg=#1c1c1c guifg=#ffaf5f gui=NONE
  hi String         guibg=#1c1c1c guifg=#ffaf5f gui=NONE
  hi Identifier     guibg=#1c1c1c guifg=#d78700 gui=NONE
  hi Function       guibg=#1c1c1c guifg=#5fffd7 gui=NONE
  hi Special        guibg=#1c1c1c guifg=#d75f00 gui=NONE
  hi Type           guibg=#1c1c1c guifg=#ffd75f gui=NONE
  hi Decorator      guibg=#1c1c1c guifg=#af5fff gui=NONE
  hi Operator       guibg=#1c1c1c guifg=#d7005f gui=NONE
  hi Delimiter      guibg=#1c1c1c guifg=#d7005f gui=NONE
  hi Statement      guibg=#1c1c1c guifg=#00afff gui=NONE
  hi Exception      guibg=#1c1c1c guifg=#5fff00 gui=NONE
  hi Include        guibg=#1c1c1c guifg=#87d700 gui=NONE
  hi PreProc        guibg=#1c1c1c guifg=#af87ff gui=NONE
  hi Ignore         guibg=#1c1c1c guifg=#1c1c1c gui=NONE
  hi Comment        guibg=#1c1c1c guifg=#626262 gui=NONE
  hi Todo           guibg=#1c1c1c guifg=#ff5f5f gui=bold
  hi Error          guibg=#1c1c1c guifg=#ff5f5f gui=NONE
  hi MatchParen     guibg=#585858
  hi Underlined     guibg=#1c1c1c guifg=#ff5f5f gui=underline

  " -> HTML-specific
  hi htmlBold                 guibg=#1c1c1c guifg=#e4e4e4 gui=bold
  hi htmlBoldItalic           guibg=#1c1c1c guifg=#e4e4e4 gui=bold,italic
  hi htmlBoldUnderline        guibg=#1c1c1c guifg=#e4e4e4 gui=bold,underline
  hi htmlBoldUnderlineItalic  guibg=#1c1c1c guifg=#e4e4e4 gui=bold,underline,italic
  hi htmlItalic               guibg=#1c1c1c guifg=#e4e4e4 gui=italic
  hi htmlUnderline            guibg=#1c1c1c guifg=#e4e4e4 gui=underline
  hi htmlUnderlineItalic      guibg=#1c1c1c guifg=#e4e4e4 gui=underline,italic
else
  " -> Text; Miscellaneous
  hi Normal         guibg=NONE    guifg=#e4e4e4 gui=NONE
  hi SpecialKey     guibg=NONE    guifg=#d787ff gui=NONE
  hi VertSplit      guibg=NONE    guifg=#ffee68 gui=NONE
  hi SignColumn     guibg=NONE    guifg=#bf81fa gui=NONE
  hi NonText        guibg=NONE    guifg=#fc6984 gui=NONE
  hi Directory      guibg=NONE    guifg=#ffee68 gui=NONE
  hi Title          guibg=NONE    guifg=#d78700 gui=bold

  " -> Cursor
  hi Cursor         guibg=#e4e4e4 guifg=#1c1c1c gui=NONE
  hi CursorIM       guibg=#e4e4e4 guifg=#1c1c1c gui=NONE
  hi CursorColumn   guibg=#000000               gui=NONE
  hi CursorLine     guibg=#303030               gui=NONE
  hi CursorLineNR   guibg=#000000 guifg=#ffff00 gui=bold

  " -> Folding
  hi FoldColumn     guibg=NONE    guifg=#005faf gui=NONE
  hi Folded         guibg=NONE    guifg=#005faf gui=NONE

  " -> Line info
  hi LineNr         guibg=#000000 guifg=#696567 gui=NONE
  hi StatusLine     guibg=#444444 guifg=#a8a8a8 gui=NONE
  hi StatusLineNC   guibg=#262626 guifg=#a8a8a8 gui=NONE
  hi ColorColumn    guibg=#404040               gui=NONE
  hi WildMenu       guibg=#666666 guifg=#ffd75f gui=underline

  " -> Messages
  hi ErrorMsg       guibg=#a32024 guifg=#e4e4e4 gui=NONE
  hi Question       guibg=NONE    guifg=#ffa500 gui=NONE
  hi WarningMsg     guibg=#ffa500 guifg=#000000 gui=NONE
  hi MoreMsg        guibg=NONE    guifg=#ffa500 gui=NONE
  hi ModeMsg        guibg=NONE    guifg=#ffa500 gui=NONE

  " -> Search
  hi Search         guibg=#696567 guifg=#ffee68 gui=NONE
  hi IncSearch      guibg=#696567 guifg=#ffee68 gui=NONE

  " -> Diff
  hi DiffAdd        guibg=#006124 guifg=#ed9000 gui=NONE
  hi DiffChange     guibg=#0b294a guifg=#a36000 gui=NONE
  hi DiffDelete     guibg=#081f38 guifg=#ed9000 gui=NONE
  hi DiffText       guibg=#12457d guifg=#ed9000 gui=underline

  " -> Menu
  hi Pmenu          guibg=#303030 guifg=#bcbcbc gui=NONE
  hi PmenuSel       guibg=#444444 guifg=#ffdf00 gui=NONE
  hi PmenuSbar      guibg=#5f5fff               gui=NONE
  hi PmenuThumb     guibg=#0000d7               gui=NONE

  " -> Tabs
  hi TabLine        guibg=#141414 guifg=#1c1c1c gui=NONE
  hi TabLineFill    guibg=#000000               gui=NONE
  hi TabLineSel     guibg=NONE    guifg=#e4e4e4 gui=bold
  "
  " -> Visual Mode
  hi Visual         guibg=#404040               gui=NONE
  hi VisualNOS      guibg=#404040               gui=NONE

  " -> Code
  hi Number         guibg=NONE    guifg=#af00ff gui=NONE
  hi Constant       guibg=NONE    guifg=#d75f00 gui=NONE
  hi Character      guibg=NONE    guifg=#ffaf5f gui=NONE
  hi String         guibg=NONE    guifg=#ffaf5f gui=NONE
  hi Identifier     guibg=NONE    guifg=#d78700 gui=NONE
  hi Function       guibg=NONE    guifg=#5fffd7 gui=NONE
  hi Special        guibg=NONE    guifg=#d75f00 gui=NONE
  hi Type           guibg=NONE    guifg=#ffd75f gui=NONE
  hi Decorator      guibg=NONE    guifg=#af5fff gui=NONE
  hi Operator       guibg=NONE    guifg=#d7005f gui=NONE
  hi Delimiter      guibg=NONE    guifg=#d7005f gui=NONE
  hi Statement      guibg=NONE    guifg=#00afff gui=NONE
  hi Exception      guibg=NONE    guifg=#5fff00 gui=NONE
  hi Include        guibg=NONE    guifg=#87d700 gui=NONE
  hi PreProc        guibg=NONE    guifg=#af87ff gui=NONE
  hi Ignore         guibg=NONE    guifg=#1c1c1c gui=NONE
  hi Comment        guibg=NONE    guifg=#626262 gui=NONE
  hi Todo           guibg=NONE    guifg=#ff5f5f gui=bold
  hi Error          guibg=NONE    guifg=#ff5f5f gui=NONE
  hi MatchParen     guibg=#585858
  hi Underlined     guibg=NONE    guifg=#ff5f5f gui=underline

  " -> HTML-specific
  hi htmlBold                 guibg=NONE    guifg=#e4e4e4 gui=bold
  hi htmlBoldItalic           guibg=NONE    guifg=#e4e4e4 gui=bold,italic
  hi htmlBoldUnderline        guibg=NONE    guifg=#e4e4e4 gui=bold,underline
  hi htmlBoldUnderlineItalic  guibg=NONE    guifg=#e4e4e4 gui=bold,underline,italic
  hi htmlItalic               guibg=NONE    guifg=#e4e4e4 gui=italic
  hi htmlUnderline            guibg=NONE    guifg=#e4e4e4 gui=underline
  hi htmlUnderlineItalic      guibg=NONE    guifg=#e4e4e4 gui=underline,italic
endif

" -> Text; Miscellaneous
hi Normal         ctermbg=NONE ctermfg=254  cterm=NONE
hi SpecialKey     ctermbg=NONE ctermfg=177  cterm=NONE
hi VertSplit      ctermbg=NONE ctermfg=227  cterm=NONE
hi SignColumn     ctermbg=NONE ctermfg=141  cterm=NONE
hi NonText        ctermbg=NONE ctermfg=204  cterm=NONE
hi Directory      ctermbg=NONE ctermfg=227  cterm=NONE
hi Title          ctermbg=NONE ctermfg=172  cterm=bold

" -> Cursor
hi Cursor         ctermbg=252  ctermfg=NONE cterm=NONE
hi CursorIM       ctermbg=22   ctermfg=NONE cterm=NONE
hi CursorColumn   ctermbg=NONE              cterm=NONE
hi CursorLine     ctermbg=NONE              cterm=NONE
hi CursorLineNR   ctermbg=NONE ctermfg=226  cterm=bold

" -> Folding
hi FoldColumn     ctermbg=NONE ctermfg=25   cterm=NONE
hi Folded         ctermbg=NONE ctermfg=25   cterm=NONE

" -> Line info
hi LineNr         ctermbg=16   ctermfg=241  cterm=NONE
hi StatusLine     ctermbg=238  ctermfg=248  cterm=NONE
hi StatusLineNC   ctermbg=235  ctermfg=248  cterm=NONE
hi ColorColumn    ctermbg=238               cterm=NONE
hi WildMenu       ctermbg=238  ctermfg=221  cterm=underline

" -> Messages
hi ErrorMsg       ctermbg=124  ctermfg=252  cterm=NONE
hi Question       ctermbg=NONE ctermfg=214  cterm=NONE
hi WarningMsg     ctermbg=214  ctermfg=0    cterm=NONE
hi MoreMsg        ctermbg=NONE ctermfg=214  cterm=NONE
hi ModeMsg        ctermbg=NONE ctermfg=214  cterm=NONE

" -> Search
hi Search         ctermbg=241  ctermfg=227  cterm=NONE
hi IncSearch      ctermbg=241  ctermfg=227  cterm=NONE

" -> Diff
hi DiffAdd        ctermbg=22   ctermfg=208  cterm=NONE
hi DiffChange     ctermbg=235  ctermfg=130  cterm=NONE
hi DiffDelete     ctermbg=NONE ctermfg=208  cterm=NONE
hi DiffText       ctermbg=24   ctermfg=208  cterm=underline

" -> Menu
hi Pmenu          ctermbg=236  ctermfg=250  cterm=NONE
hi PmenuSel       ctermbg=238  ctermfg=220  cterm=NONE
hi PmenuSbar      ctermbg=63                cterm=NONE
hi PmenuThumb     ctermbg=20                cterm=NONE

" -> Tabs
hi TabLine        ctermbg=233  ctermfg=NONE cterm=NONE
hi TabLineFill    ctermbg=NONE              cterm=NONE
hi TabLineSel     ctermbg=NONE ctermfg=252  cterm=bold
"
" -> Visual Mode
hi Visual         ctermbg=238               cterm=NONE
hi VisualNOS      ctermbg=238               cterm=NONE

" -> Code
hi Number         ctermbg=NONE ctermfg=129  cterm=NONE
hi Constant       ctermbg=NONE ctermfg=166  cterm=NONE
hi Character      ctermbg=NONE ctermfg=215  cterm=NONE
hi String         ctermbg=NONE ctermfg=215  cterm=NONE
hi Identifier     ctermbg=NONE ctermfg=172  cterm=NONE
hi Function       ctermbg=NONE ctermfg=86   cterm=NONE
hi Special        ctermbg=NONE ctermfg=166  cterm=NONE
hi Type           ctermbg=NONE ctermfg=221  cterm=NONE
hi Decorator      ctermbg=NONE ctermfg=135  cterm=NONE
hi Operator       ctermbg=NONE ctermfg=161  cterm=NONE
hi Delimiter      ctermbg=NONE ctermfg=161  cterm=NONE
hi Statement      ctermbg=NONE ctermfg=39   cterm=NONE
hi Exception      ctermbg=NONE ctermfg=82   cterm=NONE
hi Include        ctermbg=NONE ctermfg=112  cterm=NONE
hi PreProc        ctermbg=NONE ctermfg=141  cterm=NONE
hi Ignore         ctermbg=NONE ctermfg=NONE cterm=NONE
hi Comment        ctermbg=NONE ctermfg=241  cterm=NONE
hi Todo           ctermbg=NONE ctermfg=203  cterm=bold
hi Error          ctermbg=NONE ctermfg=203  cterm=NONE
hi MatchParen     ctermbg=240
hi Underlined     ctermbg=NONE ctermfg=203  cterm=underline

" -> HTML-specific
hi htmlBold                 ctermbg=NONE ctermfg=254 cterm=bold
hi htmlBoldItalic           ctermbg=NONE ctermfg=254 cterm=bold,italic
hi htmlBoldUnderline        ctermbg=NONE ctermfg=254 cterm=bold,underline
hi htmlBoldUnderlineItalic  ctermbg=NONE ctermfg=254 cterm=bold,underline,italic
hi htmlItalic               ctermbg=NONE ctermfg=254 cterm=italic
hi htmlUnderline            ctermbg=NONE ctermfg=254 cterm=underline
hi htmlUnderlineItalic      ctermbg=NONE ctermfg=254 cterm=underline,italic

hi! default link bbcodeBold htmlBold
hi! default link bbcodeBoldItalic htmlBoldItalic
hi! default link bbcodeBoldItalicUnderline htmlBoldUnderlineItalic
hi! default link bbcodeBoldUnderline htmlBoldUnderline
hi! default link bbcodeItalic htmlItalic
hi! default link bbcodeItalicUnderline htmlUnderlineItalic
hi! default link bbcodeUnderline htmlUnderline


" hi def link
"hi link Include Preproc
hi link Define Include

" Spellcheck formatting
if has("spell")
  hi SpellBad   guisp=#FC4234 gui=undercurl
  hi SpellCap   guisp=#70BDF1 gui=undercurl
  hi SpellLocal guisp=#FFEE68 gui=undercurl
  hi SpellRare  guisp=#6DF584 gui=undercurl
endif
