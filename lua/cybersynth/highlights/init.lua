local M = {}

local function resolve_italic(config, group_info)
  if type(group_info) ~= "table" then
    return group_info
  end
  local result = vim.deepcopy(group_info)
  if config.italic.comments and result.link == nil then
    return result
  end
  return result
end

function M.load(theme, config)
  local editor = require("cybersynth.highlights.editor").get(theme, config)
  local syntax = require("cybersynth.highlights.syntax").get(theme, config)
  local treesitter = require("cybersynth.highlights.treesitter").get(theme, config)
  local lsp = require("cybersynth.highlights.lsp").get(theme, config)
  local diagnostic = require("cybersynth.highlights.diagnostic").get(theme, config)
  local terminal = require("cybersynth.highlights.terminal")

  local util = require("cybersynth.util")

  util.apply(editor, theme, config)
  util.apply(syntax, theme, config)
  util.apply(treesitter, theme, config)
  util.apply(lsp, theme, config)
  util.apply(diagnostic, theme, config)

  terminal.apply(theme, config)

  if config.transparent then
    local transparent_groups = {
      "Normal", "NormalNC", "NormalFloat",
      "SignColumn", "FoldColumn",
      "StatusLine", "StatusLineNC",
      "WinBar", "WinBarNC",
      "TabLine", "TabLineFill", "TabLineSel",
    }
    for _, name in ipairs(transparent_groups) do
      local ok, existing = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
      if ok and existing then
        local bg_val = existing.bg and "NONE" or nil
        util.set(0, name, { bg = "NONE" })
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
