local M = {}

local loaded = false

function M.setup(opts)
  local config = require("cybersynth.config")
  config.extend(opts)
end

function M.load()
  local config_module = require("cybersynth.config")
  local config = config_module.get()

  if config.variant == "auto" then
    if vim.o.background == "light" then
      vim.o.background = "light"
    else
      vim.o.background = "dark"
    end
  else
    vim.o.background = config.variant
  end

  local theme_module = require("cybersynth.theme")
  local variant = config.variant == "auto" and vim.o.background or config.variant
  if variant ~= "dark" and variant ~= "light" then
    variant = "dark"
  end
  local theme = theme_module.get(variant)

  require("cybersynth.highlights.init").load(theme, config)

  loaded = true
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
