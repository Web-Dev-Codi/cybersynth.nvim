local M = {}

function M.get(variant)
  local p = require("cybersynth.palette")
  local palette = variant == "light" and p.light or p.dark

  local c = {}

  c.bg = {}
  c.bg.deep = palette.bg_deep
  c.bg.base = palette.bg_base
  c.bg.alt = palette.bg_alt
  c.bg.float = palette.bg_float
  c.bg.highlight = palette.bg_highlight
  c.bg.border = palette.border
  c.bg.selection = palette.selection
  c.bg.search_bg = palette.search_bg
  c.bg.diff_add = palette.diff_add
  c.bg.diff_change = palette.diff_change
  c.bg.diff_delete = palette.diff_delete
  c.bg.diff_text = palette.diff_text

  c.fg = {}
  c.fg.base = palette.fg
  c.fg.dim = palette.fg_dim
  c.fg.subtle = palette.fg_subtle
  c.fg.invisible = palette.fg_invisible

  c.ansi = palette.term

  c.syntax = {}
  c.syntax.comment = palette.fg_subtle
  c.syntax.comment_doc = palette.lavender
  c.syntax.string = palette.mint
  c.syntax.string_regex = palette.coral
  c.syntax.string_escape = palette.coral
  c.syntax.character = palette.mint
  c.syntax.number = palette.coral
  c.syntax.boolean = palette.coral
  c.syntax.variable = palette.magenta
  c.syntax.variable_builtin = palette.pink
  c.syntax.parameter = palette.sky
  c.syntax.member = palette.magenta
  c.syntax["function"] = palette.cyan
  c.syntax.function_builtin = palette.cyan
  c.syntax.function_call = palette.sky
  c.syntax.method = palette.cyan
  c.syntax.constructor = palette.yellow
  c.syntax.keyword = palette.yellow
  c.syntax.keyword_return = palette.yellow
  c.syntax.keyword_import = palette.yellow
  c.syntax.keyword_conditional = palette.yellow
  c.syntax.keyword_repeat = palette.yellow
  c.syntax.keyword_exception = palette.yellow
  c.syntax.keyword_coroutine = palette.yellow
  c.syntax.operator = palette.yellow
  c.syntax.type = palette.violet
  c.syntax.type_builtin = palette.violet
  c.syntax.type_qualifier = palette.yellow
  c.syntax.storage_class = palette.yellow
  c.syntax.structure = palette.violet
  c.syntax.include = palette.yellow
  c.syntax.preproc = palette.yellow
  c.syntax.label = palette.magenta
  c.syntax.tag = palette.mint
  c.syntax.tag_attribute = palette.magenta
  c.syntax.tag_delimiter = palette.fg_dim
  c.syntax.delimiter = palette.fg_dim
  c.syntax.punctuation = palette.fg_dim
  c.syntax.special = palette.magenta
  c.syntax.debug = palette.yellow
  c.syntax.error = palette.red
  c.syntax.todo = palette.yellow
  c.syntax.constant = palette.coral
  c.syntax.macro = palette.coral
  c.syntax.module = palette.violet
  c.syntax.attribute = palette.cyan
  c.syntax.property = palette.magenta
  c.syntax.underline = palette.sky

  c.ui = {}
  c.ui.normal = {}
  c.ui.normal.fg = c.fg.base
  c.ui.normal.bg = c.bg.base
  c.ui.nc = {}
  c.ui.nc.fg = c.fg.base
  c.ui.nc.bg = c.bg.base
  c.ui.float = {}
  c.ui.float.fg = c.fg.base
  c.ui.float.bg = c.bg.float
  c.ui.float_border = {}
  c.ui.float_border.fg = palette.border
  c.ui.float_border.bg = c.bg.float
  c.ui.title = {}
  c.ui.title.fg = palette.magenta
  c.ui.line_nr = {}
  c.ui.line_nr.fg = c.fg.invisible
  c.ui.line_nr.bg = c.bg.base
  c.ui.cursor_line_nr = {}
  c.ui.cursor_line_nr.fg = c.fg.dim
  c.ui.cursor_line = {}
  c.ui.cursor_line.bg = palette.selection
  c.ui.cursor_column = {}
  c.ui.cursor_column.bg = palette.selection
  c.ui.selection = {}
  c.ui.selection.bg = c.bg.highlight
  c.ui.search = {}
  c.ui.search.fg = c.fg.base
  c.ui.search.bg = c.bg.search_bg
  c.ui.inc_search = {}
  c.ui.inc_search.fg = c.fg.base
  c.ui.inc_search.bg = palette.magenta
  c.ui.substitute = {}
  c.ui.substitute.fg = c.fg.base
  c.ui.substitute.bg = palette.coral
  c.ui.match_paren = {}
  c.ui.match_paren.fg = palette.cyan
  c.ui.match_paren.bg = c.bg.highlight
  c.ui.sign_column = {}
  c.ui.sign_column.bg = c.bg.base
  c.ui.fold_column = {}
  c.ui.fold_column.bg = c.bg.base
  c.ui.folded = {}
  c.ui.folded.fg = c.fg.subtle
  c.ui.folded.bg = c.bg.alt
  c.ui.statusline = {}
  c.ui.statusline.fg = c.fg.dim
  c.ui.statusline.bg = c.bg.alt
  c.ui.statusline_nc = {}
  c.ui.statusline_nc.fg = c.fg.subtle
  c.ui.statusline_nc.bg = c.bg.alt
  c.ui.tabline = {}
  c.ui.tabline.bg = c.bg.alt
  c.ui.tabline_sel = {}
  c.ui.tabline_sel.fg = c.fg.base
  c.ui.tabline_sel.bg = c.bg.base
  c.ui.pmenu = {}
  c.ui.pmenu.fg = c.fg.dim
  c.ui.pmenu.bg = c.bg.float
  c.ui.pmenu_sel = {}
  c.ui.pmenu_sel.fg = c.fg.base
  c.ui.pmenu_sel.bg = c.bg.highlight
  c.ui.wild_menu = {}
  c.ui.wild_menu.fg = c.fg.base
  c.ui.wild_menu.bg = c.bg.highlight
  c.ui.visual = {}
  c.ui.visual.bg = c.bg.highlight
  c.ui.non_text = {}
  c.ui.non_text.fg = c.fg.invisible
  c.ui.directory = {}
  c.ui.directory.fg = palette.cyan
  c.ui.special_key = {}
  c.ui.special_key.fg = c.fg.invisible
  c.ui.conceal = {}
  c.ui.conceal.fg = c.fg.subtle

  c.diag = {}
  c.diag.error = palette.error
  c.diag.warn = palette.warn
  c.diag.info = palette.info
  c.diag.hint = palette.hint
  c.diag.ok = palette.ok

  c.diff = {}
  c.diff.add = {}
  c.diff.add.fg = palette.mint
  c.diff.add.bg = c.bg.diff_add
  c.diff.change = {}
  c.diff.change.fg = palette.sky
  c.diff.change.bg = c.bg.diff_change
  c.diff.delete = {}
  c.diff.delete.fg = palette.red
  c.diff.delete.bg = c.bg.diff_delete
  c.diff.text = {}
  c.diff.text.fg = c.fg.base
  c.diff.text.bg = c.bg.diff_text

  c.git = {}
  c.git.add = palette.mint
  c.git.change = palette.sky
  c.git.delete = palette.red

  c.spell = {}
  c.spell.bad = palette.red
  c.spell.cap = palette.warn
  c.spell.rare = palette.violet
  c.spell["local"] = palette.mint

  return c
end

local function get_variant()
  local config = require("cybersynth.config").get()
  if config.variant == "auto" then
    if vim.o.background == "light" then
      return "light"
    end
    return "dark"
  end
  return config.variant
end

M.get_colors = function()
  return M.get(get_variant())
end

return M
