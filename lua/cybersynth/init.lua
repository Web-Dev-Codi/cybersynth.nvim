local M = {}

function M.setup(opts)
  local config = require("cybersynth.config")
  config.extend(opts)
end

function M.load()
  local config = require("cybersynth.config").get()

  local variant = config.variant
  if variant == "auto" then
    variant = vim.o.background == "light" and "light" or "dark"
  end
  if variant ~= "dark" and variant ~= "light" then
    variant = "dark"
  end

  local theme = require("cybersynth.theme").get(variant)

  require("cybersynth.highlights.init").load(theme, config)
end

function M.get_colors()
  return require("cybersynth.theme").get_colors()
end

function M.get_palette()
  local config = require("cybersynth.config").get()
  local variant = config.variant == "auto" and vim.o.background or config.variant
  local palette = require("cybersynth.palette")
  return variant == "light" and palette.light or palette.dark
end

return M
