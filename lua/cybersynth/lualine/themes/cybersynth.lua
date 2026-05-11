local M = {}

function M.get_theme(variant)
  variant = variant or "dark"
  local p = require("cybersynth.palette")
  local palette = variant == "light" and p.light or p.dark

  local theme = {
    normal = {
      a = { fg = palette.bg_base, bg = palette.magenta, gui = "bold" },
      b = { fg = palette.fg, bg = palette.bg_highlight },
      c = { fg = palette.fg_dim, bg = palette.bg_alt },
    },
    insert = {
      a = { fg = palette.bg_base, bg = palette.mint, gui = "bold" },
      b = { fg = palette.fg, bg = palette.bg_highlight },
      c = { fg = palette.fg_dim, bg = palette.bg_alt },
    },
    visual = {
      a = { fg = palette.bg_base, bg = palette.yellow, gui = "bold" },
      b = { fg = palette.fg, bg = palette.bg_highlight },
      c = { fg = palette.fg_dim, bg = palette.bg_alt },
    },
    replace = {
      a = { fg = palette.bg_base, bg = palette.coral, gui = "bold" },
      b = { fg = palette.fg, bg = palette.bg_highlight },
      c = { fg = palette.fg_dim, bg = palette.bg_alt },
    },
    command = {
      a = { fg = palette.bg_base, bg = palette.sky, gui = "bold" },
      b = { fg = palette.fg, bg = palette.bg_highlight },
      c = { fg = palette.fg_dim, bg = palette.bg_alt },
    },
    inactive = {
      a = { fg = palette.fg_subtle, bg = palette.bg_alt },
      b = { fg = palette.fg_subtle, bg = palette.bg_alt },
      c = { fg = palette.fg_subtle, bg = palette.bg_alt },
    },
  }

  return theme
end

return M
