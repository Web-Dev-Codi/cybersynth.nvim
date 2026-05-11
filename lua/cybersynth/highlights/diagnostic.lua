local M = {}

function M.get(theme, config)
  local c = theme

  local function severity_bg(severity)
    local diag_colors = {
      error = c.diag.error,
      warn = c.diag.warn,
      info = c.diag.info,
      hint = c.diag.hint,
      ok = c.diag.ok,
    }
    return diag_colors[severity]
  end

  local groups = {
    DiagnosticError = { fg = c.diag.error },
    DiagnosticWarn = { fg = c.diag.warn },
    DiagnosticInfo = { fg = c.diag.info },
    DiagnosticHint = { fg = c.diag.hint },
    DiagnosticOk = { fg = c.diag.ok },

    DiagnosticVirtualTextError = { fg = c.diag.error },
    DiagnosticVirtualTextWarn = { fg = c.diag.warn },
    DiagnosticVirtualTextInfo = { fg = c.diag.info },
    DiagnosticVirtualTextHint = { fg = c.diag.hint },
    DiagnosticVirtualTextOk = { fg = c.diag.ok },

    DiagnosticVirtualLinesError = { _min_version = "0.11", fg = c.diag.error },
    DiagnosticVirtualLinesWarn = { _min_version = "0.11", fg = c.diag.warn },
    DiagnosticVirtualLinesInfo = { _min_version = "0.11", fg = c.diag.info },
    DiagnosticVirtualLinesHint = { _min_version = "0.11", fg = c.diag.hint },
    DiagnosticVirtualLinesOk = { _min_version = "0.11", fg = c.diag.ok },

    DiagnosticUnderlineError = { sp = c.diag.error, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.diag.warn, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.diag.info, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.diag.hint, undercurl = true },
    DiagnosticUnderlineOk = { sp = c.diag.ok, undercurl = true },

    DiagnosticFloatingError = { fg = c.diag.error },
    DiagnosticFloatingWarn = { fg = c.diag.warn },
    DiagnosticFloatingInfo = { fg = c.diag.info },
    DiagnosticFloatingHint = { fg = c.diag.hint },
    DiagnosticFloatingOk = { fg = c.diag.ok },

    DiagnosticSignError = { fg = c.diag.error },
    DiagnosticSignWarn = { fg = c.diag.warn },
    DiagnosticSignInfo = { fg = c.diag.info },
    DiagnosticSignHint = { fg = c.diag.hint },
    DiagnosticSignOk = { fg = c.diag.ok },

    DiagnosticDeprecated = { strikethrough = true },
    DiagnosticUnnecessary = { fg = c.fg.subtle },
  }

  return groups
end

return M
