local M = {}

function M.get(theme, config)
  local c = theme

  local groups = {

    LspReferenceText = { bg = c.bg.highlight },
    LspReferenceRead = { bg = c.bg.highlight },
    LspReferenceWrite = { bg = c.bg.highlight },
    LspReferenceTarget = { _min_version = "0.11", bg = c.bg.highlight, bold = true },

    LspSignatureActiveParameter = { fg = c.syntax["function"], bold = true },

    LspCodeLens = { fg = c.fg.subtle },
    LspCodeLensSeparator = { fg = c.fg.invisible },

    LspInlayHint = { fg = c.fg.subtle, bg = c.bg.alt },

    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.variable"] = { link = "@variable" },
    ["@lsp.type.property"] = { link = "@variable.member" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.method"] = { link = "@function.method" },
    ["@lsp.type.macro"] = { link = "@function.macro" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.event"] = { link = "@type" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.modifier"] = { link = "@keyword.modifier" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.regexp"] = { link = "@string.regexp" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.lifetime"] = { link = "@keyword.modifier" },
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    ["@lsp.type.generic"] = { link = "@type" },
    ["@lsp.type.label"] = { link = "@label" },

    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.mod.readonly"] = { link = "@constant" },
    ["@lsp.mod.static"] = { link = "@keyword.modifier" },
    ["@lsp.mod.abstract"] = { link = "@keyword.modifier" },
    ["@lsp.mod.async"] = { link = "@keyword.coroutine" },
    ["@lsp.mod.documentation"] = { link = "@comment.documentation" },
    ["@lsp.mod.defaultLibrary"] = { link = "@function.builtin" },

    ["@lsp.typemod.variable.readonly"] = { link = "@constant" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.variable.static"] = { link = "@constant" },
    ["@lsp.typemod.property.readonly"] = { link = "@constant" },
  }

  return groups
end

return M
