# Border, Transparent Backgrounds, and Lualine Fix — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix border coloring (orange everywhere), lualine transparency bug (reads config), and maximize transparent background coverage (~50+ groups).

**Architecture:** Three targeted edits in two highlight files plus a one-line lualine bridge fix. `editor.lua` gets `MsgSeparator` color fix and missing `NormalFloatBorder` group. `init.lua` transparent pass expands from 16 to 51 groups. `lualine/themes/cybersynth.lua` invokes `resolve()` instead of bare `get_theme()`.

**Tech Stack:** Lua, Neovim highlight API

---

## File Map

| File | Responsibility | Action |
|---|---|---|
| `lua/cybersynth/highlights/editor.lua` | Core editor highlight groups | Modify: fix MsgSeparator, add NormalFloatBorder |
| `lua/cybersynth/highlights/init.lua` | Theme load orchestration + transparent pass | Modify: expand transparent_groups list |
| `lua/lualine/themes/cybersynth.lua` | Lualine theme bridge | Modify: change function call |

---

### Task 1: Fix MsgSeparator and add NormalFloatBorder

**Files:**
- Modify: `lua/cybersynth/highlights/editor.lua:88`
- Modify: `lua/cybersynth/highlights/editor.lua:14` (insert after FloatFooter)

- [ ] **Step 1: Add NormalFloatBorder after FloatFooter**

Insert after line 14 (`FloatFooter = { ... },`):

```lua
    NormalFloatBorder = { _min_version = "0.10", fg = c.ui.float_border.fg, bg = c.ui.float_border.bg },
```

- [ ] **Step 2: Fix MsgSeparator to use amber**

Change line 88 from:
```lua
    MsgSeparator = { fg = c.fg.invisible },
```
To:
```lua
    MsgSeparator = { fg = c.ui.float_border.fg, bg = c.bg.base },
```

- [ ] **Step 3: Commit**

```bash
git add lua/cybersynth/highlights/editor.lua
git commit -m "fix(editor): set MsgSeparator to amber, add NormalFloatBorder"
```

---

### Task 2: Expand transparent background groups

**Files:**
- Modify: `lua/cybersynth/highlights/init.lua:22-39`

- [ ] **Step 1: Replace transparent_groups with expanded list**

Replace lines 22-39:
```lua
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
            "WinBar",
            "WinBarNC",
            "TabLine",
            "TabLineFill",
            "TabLineSel",
        }
```

With:
```lua
        local transparent_groups = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "FloatTitle",
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
            "CmdLinePopup",
            "NormalPopUpMenu",
            "MessageWindow",
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
            "Visual",
            "VisualNOS",
        }
```

- [ ] **Step 2: Commit**

```bash
git add lua/cybersynth/highlights/init.lua
git commit -m "feat(transparent): expand transparent groups to 51 highlight groups"
```

---

### Task 3: Fix lualine bridge to read config

**Files:**
- Modify: `lua/lualine/themes/cybersynth.lua:1`

- [ ] **Step 1: Change function call**

Replace the entire file content from:
```lua
return require("cybersynth.lualine").get_theme()
```
To:
```lua
return require("cybersynth.lualine")()
```

- [ ] **Step 2: Commit**

```bash
git add lua/lualine/themes/cybersynth.lua
git commit -m "fix(lualine): read user config for transparent mode"
```

---
