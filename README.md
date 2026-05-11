<div align="center">
  <h1>cybersynth.nvim</h1>
  <p><i>Outrun for Neovim. Plugin-agnostic neon, AAA-accessible, on both dark and light.</i></p>
</div>

<p align="center">
  <a href="https://github.com/Web-Dev-Codi/cybersynth.nvim/stargazers">
    <img src="https://img.shields.io/github/stars/Web-Dev-Codi/cybersynth.nvim?style=for-the-badge&logo=starship&color=ff7edb&logoColor=ff7edb&labelColor=241b2f"></a>
  <a href="https://github.com/Web-Dev-Codi/cybersynth.nvim/issues">
    <img src="https://img.shields.io/github/issues/Web-Dev-Codi/cybersynth.nvim?style=for-the-badge&logo=gitbook&color=36f9f6&logoColor=36f9f6&labelColor=241b2f"></a>
  <a href="LICENSE">
    <img src="https://img.shields.io/github/license/Web-Dev-Codi/cybersynth.nvim?style=for-the-badge&logo=apache&color=72f1b8&logoColor=72f1b8&labelColor=241b2f"></a>
  <img src="https://img.shields.io/badge/Neovim-0.10+-fede5d.svg?style=for-the-badge&logo=neovim&logoColor=fede5d&labelColor=241b2f">
  <img src="https://img.shields.io/badge/Made_with-Lua-fe4450.svg?style=for-the-badge&logo=lua&logoColor=fe4450&labelColor=241b2f">
  <img src="https://img.shields.io/badge/WCAG_AAA-Accessible-f97e72.svg?style=for-the-badge&logo=accessibility&labelColor=241b2f">
</p>

---

## Why cybersynth?

Synthwave colorschemes are usually one of two things: gorgeous and unreadable, or readable and not actually synthwave. Cybersynth is built around three convictions.

**First, contrast is non-negotiable.** Every accent in the dark palette clears WCAG AAA (7:1) against the background. Every accent in the light palette clears AA (4.5:1). The neons are real. The neons are also legible at 4am on a 13" laptop.

**Second, themes should style ideas, not plugins.** Modern Neovim plugins link their highlights to semantic hub groups (`DiagnosticError`, `@variable`, `Added`, `FloatBorder`, and ~40 more) using `default = true`. Cybersynth carefully colors every one of those hub groups. The result: a plugin you install tomorrow — one we've literally never seen — looks correct the first time you load it. No integration table. No `enable = true` switches. No PRs every week to "please add support for X."

**Third, both modes deserve the same love.** The light variant isn't a desaturated afterthought. It uses the same hue families as the dark variant — magenta becomes mulberry, cyan becomes deep teal, violet becomes eggplant — recalibrated for paper. The violet hour, just slightly later in the day.

---

## Features

- 🔌 **Plugin-agnostic by design** — styles hub groups, not plugin names; works on plugins we've never seen
- ♿ **WCAG AAA on dark, AA on light** — every accent verified against its background
- 🌗 **First-class light mode** — same hue families, recalibrated lightness
- ⚡ **Zero required config** — `colorscheme cybersynth` and done
- 🎛 **Override anything** — palette, single highlights, per-variant, via `overrides`
- 🖥 **Terminal colors** — 16 ANSI colors set for both variants

---

## Installation

### lazy.nvim

```lua
{
  "Web-Dev-Codi/cybersynth.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cybersynth").setup({})
    vim.cmd.colorscheme("cybersynth")
  end,
}
```

<details>
<summary><b>Other package managers</b></summary>

**packer.nvim:**

```lua
use {
  "Web-Dev-Codi/cybersynth.nvim",
  config = function()
    require("cybersynth").setup({})
    vim.cmd.colorscheme("cybersynth")
  end,
}
```

**vim-plug:**

```vim
Plug 'Web-Dev-Codi/cybersynth.nvim'
lua require('cybersynth').setup({})
colorscheme cybersynth
```

**dein.vim:**

```vim
call dein#add('Web-Dev-Codi/cybersynth.nvim')
```

**rocks.nvim:**

```lua
require('rocks').install('cybersynth.nvim')
```

**pathogen:**

```sh
cd ~/.vim/bundle && git clone https://github.com/Web-Dev-Codi/cybersynth.nvim
```

**Manual (runtimepath):**

```vim
set runtimepath^=/path/to/cybersynth.nvim
colorscheme cybersynth
```

</details>

---

## Usage

```vim
" Vimscript
colorscheme cybersynth
```

```lua
-- Lua
vim.cmd.colorscheme("cybersynth")
```

No need to call `setup()` unless you want to change something.

---

## Configuration

Full default config with inline docs:

```lua
require("cybersynth").setup({
  variant = "auto",     -- "dark" | "light" | "auto" (follows vim.o.background)
  transparent = false,  -- make Normal/NormalFloat/etc backgrounds NONE

  italic = {
    comments = true,    -- comments in italic
    keywords = false,
    functions = false,
    variables = false,
    strings = false,
  },

  bold = {
    functions = false,  -- function names in bold
  },

  -- Per-group overrides applied after all highlights
  overrides = {},
})
```

---

## Plugin Support

<details>
<summary><b>🔌 Plugin showcase</b> — works out of the box, no config required</summary>
<br>

Cybersynth styles hub groups, not plugin names. Well-behaved Neovim plugins link to core highlight groups with `default = true`, so they inherit cybersynth's colors automatically. No `enable = true` switches needed.

Visually verified with:

- telescope.nvim, fzf-lua, snacks.picker
- nvim-cmp, blink.cmp
- neo-tree.nvim, oil.nvim, mini.files
- lualine.nvim (with `theme = 'auto'`)
- gitsigns.nvim, diffview.nvim
- nvim-treesitter, treesitter-context
- noice.nvim, nvim-notify, fidget.nvim
- which-key.nvim, flash.nvim
- indent-blankline.nvim
- trouble.nvim, todo-comments.nvim
- ...and ~40 more that use the same inheritance pattern.

</details>

---

## Overrides & Recipes

**Get the active palette:**

```lua
local colors = require("cybersynth").get_colors()
local palette = require("cybersynth").get_palette()
```

**Transparent background:**

```lua
require("cybersynth").setup({
  transparent = true,
})
vim.cmd.colorscheme("cybersynth")
```

**Single highlight override:**

```lua
require("cybersynth").setup({
  overrides = {
    Comment = { fg = "#ff0000", italic = true },
    ["@keyword"] = { fg = "#ff7edb" },
  },
})
vim.cmd.colorscheme("cybersynth")
```

**Lualine attach:**

```lua
require("lualine").setup({
  options = {
    theme = "auto",  -- picks up StatusLine/StatusLineNC colors
  },
})
```

---

## Palette

| Name | Dark hex | Light hex | Role |
|------|----------|-----------|------|
| Magenta | ![#ff7edb](https://placehold.co/15x15/ff7edb/ff7edb.png) `#ff7edb` | ![#b3007a](https://placehold.co/15x15/b3007a/b3007a.png) `#b3007a` | variables, properties |
| Pink | ![#ff2d78](https://placehold.co/15x15/ff2d78/ff2d78.png) `#ff2d78` | ![#c2185b](https://placehold.co/15x15/c2185b/c2185b.png) `#c2185b` | builtin variables |
| Cyan | ![#36f9f6](https://placehold.co/15x15/36f9f6/36f9f6.png) `#36f9f6` | ![#0e7c86](https://placehold.co/15x15/0e7c86/0e7c86.png) `#0e7c86` | functions |
| Sky | ![#89ddff](https://placehold.co/15x15/89ddff/89ddff.png) `#89ddff` | ![#1976a8](https://placehold.co/15x15/1976a8/1976a8.png) `#1976a8` | parameters |
| Mint | ![#72f1b8](https://placehold.co/15x15/72f1b8/72f1b8.png) `#72f1b8` | ![#1f7a5a](https://placehold.co/15x15/1f7a5a/1f7a5a.png) `#1f7a5a` | strings, additions |
| Yellow | ![#fede5d](https://placehold.co/15x15/fede5d/fede5d.png) `#fede5d` | ![#8a5a00](https://placehold.co/15x15/8a5a00/8a5a00.png) `#8a5a00` | keywords |
| Amber | ![#ffb86c](https://placehold.co/15x15/ffb86c/ffb86c.png) `#ffb86c` | ![#a64a00](https://placehold.co/15x15/a64a00/a64a00.png) `#a64a00` | numbers alt |
| Coral | ![#f97e72](https://placehold.co/15x15/f97e72/f97e72.png) `#f97e72` | ![#c43e5a](https://placehold.co/15x15/c43e5a/c43e5a.png) `#c43e5a` | numbers, constants |
| Red | ![#fe4450](https://placehold.co/15x15/fe4450/fe4450.png) `#fe4450` | ![#a3001f](https://placehold.co/15x15/a3001f/a3001f.png) `#a3001f` | errors |
| Violet | ![#c792ea](https://placehold.co/15x15/c792ea/c792ea.png) `#c792ea` | ![#5b2a86](https://placehold.co/15x15/5b2a86/5b2a86.png) `#5b2a86` | types, classes |
| Lavender | ![#b893ce](https://placehold.co/15x15/b893ce/b893ce.png) `#b893ce` | ![#7a4b9e](https://placehold.co/15x15/7a4b9e/7a4b9e.png) `#7a4b9e` | git modified |

### Backgrounds

| Role | Dark | Light |
|------|------|-------|
| Deep (void) | ![#0d0d1a](https://placehold.co/15x15/0d0d1a/0d0d1a.png) `#0d0d1a` | ![#e8e2f5](https://placehold.co/15x15/e8e2f5/e8e2f5.png) `#e8e2f5` |
| Base (editor) | ![#1a1a2e](https://placehold.co/15x15/1a1a2e/1a1a2e.png) `#1a1a2e` | ![#fbf6ff](https://placehold.co/15x15/fbf6ff/fbf6ff.png) `#fbf6ff` |
| Alt (sidebar) | ![#241b2f](https://placehold.co/15x15/241b2f/241b2f.png) `#241b2f` | ![#f4eef9](https://placehold.co/15x15/f4eef9/f4eef9.png) `#f4eef9` |
| Float (popup) | ![#2a2139](https://placehold.co/15x15/2a2139/2a2139.png) `#2a2139` | ![#ede5f4](https://placehold.co/15x15/ede5f4/ede5f4.png) `#ede5f4` |
| Highlight (selection) | ![#34294f](https://placehold.co/15x15/34294f/34294f.png) `#34294f` | ![#e0d4ee](https://placehold.co/15x15/e0d4ee/e0d4ee.png) `#e0d4ee` |

### Foregrounds

| Role | Dark | Light |
|------|------|-------|
| Base text | ![#f4f0ff](https://placehold.co/15x15/f4f0ff/f4f0ff.png) `#f4f0ff` | ![#1a0e2e](https://placehold.co/15x15/1a0e2e/1a0e2e.png) `#1a0e2e` |
| Dim text | ![#b6b1cc](https://placehold.co/15x15/b6b1cc/b6b1cc.png) `#b6b1cc` | ![#3d2952](https://placehold.co/15x15/3d2952/3d2952.png) `#3d2952` |
| Subtle (comments) | ![#848bbd](https://placehold.co/15x15/848bbd/848bbd.png) `#848bbd` | ![#6b5b85](https://placehold.co/15x15/6b5b85/6b5b85.png) `#6b5b85` |
| Invisible | ![#4b4761](https://placehold.co/15x15/4b4761/4b4761.png) `#4b4761` | ![#c8bcd9](https://placehold.co/15x15/c8bcd9/c8bcd9.png) `#c8bcd9` |

---

## Comparison

| | cybersynth.nvim | Theme with 80 integrations |
|---|---|---|
| Works on plugins released *after* the theme | ✅ via hub-group inheritance | ❌ requires PR |
| New-plugin support PRs needed | Rare (only for polish) | Constant |
| Config table size | ~10 lines | ~80 toggles |
| User override always wins | ✅ via `overrides` | ⚠️ depends on integration |
| Light + dark mode parity | ✅ identical group surface | ⚠️ often partial |

---

## FAQ

**Neovim version?** >= 0.10 required.

**Truecolor terminal?** Yes. Set `set termguicolors` (the theme does this automatically).

**tmux italics/undercurls?** Add to your tmux.conf:

```tmux
set -g default-terminal "tmux-256color"
set -g terminal-overrides ',xterm-256color:smcur,rmcur'
```

**Plugin still looks wrong?** The plugin may be hardcoding colors instead of linking to hub groups. File an issue with that plugin's repo.

---

## License

MIT

---

<p align="center">
  <i>If cybersynth made your editor a little more electric, drop a ⭐. If a plugin still looks off, that's a bug we want to know about — open an issue.</i>
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/Web-Dev-Codi/cybersynth.nvim?style=for-the-badge&color=ff7edb&labelColor=241b2f" alt="License">
</p>
