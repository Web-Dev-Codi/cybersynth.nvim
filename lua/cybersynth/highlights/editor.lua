local M = {}

function M.get(theme, config)
  local c = theme

  local groups = {

    Normal = { fg = c.ui.normal.fg, bg = c.ui.normal.bg },
    NormalNC = { fg = c.ui.nc.fg, bg = c.ui.nc.bg },
    NormalFloat = { fg = c.ui.float.fg, bg = c.ui.float.bg },

    FloatBorder = { fg = c.ui.float_border.fg, bg = c.ui.float_border.bg },
    FloatTitle = { fg = c.ui.title.fg, bg = c.ui.title.bg },
    FloatFooter = { _min_version = "0.11", fg = c.fg.subtle, bg = c.ui.float.bg },

    WinSeparator = { fg = c.ui.float_border.fg, bg = c.bg.base },
    VertSplit = { link = "WinSeparator" },

    WinBar = { _min_version = "0.10", fg = c.fg.dim, bg = c.bg.alt },
    WinBarNC = { _min_version = "0.10", fg = c.fg.subtle, bg = c.bg.alt },

    Cursor = { fg = c.bg.base, bg = c.fg.base },
    lCursor = { fg = c.bg.base, bg = c.fg.base },
    CursorIM = { fg = c.bg.base, bg = c.fg.base },

    TermCursor = { fg = c.bg.base, bg = c.fg.base },
    TermCursorNC = { fg = c.fg.dim, bg = c.bg.alt },

    CursorLine = { bg = c.ui.cursor_line.bg },
    CursorColumn = { bg = c.ui.cursor_column.bg },
    CursorLineNr = { fg = c.ui.cursor_line_nr.fg, bold = true },
    CursorLineFold = { _min_version = "0.10", fg = c.fg.invisible, bg = c.ui.cursor_line.bg },
    CursorLineSign = { _min_version = "0.10", fg = c.fg.invisible, bg = c.ui.cursor_line.bg },

    LineNr = { fg = c.ui.line_nr.fg, bg = c.ui.line_nr.bg },
    LineNrAbove = { fg = c.fg.invisible },
    LineNrBelow = { fg = c.fg.invisible },

    SignColumn = { bg = c.ui.sign_column.bg },
    FoldColumn = { fg = c.fg.invisible, bg = c.ui.fold_column.bg },
    Folded = { fg = c.ui.folded.fg, bg = c.ui.folded.bg },
    ColorColumn = { bg = c.ui.cursor_line.bg },

    StatusLine = { fg = c.ui.statusline.fg, bg = c.ui.statusline.bg },
    StatusLineNC = { fg = c.ui.statusline_nc.fg, bg = c.ui.statusline_nc.bg },
    StatusLineTerm = { fg = c.ui.statusline.fg, bg = c.bg.alt },
    StatusLineTermNC = { fg = c.ui.statusline_nc.fg, bg = c.bg.alt },

    TabLine = { fg = c.fg.dim, bg = c.ui.tabline.bg },
    TabLineSel = { fg = c.ui.tabline_sel.fg, bg = c.ui.tabline_sel.bg },
    TabLineFill = { bg = c.ui.tabline.bg },

    WildMenu = { fg = c.ui.wild_menu.fg, bg = c.ui.wild_menu.bg },
    ToolbarLine = { bg = c.bg.alt },
    ToolbarButton = { fg = c.fg.base, bg = c.bg.highlight, bold = true },

    Pmenu = { fg = c.ui.pmenu.fg, bg = c.ui.pmenu.bg },
    PmenuSel = { fg = c.ui.pmenu_sel.fg, bg = c.ui.pmenu_sel.bg },
    PmenuSbar = { bg = c.bg.alt },
    PmenuThumb = { bg = c.fg.invisible },

    PmenuKind = { fg = c.syntax.type, bg = c.ui.pmenu.bg },
    PmenuKindSel = { fg = c.syntax.type, bg = c.ui.pmenu_sel.bg },
    PmenuExtra = { fg = c.fg.subtle, bg = c.ui.pmenu.bg },
    PmenuExtraSel = { fg = c.fg.dim, bg = c.ui.pmenu_sel.bg },

    PmenuMatch = { _min_version = "0.11", fg = c.syntax["function"], bg = c.ui.pmenu.bg },
    PmenuMatchSel = { _min_version = "0.11", fg = c.syntax["function"], bg = c.ui.pmenu_sel.bg, bold = true },
    ComplMatchIns = { _min_version = "0.11", fg = c.syntax.variable },

    Visual = { bg = c.ui.visual.bg },
    VisualNOS = { bg = c.ui.visual.bg },

    Search = { fg = c.ui.search.fg, bg = c.ui.search.bg },
    IncSearch = { fg = c.ui.inc_search.fg, bg = c.ui.inc_search.bg },
    CurSearch = { fg = c.ui.search.fg, bg = c.ui.search.bg },
    Substitute = { fg = c.ui.substitute.fg, bg = c.ui.substitute.bg },

    MatchParen = { fg = c.ui.match_paren.fg, bg = c.ui.match_paren.bg, bold = true },
    QuickFixLine = { bg = c.bg.highlight },

    ErrorMsg = { fg = c.diag.error, bold = true },
    WarningMsg = { fg = c.diag.warn, bold = true },
    MoreMsg = { fg = c.syntax.keyword, bold = true },
    Question = { fg = c.syntax["function"], bold = true },
    ModeMsg = { fg = c.fg.dim },
    MsgArea = { fg = c.fg.dim },
    MsgSeparator = { fg = c.fg.invisible },

    NonText = { fg = c.ui.non_text.fg },
    EndOfBuffer = { fg = c.bg.deep },
    Whitespace = { fg = c.fg.invisible },
    SpecialKey = { fg = c.ui.special_key.fg },
    Conceal = { fg = c.ui.conceal.fg },

    DiffAdd = { fg = c.diff.add.fg, bg = c.diff.add.bg },
    DiffChange = { fg = c.diff.change.fg, bg = c.diff.change.bg },
    DiffDelete = { fg = c.diff.delete.fg, bg = c.diff.delete.bg },
    DiffText = { fg = c.diff.text.fg, bg = c.diff.text.bg },
    DiffTextAdd = { _min_version = "0.12", fg = c.diff.add.fg, bg = c.diff.add.bg },

    Added = { _min_version = "0.10", fg = c.git.add },
    Changed = { _min_version = "0.10", fg = c.git.change },
    Removed = { _min_version = "0.10", fg = c.git.delete },

    SpellBad = { sp = c.spell.bad, undercurl = true },
    SpellCap = { sp = c.spell.cap, undercurl = true },
    SpellRare = { sp = c.spell.rare, undercurl = true },
    SpellLocal = { sp = c.spell["local"], undercurl = true },

    Directory = { fg = c.ui.directory.fg },
    Title = { fg = c.syntax.variable, bold = true },
    Underlined = { fg = c.syntax.underline, underline = true },

    RedrawDebugNormal = { fg = c.bg.base, bg = c.fg.base },
    RedrawDebugClear = { fg = c.bg.base, bg = c.diag.warn },
    RedrawDebugComposed = { fg = c.bg.base, bg = c.diag.info },
    RedrawDebugRecompose = { fg = c.bg.base, bg = c.diag.error },

    SnippetTabstop = { _min_version = "0.10", bg = c.bg.highlight },
  }

  return groups
end

return M
