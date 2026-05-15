local M = {}

function M.load(theme, config)
    local editor = require("cybersynth.highlights.editor").get(theme, config)
    local syntax = require("cybersynth.highlights.syntax").get(theme, config)
    local treesitter = require("cybersynth.highlights.treesitter").get(theme, config)
    local lsp = require("cybersynth.highlights.lsp").get(theme, config)
    local diagnostic = require("cybersynth.highlights.diagnostic").get(theme, config)
    local terminal = require("cybersynth.highlights.terminal")

    local util = require("cybersynth.util")

    util.apply(editor)
    util.apply(syntax)
    util.apply(treesitter)
    util.apply(lsp)
    util.apply(diagnostic)

    terminal.apply(theme, config)

    if config.transparent then
        local transparent_groups = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "FloatFooter",
            "WinSeparator",
            "VertSplit",
            "SignColumn",
            "FoldColumn",
            "StatusLine",
            "StatusLineNC",
            "StatusLineTerm",
            "StatusLineTermNC",
            "WinBar",
            "WinBarNC",
            "TabLine",
            "TabLineFill",
            "TabLineSel",
            "MsgArea",
            "MsgSeparator",
            "CmdLine",
            "CmdlinePopupMenu",
            "LineNr",
            "LineNrAbove",
            "LineNrBelow",
            "CursorLineNr",
            "CursorLineSign",
            "CursorLineFold",
            "CursorLine",
            "CursorColumn",
            "ColorColumn",
            "Folded",
            "EndOfBuffer",
            "Whitespace",
            "NonText",
            "Pmenu",
            "PmenuSel",
            "PmenuSbar",
            "PmenuThumb",
            "PmenuKind",
            "PmenuKindSel",
            "PmenuExtra",
            "PmenuExtraSel",
            "Question",
            "QuickFixLine",
            "ToolbarLine",
        }
        for _, name in ipairs(transparent_groups) do
            local ok, existing = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
            if ok and existing then
                existing.bg = "NONE"
                util.set(0, name, existing)
            end
        end
    end

    -- file tree links: plugins set these with default=true, so our links win
    local tree_links = {
        NeoTreeNormal = "Normal",
        NeoTreeNormalNC = "NormalNC",
        NeoTreeWinSeparator = "WinSeparator",
        NeoTreeVertSplit = "VertSplit",
        NvimTreeNormal = "Normal",
        NvimTreeNormalNC = "NormalNC",
        NvimTreeWinSeparator = "WinSeparator",
    }
    for name, link in pairs(tree_links) do
        util.set(0, name, { link = link })
    end

    if config.overrides and next(config.overrides) then
        for name, opts in pairs(config.overrides) do
            util.set(0, name, opts)
        end
    end
end

return M
