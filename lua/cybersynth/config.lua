local M = {}

local default_config = {
  variant = "auto",
  transparent = false,
  italic = {
    comments = true,
    keywords = false,
    functions = false,
    variables = false,
    strings = false,
  },
  bold = {
    functions = false,
  },
  overrides = {},
}

local user_config = {}

function M.extend(opts)
  if opts == nil then
    return vim.deepcopy(default_config)
  end
  for k, _ in pairs(opts) do
    if default_config[k] == nil then
      vim.notify(
        string.format("cybersynth: unknown setup key '%s'. Valid keys: variant, transparent, italic, bold, overrides", k),
        vim.log.levels.WARN
      )
    end
  end
  user_config = vim.tbl_deep_extend("keep", opts, default_config)
  user_config = vim.tbl_deep_extend("force", default_config, user_config)
  return user_config
end

function M.get()
  local cfg = vim.tbl_deep_extend("keep", user_config, default_config)
  return vim.tbl_deep_extend("force", vim.deepcopy(default_config), cfg)
end

function M.reset()
  user_config = {}
end

return M
