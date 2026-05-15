local config = require("cybersynth.config").get()
if config.variant == "auto" then
  if vim.o.background ~= "dark" and vim.o.background ~= "light" then
    vim.o.background = "dark"
  end
elseif config.variant == "dark" or config.variant == "light" then
  vim.o.background = config.variant
end

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "cybersynth"
require("cybersynth").load()
