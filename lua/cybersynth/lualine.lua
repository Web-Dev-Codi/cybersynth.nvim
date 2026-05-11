local M = {}

M.theme = "cybersynth"

function M.get()
  local config = require("cybersynth.config").get()
  local variant = config.variant
  if variant == "auto" then
    variant = vim.o.background == "light" and "light" or "dark"
  end
  if variant ~= "dark" and variant ~= "light" then
    variant = "dark"
  end

  local theme_mod = require("cybersynth.lualine.themes.cybersynth")
  return theme_mod.get_theme(variant)
end

return setmetatable(M, {
  __call = function()
    return M.get()
  end,
})
