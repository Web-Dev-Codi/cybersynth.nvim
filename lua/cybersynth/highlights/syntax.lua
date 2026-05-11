local M = {}

function M.get(theme, config)
  local c = theme
  local it = config.italic
  local bd = config.bold

  local function opt(tbl)
    local result = {}
    for k, v in pairs(tbl) do
      result[k] = v
    end
    return result
  end

  local groups = {
    Comment = { fg = c.syntax.comment, italic = it.comments },
    Constant = { fg = c.syntax.constant },
    String = { fg = c.syntax.string, italic = it.strings },
    Character = { fg = c.syntax.character },
    Number = { fg = c.syntax.number },
    Float = { fg = c.syntax.number },
    Boolean = { fg = c.syntax.boolean },
    Identifier = { fg = c.syntax.variable },
    Function = { fg = c.syntax["function"], bold = bd.functions, italic = it.functions },
    Statement = { fg = c.syntax.keyword },
    Conditional = { fg = c.syntax.keyword_conditional, italic = it.keywords },
    Repeat = { fg = c.syntax.keyword_repeat },
    Label = { fg = c.syntax.label },
    Operator = { fg = c.syntax.operator },
    Keyword = { fg = c.syntax.keyword, italic = it.keywords },
    Exception = { fg = c.syntax.keyword_exception },
    PreProc = { fg = c.syntax.preproc },
    Include = { fg = c.syntax.include },
    Define = { fg = c.syntax.preproc },
    Macro = { fg = c.syntax.macro },
    PreCondit = { fg = c.syntax.preproc },
    Type = { fg = c.syntax.type },
    StorageClass = { fg = c.syntax.storage_class },
    Structure = { fg = c.syntax.structure },
    Typedef = { fg = c.syntax.type },
    Special = { fg = c.syntax.special },
    SpecialChar = { fg = c.syntax.special },
    Tag = { fg = c.syntax.tag },
    Delimiter = { fg = c.syntax.delimiter },
    SpecialComment = { fg = c.syntax.comment_doc, italic = it.comments },
    Debug = { fg = c.syntax.debug },
    Error = { fg = c.syntax.error },
    Todo = { fg = c.syntax.keyword, bg = c.bg.highlight, bold = true },
    Underlined = { fg = c.syntax.underline, underline = true },
    Ignore = { fg = c.fg.subtle },
  }

  return groups
end

return M
