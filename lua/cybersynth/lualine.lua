local M = {}

function M.get_theme(variant, transparent)
  variant = variant or "dark"
  transparent = transparent or false
  local p = require("cybersynth.palette")
  local palette = variant == "light" and p.light or p.dark

  local bg_alt = transparent and "NONE" or palette.bg_alt
  local bg_highlight = transparent and "NONE" or palette.bg_highlight

  local theme = {
    normal = {
      a = { fg = palette.bg_base, bg = palette.magenta, gui = "bold" },
      b = { fg = palette.fg, bg = bg_highlight },
      c = { fg = palette.fg_dim, bg = bg_alt },
    },
    insert = {
      a = { fg = palette.bg_base, bg = palette.mint, gui = "bold" },
      b = { fg = palette.fg, bg = bg_highlight },
      c = { fg = palette.fg_dim, bg = bg_alt },
    },
    visual = {
      a = { fg = palette.bg_base, bg = palette.yellow, gui = "bold" },
      b = { fg = palette.fg, bg = bg_highlight },
      c = { fg = palette.fg_dim, bg = bg_alt },
    },
    replace = {
      a = { fg = palette.bg_base, bg = palette.coral, gui = "bold" },
      b = { fg = palette.fg, bg = bg_highlight },
      c = { fg = palette.fg_dim, bg = bg_alt },
    },
    command = {
      a = { fg = palette.bg_base, bg = palette.sky, gui = "bold" },
      b = { fg = palette.fg, bg = bg_highlight },
      c = { fg = palette.fg_dim, bg = bg_alt },
    },
    terminal = {
      a = { fg = palette.bg_base, bg = palette.cyan, gui = "bold" },
      b = { fg = palette.fg, bg = bg_highlight },
      c = { fg = palette.fg_dim, bg = bg_alt },
    },
    inactive = {
      a = { fg = palette.fg_subtle, bg = bg_alt },
      b = { fg = palette.fg_subtle, bg = bg_alt },
      c = { fg = palette.fg_subtle, bg = bg_alt },
    },
  }

  return theme
end

local function resolve()
  local config = require("cybersynth.config").get()
  local variant = config.variant
  if variant == "auto" then
    variant = vim.o.background == "light" and "light" or "dark"
  end
  if variant ~= "dark" and variant ~= "light" then
    variant = "dark"
  end
  return M.get_theme(variant, config.transparent)
end

return setmetatable(M, {
  __call = function()
    return resolve()
  end,
})
