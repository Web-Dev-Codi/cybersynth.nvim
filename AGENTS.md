# AGENTS.md

## Architecture

Neovim colorscheme plugin. Plugin-agnostic by design — styles core highlight groups so well-behaved plugins inherit colors automatically. No per-plugin integration tables.

- `colors/cybersynth.lua` — entrypoint when `:colorscheme cybersynth` runs; sets `vim.o.background`, clears highlights, enables `termguicolors`, calls `require("cybersynth").load()`
- `lua/cybersynth/init.lua` — public API: `setup()`, `load()`, `get_colors()`, `get_palette()`
- `lua/cybersynth/config.lua` — config storage; uses a double-pass `tbl_deep_extend` (`"keep"` then `"force"`) to ensure no default keys are skipped
- `lua/cybersynth/palette.lua` — single source of truth for all color hex values (dark and light)
- `lua/cybersynth/theme.lua` — builds the full theme table from a palette variant
- `lua/cybersynth/highlights/` — one file per category (editor, syntax, treesitter, lsp, diagnostic, terminal); each exposes `get(theme, config)` returning `{group_name = {...}}`
- `lua/cybersynth/util.lua` — `set()`, `apply()` with `_min_version` gates, color math helpers
- `lua/cybersynth/lualine.lua` — lualine theme generator (callable via `__call` metatable)
- `lua/lualine/themes/cybersynth.lua` — thin bridge auto-discovered by lualine

## Setup order matters

```lua
require("cybersynth").setup({})  -- must come FIRST
vim.cmd.colorscheme("cybersynth") -- applies everything
```

Calling `setup()` after `colorscheme` does nothing (it only stores config; `load()` reads it).

## Key conventions

- **No tests, no lint, no build.** This is a pure Lua Neovim plugin verified visually.
- **Indent:** 4 spaces. **No trailing whitespace trimming** and **no final newline** (per `.editorconfig`).
- **Highlight version gating:** use `_min_version = "0.11"` on highlight entries that require newer Neovim.
- **Unknown config keys:** `setup()` warns on unrecognized keys via `vim.notify`.
- **Palette changes:** edit `lua/cybersynth/palette.lua` — it's the single source of color values. Avoid editing individual highlight files unless changing the mapping logic.
- **Adding a new highlight group:** add it to the appropriate category file in `lua/cybersynth/highlights/`.
