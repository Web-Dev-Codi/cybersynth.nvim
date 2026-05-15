local M = {}

function M.apply(theme, config)
  vim.g.terminal_color_0 = theme.ansi.black
  vim.g.terminal_color_1 = theme.ansi.red
  vim.g.terminal_color_2 = theme.ansi.green
  vim.g.terminal_color_3 = theme.ansi.yellow
  vim.g.terminal_color_4 = theme.ansi.blue
  vim.g.terminal_color_5 = theme.ansi.magenta
  vim.g.terminal_color_6 = theme.ansi.cyan
  vim.g.terminal_color_7 = theme.ansi.white
  vim.g.terminal_color_8 = theme.ansi.bright_black
  vim.g.terminal_color_9 = theme.ansi.bright_red
  vim.g.terminal_color_10 = theme.ansi.bright_green
  vim.g.terminal_color_11 = theme.ansi.bright_yellow
  vim.g.terminal_color_12 = theme.ansi.bright_blue
  vim.g.terminal_color_13 = theme.ansi.bright_magenta
  vim.g.terminal_color_14 = theme.ansi.bright_cyan
  vim.g.terminal_color_15 = theme.ansi.bright_white
end

return M
