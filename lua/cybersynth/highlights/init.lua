local M = {}

function M.load(theme, config)
  local editor = require("cybersynth.highlights.editor").get(theme, config)
  local syntax = require("cybersynth.highlights.syntax").get(theme, config)
  local treesitter = require("cybersynth.highlights.treesitter").get(theme, config)
  local lsp = require("cybersynth.highlights.lsp").get(theme, config)
  local diagnostic = require("cybersynth.highlights.diagnostic").get(theme, config)
  local terminal = require("cybersynth.highlights.terminal")

  local util = require("cybersynth.util")

  util.apply(editor)
  util.apply(syntax)
  util.apply(treesitter)
  util.apply(lsp)
  util.apply(diagnostic)

  terminal.apply(theme, config)

  if config.transparent then
    local transparent_groups = {
      "Normal", "NormalNC", "NormalFloat",
      "FloatBorder", "FloatTitle", "FloatFooter",
      "WinSeparator", "VertSplit",
      "SignColumn", "FoldColumn",
      "StatusLine", "StatusLineNC",
      "WinBar", "WinBarNC",
      "TabLine", "TabLineFill", "TabLineSel",
    }
    for _, name in ipairs(transparent_groups) do
      local ok, existing = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
      if ok and existing then
        existing.bg = "NONE"
        util.set(0, name, existing)
      end
    end
  end

  if config.overrides and next(config.overrides) then
    for name, opts in pairs(config.overrides) do
      util.set(0, name, opts)
    end
  end
end

return M
