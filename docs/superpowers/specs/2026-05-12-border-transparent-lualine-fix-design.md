# Design: Border colors, transparent backgrounds, lualine fix

Date: 2026-05-12
Status: approved

## Summary

Fixes for border coloring (ensure orange everywhere), lualine transparency bug, and maximal transparent background coverage.

## 1. Border Colors

**Goal:** Every border highlight group Neovim can paint should use orange (`palette.amber` / `#ffb86c`).

### Changes to `lua/cybersynth/highlights/editor.lua`

| Group | Current | New |
|---|---|---|
| `FloatBorder` | amber fg + float bg | unchanged |
| `WinSeparator` / `VertSplit` | link to `FloatBorder` | unchanged |
| `MsgSeparator` | `fg = fg_invisible` | `fg = amber, bg = bg.base` |
| `NormalFloatBorder` | missing | `fg = amber, bg = float.bg`, gated `_min_version = "0.10"` |

Plugin border groups (fzf-lua, telescope, etc.) inherit automatically via links — no plugin-specific definitions needed.

### Palette unchanged
`palette.amber = "#ffb86c"` (dark) and `"#a64a00"` (light) remain the source of truth.

## 2. FloatTitle

Already set to cyan bg + dark fg (`c.ui.title.fg = c.bg.base`, `c.ui.title.bg = palette.cyan`). No semantic change needed.

## 3. Lualine Transparent Bug

**Root cause:** `lua/lualine/themes/cybersynth.lua` calls `get_theme()` with zero arguments, so `transparent` always defaults to `false`.

**Fix:** One-line change — invoke `resolve()` instead:

```
- return require("cybersynth.lualine").get_theme()
+ return require("cybersynth.lualine")()
```

The `__call` metatable on `M` invokes `resolve()` which reads `config.transparent` via `config.get()`.

## 4. Transparent Background Expansion

### Current state
`lua/cybersynth/highlights/init.lua` defines 16 groups in the transparent pass.

### New state
Expand to ~53 groups covering all background-bearing highlight groups.

**Full group list:**

```
Normal, NormalNC, NormalFloat,
FloatBorder, FloatTitle, FloatFooter,
WinSeparator, VertSplit,
SignColumn, FoldColumn,
StatusLine, StatusLineNC, StatusLineTerm, StatusLineTermNC,
WinBar, WinBarNC,
TabLine, TabLineFill, TabLineSel,
MsgArea, MsgSeparator,
CmdLine, CmdLinePopup,
NormalPopUpMenu, MessageWindow,
LineNr, LineNrAbove, LineNrBelow,
CursorLineNr, CursorLineSign, CursorLineFold,
CursorLine, CursorColumn, ColorColumn,
Folded, FoldColumn,
EndOfBuffer, Whitespace, NonText,
Pmenu, PmenuSel, PmenuSbar, PmenuThumb,
PmenuKind, PmenuKindSel, PmenuExtra, PmenuExtraSel,
Question, QuickFixLine,
ToolbarLine,
Visual, VisualNOS,
```

### Implementation
The transparent pass in `init.lua` iterates each group, fetches the current highlight definition via `vim.api.nvim_get_hl`, sets `bg = "NONE"`, and reapplies. Version-gated groups (`CmdLinePopup` at 0.11, `NormalPopUpMenu` at 0.10, `MessageWindow` at 0.12, `CursorLineSign`/`CursorLineFold` at 0.10) are naturally skipped if `vim.api.nvim_get_hl` fails for them on older Neovim versions.

## 5. Files Changed

| File | Change |
|---|---|
| `lua/cybersynth/highlights/editor.lua` | Add `MsgSeparator` bg, add `NormalFloatBorder` |
| `lua/cybersynth/highlights/init.lua` | Expand transparent groups list |
| `lua/lualine/themes/cybersynth.lua` | Change `get_theme()` to `()` |

## 6. Non-Goals

- No plugin-specific highlight groups added (maintains plugin-agnostic architecture)
- No palette values changed
- No new config options
- `FloatTitle` color unchanged (already correct)
