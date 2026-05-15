local M = {}

function M.set(ns, name, opts)
  if ns == nil then ns = 0 end
  local clean = vim.deepcopy(opts)
  clean._min_version = nil
  if clean.update == true and vim.fn.has("nvim-0.12") ~= 1 then
    clean.update = nil
  end
  vim.api.nvim_set_hl(ns, name, clean)
end

function M.apply(groups)
  for name, opts in pairs(groups) do
    local min_ver = opts._min_version
    if min_ver and type(min_ver) == "string" then
      if vim.fn.has("nvim-" .. min_ver) ~= 1 then
        -- skip: version gate not met
      else
        M.apply_single(name, opts)
      end
    else
      M.apply_single(name, opts)
    end
  end
end

function M.apply_single(name, opts)
  if type(opts) == "string" then
    M.set(0, name, { link = opts })
  elseif opts.link then
    M.set(0, name, { link = opts.link })
  else
    local resolved = {}
    for k, v in pairs(opts) do
      if k ~= "_min_version" then
        resolved[k] = v
      end
    end
    M.set(0, name, resolved)
  end
end

function M.has(version)
  return vim.fn.has("nvim-" .. version) == 1
end

function M.blend(fg, bg, ratio)
  ratio = math.max(0, math.min(1, ratio))
  local function hex_to_rgb(h)
    h = h:gsub("#", "")
    return tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16)
  end
  local r1, g1, b1 = hex_to_rgb(fg)
  local r2, g2, b2 = hex_to_rgb(bg)
  local r = math.floor(r1 * ratio + r2 * (1 - ratio) + 0.5)
  local g = math.floor(g1 * ratio + g2 * (1 - ratio) + 0.5)
  local b = math.floor(b1 * ratio + b2 * (1 - ratio) + 0.5)
  return string.format("#%02x%02x%02x", r, g, b)
end

function M.darken(hex, pct)
  return M.blend("#000000", hex, 1 - pct / 100)
end

function M.lighten(hex, pct)
  return M.blend("#ffffff", hex, 1 - pct / 100)
end

function M.get_colors()
  return require("cybersynth.theme").get_colors()
end

return M
