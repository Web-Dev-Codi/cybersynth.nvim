local M = {}

function M.get(theme, config)
  local c = theme
  local it = config.italic
  local bd = config.bold

  local groups = {

    ["@variable"] = { fg = c.syntax.variable, italic = it.variables },
    ["@variable.builtin"] = { fg = c.syntax.variable_builtin },
    ["@variable.parameter"] = { fg = c.syntax.parameter },
    ["@variable.parameter.builtin"] = { fg = c.syntax.parameter },
    ["@variable.member"] = { fg = c.syntax.member },

    ["@constant"] = { fg = c.syntax.constant },
    ["@constant.builtin"] = { fg = c.syntax.boolean },
    ["@constant.macro"] = { fg = c.syntax.macro },

    ["@module"] = { fg = c.syntax.module },
    ["@module.builtin"] = { fg = c.syntax.module },

    ["@label"] = { fg = c.syntax.label },

    ["@string"] = { fg = c.syntax.string, italic = it.strings },
    ["@string.documentation"] = { fg = c.syntax.comment_doc, italic = it.comments },
    ["@string.regexp"] = { fg = c.syntax.string_regex },
    ["@string.escape"] = { fg = c.syntax.string_escape },
    ["@string.special"] = { fg = c.syntax.special },
    ["@string.special.symbol"] = { fg = c.syntax.special },
    ["@string.special.url"] = { fg = c.syntax.underline, underline = true },
    ["@string.special.path"] = { fg = c.syntax.string },

    ["@character"] = { fg = c.syntax.character },
    ["@character.special"] = { fg = c.syntax.special },

    ["@boolean"] = { fg = c.syntax.boolean },
    ["@number"] = { fg = c.syntax.number },
    ["@number.float"] = { fg = c.syntax.number },

    ["@function"] = { fg = c.syntax["function"], bold = bd.functions, italic = it.functions },
    ["@function.builtin"] = { fg = c.syntax.function_builtin },
    ["@function.call"] = { fg = c.syntax.function_call },
    ["@function.macro"] = { fg = c.syntax["function"] },
    ["@function.method"] = { fg = c.syntax.method },
    ["@function.method.call"] = { fg = c.syntax.method },

    ["@constructor"] = { fg = c.syntax.constructor },

    ["@type"] = { fg = c.syntax.type },
    ["@type.builtin"] = { fg = c.syntax.type_builtin },
    ["@type.definition"] = { fg = c.syntax.type },
    ["@type.qualifier"] = { fg = c.syntax.type_qualifier },

    ["@attribute"] = { fg = c.syntax.attribute },
    ["@attribute.builtin"] = { fg = c.syntax.attribute },

    ["@property"] = { fg = c.syntax.property },

    ["@keyword"] = { fg = c.syntax.keyword, italic = it.keywords },
    ["@keyword.coroutine"] = { fg = c.syntax.keyword_coroutine },
    ["@keyword.function"] = { fg = c.syntax.keyword },
    ["@keyword.operator"] = { fg = c.syntax.operator },
    ["@keyword.import"] = { fg = c.syntax.keyword_import },
    ["@keyword.type"] = { fg = c.syntax.keyword },
    ["@keyword.modifier"] = { fg = c.syntax.storage_class },
    ["@keyword.repeat"] = { fg = c.syntax.keyword_repeat },
    ["@keyword.return"] = { fg = c.syntax.keyword_return },
    ["@keyword.debug"] = { fg = c.syntax.debug },
    ["@keyword.exception"] = { fg = c.syntax.keyword_exception },
    ["@keyword.conditional"] = { fg = c.syntax.keyword_conditional },
    ["@keyword.conditional.ternary"] = { fg = c.syntax.operator },
    ["@keyword.directive"] = { fg = c.syntax.preproc },
    ["@keyword.directive.define"] = { fg = c.syntax.preproc },

    ["@operator"] = { fg = c.syntax.operator },

    ["@punctuation"] = { fg = c.syntax.punctuation },
    ["@punctuation.delimiter"] = { fg = c.syntax.delimiter },
    ["@punctuation.bracket"] = { fg = c.syntax.punctuation },
    ["@punctuation.special"] = { fg = c.syntax.special },

    ["@comment"] = { fg = c.syntax.comment, italic = it.comments },
    ["@comment.documentation"] = { fg = c.syntax.comment_doc, italic = it.comments },
    ["@comment.error"] = { fg = c.diag.error, bold = true },
    ["@comment.warning"] = { fg = c.diag.warn, bold = true },
    ["@comment.todo"] = { fg = c.syntax.keyword, bold = true },
    ["@comment.note"] = { fg = c.syntax["function"], bold = true },

    ["@markup"] = { fg = c.fg.base },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = c.syntax.variable, bold = true },
    ["@markup.heading.1"] = { fg = c.syntax.variable, bold = true },
    ["@markup.heading.2"] = { fg = c.syntax["function"], bold = true },
    ["@markup.heading.3"] = { fg = c.syntax.keyword, bold = true },
    ["@markup.heading.4"] = { fg = c.syntax.type, bold = true },
    ["@markup.heading.5"] = { fg = c.syntax.constant, bold = true },
    ["@markup.heading.6"] = { fg = c.syntax.comment, bold = true },
    ["@markup.heading.marker"] = { fg = c.fg.subtle },
    ["@markup.quote"] = { fg = c.fg.subtle, italic = true },
    ["@markup.math"] = { fg = c.syntax.number },
    ["@markup.link"] = { fg = c.syntax["function"], underline = true },
    ["@markup.link.label"] = { fg = c.syntax.variable },
    ["@markup.link.url"] = { fg = c.syntax.underline, underline = true },
    ["@markup.raw"] = { fg = c.syntax.string, italic = it.strings },
    ["@markup.raw.block"] = { fg = c.syntax.string },
    ["@markup.list"] = { fg = c.syntax.variable },
    ["@markup.list.checked"] = { fg = c.git.add },
    ["@markup.list.unchecked"] = { fg = c.fg.subtle },

    ["@diff.plus"] = { fg = c.git.add },
    ["@diff.minus"] = { fg = c.git.delete },
    ["@diff.delta"] = { fg = c.git.change },

    ["@tag"] = { fg = c.syntax.tag },
    ["@tag.builtin"] = { fg = c.syntax.tag },
    ["@tag.attribute"] = { fg = c.syntax.tag_attribute },
    ["@tag.delimiter"] = { fg = c.syntax.tag_delimiter },

    ["@error"] = { fg = c.diag.error, undercurl = true, sp = c.diag.error },

    ["@text"] = { link = "@markup" },
    ["@text.literal"] = { link = "@markup.raw" },
    ["@text.reference"] = { link = "@markup.link" },
    ["@text.title"] = { link = "@markup.heading" },
    ["@text.uri"] = { link = "@markup.link.url" },
    ["@text.underline"] = { link = "@markup.underline" },
    ["@text.todo"] = { link = "@comment.todo" },
    ["@text.warning"] = { link = "@comment.warning" },
    ["@text.note"] = { link = "@comment.note" },
    ["@text.danger"] = { link = "@comment.error" },
    ["@parameter"] = { link = "@variable.parameter" },
    ["@field"] = { link = "@variable.member" },
    ["@namespace"] = { link = "@module" },
    ["@method"] = { link = "@function.method" },
    ["@method.call"] = { link = "@function.method.call" },
    ["@float"] = { link = "@number.float" },
    ["@symbol"] = { link = "@string.special.symbol" },
  }

  return groups
end

return M
