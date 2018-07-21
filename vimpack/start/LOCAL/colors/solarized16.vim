" Name:             Solarized 16
" Description:      Precision colors for machines and people
" Maintainer:       Von Random
" License:          OSI approved MIT license
" Last Updated:     Mon Jul 16 2018

" Original authors: Ethan Schoonover http://ethanschoonover.com/solarized
"                   Romain Lafourcade https://github.com/romainl/flattened
"                   Lifepillar https://github.com/lifepillar/vim-solarized8

" Re-flattened variant of Lifepillar's solarized8, because honestly, 256 color
" approximation is entirely pointless and I do not want any options in a bloody
" color scheme. It only supports truecolor and 16 colors hence the name.

if !(has('termguicolors') && &termguicolors) && !has('gui_running')
      \ && (!exists('&t_Co') || &t_Co < 16)
  echoerr '[Solarized 16] There are not enough colors.'
  finish
endif

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'solarized16'

if &background ==# 'dark'
  let g:terminal_ansi_colors = ['#073642', '#dc322f', '#859900', '#b58900', '#268bd2', '#d33682', '#2aa198', '#eee8d5',
        \ '#002b36', '#cb4b16', '#586e75', '#657b83', '#839496', '#6c71c4', '#93a1a1', '#fdf6e3']
  hi Normal ctermfg=12 ctermbg=8 guifg=#839496 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi FoldColumn ctermfg=12 ctermbg=0 guifg=#839496 guibg=#073642 guisp=NONE cterm=NONE gui=NONE
  hi Folded ctermfg=12 ctermbg=0 guifg=#839496 guibg=#073642 guisp=#002b36 cterm=NONE,bold gui=NONE,bold
  hi LineNr ctermfg=10 ctermbg=0 guifg=#586e75 guibg=#073642 guisp=NONE cterm=NONE gui=NONE
  hi Terminal ctermfg=fg ctermbg=8 guifg=fg guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi CursorLineNr ctermbg=0 guibg=#073642
  hi CursorLineNr ctermfg=12 guifg=#839496 cterm=bold gui=bold
  hi NonText ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi SpecialKey ctermfg=11 ctermbg=0 guifg=#657b83 guibg=#073642 guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi SpellBad ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=#6c71c4 cterm=NONE,underline gui=NONE,undercurl
  hi SpellCap ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=#6c71c4 cterm=NONE,underline gui=NONE,undercurl
  hi SpellLocal ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=#b58900 cterm=NONE,underline gui=NONE,undercurl
  hi SpellRare ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=#2aa198 cterm=NONE,underline gui=NONE,undercurl
  hi Title ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi ColorColumn ctermfg=NONE ctermbg=0 guifg=NONE guibg=#073642 guisp=NONE cterm=NONE gui=NONE
  hi Conceal ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi Cursor ctermfg=15 ctermbg=4 guifg=#fdf6e3 guibg=#268bd2 guisp=NONE cterm=NONE gui=NONE
  hi CursorColumn ctermfg=NONE ctermbg=0 guifg=NONE guibg=#073642 guisp=NONE cterm=NONE gui=NONE
  hi CursorLine ctermfg=NONE ctermbg=0 guifg=NONE guibg=#073642 guisp=#93a1a1 cterm=NONE gui=NONE
  hi DiffAdd ctermfg=2 ctermbg=0 guifg=#859900 guibg=#073642 guisp=#859900 cterm=NONE gui=NONE
  hi DiffChange ctermfg=3 ctermbg=0 guifg=#b58900 guibg=#073642 guisp=#b58900 cterm=NONE gui=NONE
  hi DiffDelete ctermfg=1 ctermbg=0 guifg=#dc322f guibg=#073642 guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi DiffText ctermfg=4 ctermbg=0 guifg=#268bd2 guibg=#073642 guisp=#268bd2 cterm=NONE gui=NONE
  hi Directory ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi EndOfBuffer ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi ErrorMsg ctermfg=1 ctermbg=15 guifg=#dc322f guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi IncSearch ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,standout gui=NONE,standout
  hi MatchParen ctermfg=15 ctermbg=0 guifg=#fdf6e3 guibg=#073642 guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi ModeMsg ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi MoreMsg ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi Pmenu ctermfg=12 ctermbg=0 guifg=#839496 guibg=#073642 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi PmenuSbar ctermfg=7 ctermbg=12 guifg=#eee8d5 guibg=#839496 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi PmenuSel ctermfg=10 ctermbg=7 guifg=#586e75 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi PmenuThumb ctermfg=12 ctermbg=8 guifg=#839496 guibg=#002b36 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi Question ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi! link QuickFixLine Search
  hi Search ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi SignColumn ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi StatusLine ctermfg=12 ctermbg=0 guifg=#839496 guibg=#073642 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi StatusLineNC ctermfg=10 ctermbg=0 guifg=#586e75 guibg=#073642 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi TabLine ctermfg=10 ctermbg=0 guifg=#586e75 guibg=#073642 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi TabLineFill ctermfg=10 ctermbg=0 guifg=#586e75 guibg=#073642 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi TabLineSel ctermfg=12 ctermbg=0 guifg=#839496 guibg=#073642 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLineNC
  hi VertSplit ctermfg=0 ctermbg=10 guifg=#073642 guibg=#586e75 guisp=NONE cterm=NONE gui=NONE
  hi Visual ctermfg=10 ctermbg=8 guifg=#586e75 guibg=#002b36 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi VisualNOS ctermfg=NONE ctermbg=0 guifg=NONE guibg=#073642 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi WarningMsg ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi WildMenu ctermfg=7 ctermbg=0 guifg=#eee8d5 guibg=#073642 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi! link Boolean Constant
  hi! link Character Constant
  hi Comment ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
  hi! link Conditional Statement
  hi Constant ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link Define PreProc
  hi! link Debug Special
  hi! link Delimiter Special
  hi Error ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi! link Exception Statement
  hi! link Float Constant
  hi! link Function Identifier
  hi Identifier ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link Include PreProc
  hi! link Keyword Statement
  hi! link Label Statement
  hi! link Macro PreProc
  hi! link Number Constant
  hi! link Operator Statement
  hi! link PreCondit PreProc
  hi PreProc ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link Repeat Statement
  hi Special ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link SpecialChar Special
  hi! link SpecialComment Special
  hi Statement ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link StorageClass Type
  hi! link String Constant
  hi! link Structure Type
  hi! link Tag Special
  hi Todo ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi Type ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link Typedef Type
  hi Underlined ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link lCursor Cursor
  hi CursorIM ctermfg=NONE ctermbg=fg guifg=NONE guibg=fg guisp=NONE cterm=NONE gui=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=0 guifg=NONE guibg=#073642 guisp=NONE cterm=NONE gui=NONE
  hi ToolbarButton ctermfg=14 ctermbg=0 guifg=#93a1a1 guibg=#073642 guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi NormalMode ctermfg=12 ctermbg=15 guifg=#839496 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi InsertMode ctermfg=6 ctermbg=15 guifg=#2aa198 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi ReplaceMode ctermfg=9 ctermbg=15 guifg=#cb4b16 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi VisualMode ctermfg=5 ctermbg=15 guifg=#d33682 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi CommandMode ctermfg=5 ctermbg=15 guifg=#d33682 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi! link vimVar Identifier
  hi! link vimFunc Function
  hi! link vimUserFunc Function
  hi! link helpSpecial Special
  hi! link vimSet Normal
  hi! link vimSetEqual Normal
  hi vimCommentString ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi vimCommand ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi vimCmdSep ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi helpExample ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi helpOption ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi helpNote ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi helpVim ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi helpHyperTextJump ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi helpHyperTextEntry ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi vimIsCommand ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi vimSynMtchOpt ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi vimSynType ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi vimHiLink ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi vimHiGroup ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi vimGroup ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi! link diffAdded Statement
  hi! link diffLine Identifier
  hi gitcommitComment ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
  hi! link gitcommitUntracked gitcommitComment
  hi! link gitcommitDiscarded gitcommitComment
  hi! link gitcommitSelected gitcommitComment
  hi gitcommitUnmerged ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi gitcommitOnBranch ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi gitcommitBranch ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi! link gitcommitNoBranch gitcommitBranch
  hi gitcommitdiscardedtype ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi gitcommitselectedtype ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi gitcommitHeader ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi gitcommitUntrackedFile ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi gitcommitDiscardedFile ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi gitcommitSelectedFile ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi gitcommitUnmergedFile ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi gitcommitFile ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
  hi! link gitcommitSelectedArrow gitcommitSelectedFile
  hi! link gitcommitUnmergedArrow gitcommitUnmergedFile
  hi htmlTag ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi htmlEndTag ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi htmlTagN ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi htmlTagName ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi htmlSpecialTagName ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
  hi htmlArg ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi javaScript ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link jsFuncCall Function
  hi perlHereDoc ctermfg=14 ctermbg=8 guifg=#93a1a1 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi perlVarPlain ctermfg=3 ctermbg=8 guifg=#b58900 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi perlStatementFileDesc ctermfg=6 ctermbg=8 guifg=#2aa198 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi texstatement ctermfg=6 ctermbg=8 guifg=#2aa198 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi texmathzonex ctermfg=3 ctermbg=8 guifg=#b58900 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi texmathmatcher ctermfg=3 ctermbg=8 guifg=#b58900 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi texreflabel ctermfg=3 ctermbg=8 guifg=#b58900 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi rubyDefine ctermfg=14 ctermbg=8 guifg=#93a1a1 guibg=#002b36 guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi! link rubySymbol Type
  hi rubyBoolean ctermfg=5 ctermbg=8 guifg=#d33682 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  let hs_highlight_boolean=1
  let hs_highlight_delimiters=1
  hi cPreCondit ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi VarId ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi ConId ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsImport ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsString ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsStructure ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hs_hlFunctionName ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsStatement ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsImportLabel ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hs_OpFunctionName ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hs_DeclareFunction ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsVarSym ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsType ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsTypedef ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsModuleName ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link hsImportParams Delimiter
  hi! link hsDelimTypeExport Delimiter
  hi! link hsModuleStartLabel hsStructure
  hi! link hsModuleWhereLabel hsModuleStartLabel
  hi hsNiceOperator ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi hsniceoperator ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocTitleBlock ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocTitleBlockTitle ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocTitleComment ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocComment ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
  hi pandocVerbatimBlock ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link pandocVerbatimBlockDeep pandocVerbatimBlock
  hi! link pandocCodeBlock pandocVerbatimBlock
  hi! link pandocCodeBlockDelim pandocVerbatimBlock
  hi pandocBlockQuote ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocBlockQuoteLeader1 ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocBlockQuoteLeader2 ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocBlockQuoteLeader3 ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocBlockQuoteLeader4 ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocBlockQuoteLeader5 ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocBlockQuoteLeader6 ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocListMarker ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocListReference ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocDefinitionBlock ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocDefinitionTerm ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,standout gui=NONE,standout
  hi pandocDefinitionIndctr ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocEmphasisDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
  hi pandocEmphasisNestedDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisNestedDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisEmphasisDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrikeoutDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi pandocVerbatimInlineDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocSuperscriptDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocSubscriptDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocTableStructure ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link pandocTableStructureTop pandocTableStructre
  hi! link pandocTableStructureEnd pandocTableStructre
  hi pandocTableZebraLight ctermfg=4 ctermbg=8 guifg=#268bd2 guibg=#002b36 guisp=NONE cterm=NONE gui=NONE
  hi pandocTableZebraDark ctermfg=4 ctermbg=0 guifg=#268bd2 guibg=#073642 guisp=NONE cterm=NONE gui=NONE
  hi pandocEmphasisTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
  hi pandocEmphasisNestedTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisNestedTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisEmphasisTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrikeoutTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi pandocVerbatimInlineTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocSuperscriptTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocSubscriptTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocHeadingMarker ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocEmphasisHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocEmphasisNestedHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisNestedHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisEmphasisHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrikeoutHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi pandocVerbatimInlineHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocSuperscriptHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocSubscriptHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocLinkDelim ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocLinkLabel ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocLinkText ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocLinkURL ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocLinkTitle ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocLinkTitleDelim ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=#657b83 cterm=NONE gui=NONE
  hi pandocLinkDefinition ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=#657b83 cterm=NONE gui=NONE
  hi pandocLinkDefinitionID ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocImageCaption ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocFootnoteLink ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocFootnoteDefLink ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocFootnoteInline ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocFootnote ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocCitationDelim ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocCitation ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocCitationID ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocCitationRef ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocStyleDelim ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocEmphasis ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
  hi pandocEmphasisNested ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasis ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisNested ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrongEmphasisEmphasis ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocStrikeout ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi pandocVerbatimInline ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocSuperscript ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocSubscript ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocRule ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocRuleLine ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocEscapePair ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi pandocCitationRef ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocNonBreakingSpace ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi! link pandocEscapedCharacter pandocEscapePair
  hi! link pandocLineBreak pandocEscapePair
  hi pandocMetadataDelim ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocMetadata ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocMetadataKey ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi pandocMetadata ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi! link pandocMetadataTitle pandocMetadata
  if has('nvim')
    hi! link TermCursor Cursor
    hi TermCursorNC ctermfg=8 ctermbg=10 guifg=#002b36 guibg=#586e75 guisp=NONE cterm=NONE gui=NONE
    let g:terminal_color_8='#002b36'
    let g:terminal_color_0='#073642'
    let g:terminal_color_10='#586e75'
    let g:terminal_color_11='#657b83'
    let g:terminal_color_12='#839496'
    let g:terminal_color_14='#93a1a1'
    let g:terminal_color_7='#eee8d5'
    let g:terminal_color_15='#fdf6e3'
    let g:terminal_color_3='#b58900'
    let g:terminal_color_9='#cb4b16'
    let g:terminal_color_1='#dc322f'
    let g:terminal_color_5='#d33682'
    let g:terminal_color_13='#6c71c4'
    let g:terminal_color_4='#268bd2'
    let g:terminal_color_6='#2aa198'
    let g:terminal_color_2='#859900'
  endif
  finish
endif

let g:terminal_ansi_colors = ['#eee8d5', '#dc322f', '#859900', '#b58900', '#268bd2', '#d33682', '#2aa198', '#073642',
      \ '#fdf6e3', '#cb4b16', '#93a1a1', '#839496', '#657b83', '#6c71c4', '#586e75', '#002b36']
hi Normal ctermfg=11 ctermbg=15 guifg=#657b83 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi FoldColumn ctermfg=11 ctermbg=7 guifg=#657b83 guibg=#eee8d5 guisp=NONE cterm=NONE gui=NONE
hi Folded ctermfg=11 ctermbg=7 guifg=#657b83 guibg=#eee8d5 guisp=#fdf6e3 cterm=NONE,bold gui=NONE,bold
hi LineNr ctermfg=14 ctermbg=7 guifg=#93a1a1 guibg=#eee8d5 guisp=NONE cterm=NONE gui=NONE
hi Terminal ctermfg=fg ctermbg=15 guifg=fg guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi CursorLineNr ctermbg=7 guibg=#eee8d5
hi CursorLineNr ctermfg=11 guifg=#657b83 cterm=bold gui=bold
hi Cursor ctermfg=15 ctermbg=9 guifg=#fdf6e3 guibg=#cb4b16 guisp=NONE cterm=NONE gui=NONE
hi MatchParen ctermfg=1 ctermbg=7 guifg=#dc322f guibg=#eee8d5 guisp=NONE cterm=NONE,bold,underline gui=NONE,bold,underline
hi NonText ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi SpecialKey ctermfg=12 ctermbg=7 guifg=#839496 guibg=#eee8d5 guisp=NONE cterm=NONE,bold gui=NONE,bold
hi SpellBad ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=#6c71c4 cterm=NONE,underline gui=NONE,undercurl
hi SpellCap ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=#6c71c4 cterm=NONE,underline gui=NONE,undercurl
hi SpellLocal ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=#b58900 cterm=NONE,underline gui=NONE,undercurl
hi SpellRare ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=#2aa198 cterm=NONE,underline gui=NONE,undercurl
hi Title ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi ColorColumn ctermfg=NONE ctermbg=7 guifg=NONE guibg=#eee8d5 guisp=NONE cterm=NONE gui=NONE
hi Conceal ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=7 guifg=NONE guibg=#eee8d5 guisp=NONE cterm=NONE gui=NONE
hi CursorLine ctermfg=NONE ctermbg=7 guifg=NONE guibg=#eee8d5 guisp=#586e75 cterm=NONE gui=NONE
hi DiffAdd ctermfg=2 ctermbg=7 guifg=#859900 guibg=#eee8d5 guisp=#859900 cterm=NONE gui=NONE
hi DiffChange ctermfg=3 ctermbg=7 guifg=#b58900 guibg=#eee8d5 guisp=#b58900 cterm=NONE gui=NONE
hi DiffDelete ctermfg=1 ctermbg=7 guifg=#dc322f guibg=#eee8d5 guisp=NONE cterm=NONE,bold gui=NONE,bold
hi DiffText ctermfg=4 ctermbg=7 guifg=#268bd2 guibg=#eee8d5 guisp=#268bd2 cterm=NONE gui=NONE
hi Directory ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi EndOfBuffer ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi ErrorMsg ctermfg=1 ctermbg=15 guifg=#dc322f guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi IncSearch ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,standout gui=NONE,standout
hi ModeMsg ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi MoreMsg ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Pmenu ctermfg=11 ctermbg=7 guifg=#657b83 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi PmenuSbar ctermfg=0 ctermbg=11 guifg=#073642 guibg=#657b83 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi PmenuSel ctermfg=14 ctermbg=0 guifg=#93a1a1 guibg=#073642 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi PmenuThumb ctermfg=11 ctermbg=15 guifg=#657b83 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi Question ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi! link QuickFixLine Search
hi Search ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi SignColumn ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi StatusLine ctermfg=10 ctermbg=7 guifg=#586e75 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi StatusLineNC ctermfg=12 ctermbg=7 guifg=#839496 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi TabLine ctermfg=12 ctermbg=7 guifg=#839496 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi TabLineFill ctermfg=12 ctermbg=7 guifg=#839496 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi TabLineSel ctermfg=10 ctermbg=7 guifg=#586e75 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi VertSplit ctermfg=10 ctermbg=14 guifg=#586e75 guibg=#93a1a1 guisp=NONE cterm=NONE gui=NONE
hi Visual ctermfg=14 ctermbg=15 guifg=#93a1a1 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi VisualNOS ctermfg=NONE ctermbg=7 guifg=NONE guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi WarningMsg ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi WildMenu ctermfg=0 ctermbg=7 guifg=#073642 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi! link Boolean Constant
hi! link Character Constant
hi Comment ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
hi! link Conditional Statement
hi Constant ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link Define PreProc
hi! link Debug Special
hi! link Delimiter Special
hi Error ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi! link Exception Statement
hi! link Float Constant
hi! link Function Identifier
hi Identifier ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Ignore ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link Macro PreProc
hi! link Number Constant
hi! link Operator Statement
hi! link PreCondit PreProc
hi PreProc ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link Repeat Statement
hi Special ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link SpecialChar Special
hi! link SpecialComment Special
hi Statement ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link StorageClass Type
hi! link String Constant
hi! link Structure Type
hi! link Tag Special
hi Todo ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi Type ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link Typedef Type
hi Underlined ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link lCursor Cursor
hi CursorIM ctermfg=NONE ctermbg=fg guifg=NONE guibg=fg guisp=NONE cterm=NONE gui=NONE
hi ToolbarLine ctermfg=NONE ctermbg=7 guifg=NONE guibg=#eee8d5 guisp=NONE cterm=NONE gui=NONE
hi ToolbarButton ctermfg=10 ctermbg=7 guifg=#586e75 guibg=#eee8d5 guisp=NONE cterm=NONE,bold gui=NONE,bold
hi NormalMode ctermfg=10 ctermbg=15 guifg=#586e75 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi InsertMode ctermfg=6 ctermbg=15 guifg=#2aa198 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi ReplaceMode ctermfg=9 ctermbg=15 guifg=#cb4b16 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi VisualMode ctermfg=5 ctermbg=15 guifg=#d33682 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi CommandMode ctermfg=5 ctermbg=15 guifg=#d33682 guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi! link vimVar Identifier
hi! link vimFunc Function
hi! link vimUserFunc Function
hi! link helpSpecial Special
hi! link vimSet Normal
hi! link vimSetEqual Normal
hi vimCommentString ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi vimCommand ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi vimCmdSep ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi helpExample ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi helpOption ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi helpNote ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi helpVim ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi helpHyperTextJump ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi helpHyperTextEntry ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi vimIsCommand ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi vimSynMtchOpt ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi vimSynType ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi vimHiLink ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi vimHiGroup ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi vimGroup ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi! link diffAdded Statement
hi! link diffLine Identifier
hi gitcommitComment ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
hi! link gitcommitUntracked gitcommitComment
hi! link gitcommitDiscarded gitcommitComment
hi! link gitcommitSelected gitcommitComment
hi gitcommitUnmerged ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi gitcommitOnBranch ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi gitcommitBranch ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi! link gitcommitNoBranch gitcommitBranch
hi gitcommitdiscardedtype ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi gitcommitselectedtype ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi gitcommitHeader ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi gitcommitUntrackedFile ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi gitcommitDiscardedFile ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi gitcommitSelectedFile ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi gitcommitUnmergedFile ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi gitcommitFile ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
hi! link gitcommitSelectedArrow gitcommitSelectedFile
hi! link gitcommitUnmergedArrow gitcommitUnmergedFile
hi htmlTag ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi htmlEndTag ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi htmlTagN ctermfg=10 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi htmlTagName ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi htmlSpecialTagName ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
hi htmlArg ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi javaScript ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link jsFuncCall Function
hi perlHereDoc ctermfg=10 ctermbg=15 guifg=#586e75 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi perlVarPlain ctermfg=3 ctermbg=15 guifg=#b58900 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi perlStatementFileDesc ctermfg=6 ctermbg=15 guifg=#2aa198 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi texstatement ctermfg=6 ctermbg=15 guifg=#2aa198 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi texmathzonex ctermfg=3 ctermbg=15 guifg=#b58900 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi texmathmatcher ctermfg=3 ctermbg=15 guifg=#b58900 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi texreflabel ctermfg=3 ctermbg=15 guifg=#b58900 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi rubyDefine ctermfg=10 ctermbg=15 guifg=#586e75 guibg=#fdf6e3 guisp=NONE cterm=NONE,bold gui=NONE,bold
hi! link rubySymbol Type
hi rubyBoolean ctermfg=5 ctermbg=15 guifg=#d33682 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
let hs_highlight_boolean=1
let hs_highlight_delimiters=1
hi cPreCondit ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi VarId ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi ConId ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsImport ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsString ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsStructure ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hs_hlFunctionName ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsStatement ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsImportLabel ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hs_OpFunctionName ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hs_DeclareFunction ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsVarSym ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsType ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsTypedef ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsModuleName ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link hsImportParams Delimiter
hi! link hsDelimTypeExport Delimiter
hi! link hsModuleStartLabel hsStructure
hi! link hsModuleWhereLabel hsModuleStartLabel
hi hsNiceOperator ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi hsniceoperator ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocTitleBlock ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocTitleBlockTitle ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocTitleComment ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocComment ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
hi pandocVerbatimBlock ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link pandocVerbatimBlockDeep pandocVerbatimBlock
hi! link pandocCodeBlock pandocVerbatimBlock
hi! link pandocCodeBlockDelim pandocVerbatimBlock
hi pandocBlockQuote ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocBlockQuoteLeader1 ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocBlockQuoteLeader2 ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocBlockQuoteLeader3 ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocBlockQuoteLeader4 ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocBlockQuoteLeader5 ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocBlockQuoteLeader6 ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocListMarker ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocListReference ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocDefinitionBlock ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocDefinitionTerm ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,standout gui=NONE,standout
hi pandocDefinitionIndctr ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocEmphasisDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
hi pandocEmphasisNestedDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisNestedDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisEmphasisDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrikeoutDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi pandocVerbatimInlineDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocSuperscriptDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocSubscriptDefinition ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocTableStructure ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi! link pandocTableStructureTop pandocTableStructre
hi! link pandocTableStructureEnd pandocTableStructre
hi pandocTableZebraLight ctermfg=4 ctermbg=15 guifg=#268bd2 guibg=#fdf6e3 guisp=NONE cterm=NONE gui=NONE
hi pandocTableZebraDark ctermfg=4 ctermbg=7 guifg=#268bd2 guibg=#eee8d5 guisp=NONE cterm=NONE gui=NONE
hi pandocEmphasisTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
hi pandocEmphasisNestedTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisNestedTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisEmphasisTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrikeoutTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi pandocVerbatimInlineTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocSuperscriptTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocSubscriptTable ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocHeadingMarker ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocEmphasisHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocEmphasisNestedHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisNestedHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisEmphasisHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrikeoutHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi pandocVerbatimInlineHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocSuperscriptHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocSubscriptHeading ctermfg=9 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocLinkDelim ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocLinkLabel ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocLinkText ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocLinkURL ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocLinkTitle ctermfg=12 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocLinkTitleDelim ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=#839496 cterm=NONE gui=NONE
hi pandocLinkDefinition ctermfg=6 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=#839496 cterm=NONE gui=NONE
hi pandocLinkDefinitionID ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocImageCaption ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocFootnoteLink ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocFootnoteDefLink ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocFootnoteInline ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocFootnote ctermfg=2 ctermbg=NONE guifg=#859900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocCitationDelim ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocCitation ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocCitationID ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocCitationRef ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocStyleDelim ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocEmphasis ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
hi pandocEmphasisNested ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasis ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisNested ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrongEmphasisEmphasis ctermfg=11 ctermbg=NONE guifg=#657b83 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocStrikeout ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi pandocVerbatimInline ctermfg=3 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocSuperscript ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocSubscript ctermfg=13 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocRule ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocRuleLine ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocEscapePair ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi pandocCitationRef ctermfg=5 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocNonBreakingSpace ctermfg=1 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi! link pandocEscapedCharacter pandocEscapePair
hi! link pandocLineBreak pandocEscapePair
hi pandocMetadataDelim ctermfg=14 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocMetadata ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocMetadataKey ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi pandocMetadata ctermfg=4 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi! link pandocMetadataTitle pandocMetadata
if has('nvim')
  hi! link TermCursor Cursor
  hi TermCursorNC ctermfg=15 ctermbg=14 guifg=#fdf6e3 guibg=#93a1a1 guisp=NONE cterm=NONE gui=NONE
  let g:terminal_color_8='#fdf6e3'
  let g:terminal_color_0='#eee8d5'
  let g:terminal_color_10='#93a1a1'
  let g:terminal_color_11='#839496'
  let g:terminal_color_12='#657b83'
  let g:terminal_color_14='#586e75'
  let g:terminal_color_7='#073642'
  let g:terminal_color_15='#002b36'
  let g:terminal_color_3='#b58900'
  let g:terminal_color_9='#cb4b16'
  let g:terminal_color_1='#dc322f'
  let g:terminal_color_5='#d33682'
  let g:terminal_color_13='#6c71c4'
  let g:terminal_color_4='#268bd2'
  let g:terminal_color_6='#2aa198'
  let g:terminal_color_2='#859900'
endif
finish
