# AI Prompt Spec — Neovim Colorscheme Plugin

---

## ROLE & OBJECTIVE

You are an expert Neovim plugin author and Lua developer. Your task is to implement a complete,
production-quality Neovim colorscheme plugin from scratch. The plugin must:

1. Read the markdown documents in the `docs/` directory to understand the design principles and requirements.
2. Style **every** meaningful highlight group exposed by the Neovim UI API (versions 0.10 – 0.12),
   covering editor chrome, legacy syntax, Treesitter captures, LSP semantic tokens, and diagnostic
   groups — without referencing any specific third-party plugin by name in the highlight definitions.
3. Achieve broad plugin compatibility automatically: well-behaved plugins declare their own groups
   with `default = true` and link them to core Neovim groups. By defining those core groups
   correctly, the colorscheme propagates through every such plugin for free.
4. Be installable with **any** Neovim package manager: `lazy.nvim`, `packer.nvim`, `vim-plug`,
   `rocks.nvim`, `dein.vim`, `pathogen`, and manual `runtimepath` addition.
5. Expose a clean Lua `setup()` API for user configuration (variant, transparency, italic toggles, etc.).
6. Be structured for long-term maintainability: palette → semantic layer → highlight tables.

Do not skip, stub, or leave TODOs. Implement every file completely.

---

## SECTION 1 — PROJECT IDENTITY

```lua
THEME_NAME      = "cybersynth"          -- vim.g.colors_name; also the :colorscheme command name
PLUGIN_DIR_NAME = "cybersynth.nvim"     -- root directory / GitHub repo name
LUA_MODULE_NAME = "cybersynth"          -- require('cybersynth')
VARIANTS        = ["dark", "light"]    -- which background modes to support (remove "light" if N/A)
DEFAULT_VARIANT = "dark"
```

### Palette (hex values)

```lua
-- DARK VARIANT
dark = {
-- backgrounds
  bg_deep      = "#0d0d1a",   -- the void
  bg_base      = "#1a1a2e",   -- editor surface
  bg_alt       = "#241b2f",   -- sidebar, statusline
  bg_float     = "#2a2139",   -- floats, popups
  bg_highlight = "#34294f",   -- visual selection, search

-- foreground spine
  fg           = "#f4f0ff",   -- ~18:1 on bg_base
  fg_dim       = "#b6b1cc",   -- muted text
  fg_subtle    = "#848bbd",   -- comments
  fg_invisible = "#4b4761",   -- line-end chars, indent guides

  -- Accent colors (syntax + UI)
-- neon accents (all AAA on bg_base for non-red colors)
  magenta      = "#ff7edb",   -- variables, properties, headings
  pink         = "#ff2d78",   -- emphasized identifiers (sparingly)
  cyan         = "#36f9f6",   -- functions, links
  sky          = "#89ddff",   -- secondary cyan, parameters
  mint         = "#72f1b8",   -- strings, additions, tags
  yellow       = "#fede5d",   -- keywords
  amber        = "#ffb86c",   -- numbers, constants alt
  coral        = "#f97e72",   -- numbers, constants
  red          = "#fe4450",   -- errors
  violet       = "#c792ea",   -- types, classes
  lavender     = "#b893ce",   -- modified (git), italics

  -- Semantic surfaces
  border      = "#3b3b6b",
  selection   = "#2a2a50",
  search_bg   = "#4a3f80",
  search_fg   = "#f4f0ff",
  diff_add    = "#1e3a2a",
  diff_change = "#1e2d3a",
  diff_delete = "#3a1e24",
  diff_text   = "#2a3a5a",

  -- Diagnostic accents
  error       = "#ff5370",
  warn        = "#ffcb6b",
  info        = "#82aaff",
  hint        = "#c3e88d",
  ok          = "#c3e88d",

  -- Terminal (16 ANSI colors)
  term = {
    black         = "#0d0d1a",
    red           = "#fe4450",
    green         = "#72f1b8",
    yellow        = "#fede5d",
    blue          = "#82aaff",
    magenta       = "#ff7edb",
    cyan          = "#36f9f6",
    white         = "#c0b8d8",
    bright_black  = "#2d2d4a",
    bright_red    = "#ff869a",
    bright_green  = "#ddffa7",
    bright_yellow = "#ffe585",
    bright_blue   = "#9cc4ff",
    bright_magenta= "#e1acff",
    bright_cyan   = "#a3f7ff",
    bright_white  = "#f4f0ff",
  },
}

-- LIGHT VARIANT (mirror structure above with light palette values)
light = { 

  bg_deep      = "#e8e2f5",
  bg_base      = "#fbf6ff",   -- "magnolia mist" — keeps violet tint
  bg_alt       = "#f4eef9",
  bg_float     = "#ede5f4",
  bg_highlight = "#e0d4ee",

  fg           = "#1a0e2e",   -- ~17:1 on bg_base
  fg_dim       = "#3d2952",
  fg_subtle    = "#6b5b85",   -- comments
  fg_invisible = "#c8bcd9",

  magenta      = "#b3007a",   -- "mulberry"
  pink         = "#c2185b",
  cyan         = "#0e7c86",   -- "deep teal"
  sky          = "#1976a8",
  mint         = "#1f7a5a",   -- "forest jade"
  yellow       = "#8a5a00",   -- "amber" (not actual yellow — fails)
  amber        = "#a64a00",
  coral        = "#c43e5a",
  red          = "#a3001f",
  violet       = "#5b2a86",   -- "eggplant"
  lavender     = "#7a4b9e", 
}
```

---

## SECTION 2 — DIRECTORY & FILE STRUCTURE

Create the following file tree exactly. Do not add or remove files without noting the reason.

```
PLUGIN_DIR_NAME/
├── colors/
│   └── THEME_NAME.lua                  -- colorscheme entry point (:colorscheme THEME_NAME)
├── lua/
│   └── LUA_MODULE_NAME/
│       ├── init.lua                    -- public API: setup(), load(), get_palette()
│       ├── config.lua                  -- default config + user config merge
│       ├── palette.lua                 -- raw hex palette for all variants
│       ├── theme.lua                   -- palette → semantic color map
│       ├── highlights/
│       │   ├── init.lua                -- aggregates all highlight tables, applies them
│       │   ├── editor.lua              -- core UI chrome groups
│       │   ├── syntax.lua              -- legacy :h group-name syntax groups
│       │   ├── treesitter.lua          -- @ capture groups (0.8+)
│       │   ├── lsp.lua                 -- @lsp.type/mod/typemod + LspReference* + LspInlayHint
│       │   ├── diagnostic.lua          -- Diagnostic* family (all severities × all renderers)
│       │   └── terminal.lua            -- vim.g.terminal_color_0..15
│       └── util.lua                    -- helpers: nvim_set_hl wrapper, version detection, hex ops
├── plugin/
│   └── LUA_MODULE_NAME.lua             -- lazy-load guard + colorscheme autocmd registration
├── doc/
│   └── THEME_NAME.txt                  -- :help THEME_NAME vimdoc
└── README.md
```

---

## SECTION 3 — IMPLEMENTATION RULES

### 3.1 Core API rules

- **Only** use `vim.api.nvim_set_hl(0, name, opts)` to set highlights. Never use `vim.cmd("hi ...")`,
  `:highlight`, or `vim.api.nvim_command`. The Vimscript `:hi` path is legacy and bypasses the
  namespace system.
- **Never** set `default = true` in the colorscheme's own highlight definitions. `default = true`
  means "do not override if already defined" — plugins use it so the colorscheme wins; the
  colorscheme itself should always win.
- For groups that are intentional aliases within your theme, use `{ link = "OtherGroup" }`.
  When linking, do not supply any other keys — the Neovim API ignores them.
- Apply groups in namespace `0` (global). Never use a non-zero namespace from a colorscheme.
- The `util.lua` wrapper must handle the `update = true` key gracefully:
  pass it only when `vim.fn.has('nvim-0.12') == 1`.
- Gate version-specific groups behind `vim.fn.has()` checks so the plugin doesn't error on 0.10.

### 3.2 Entry point (`colors/THEME_NAME.lua`)

Must do exactly this, in order:

```lua
vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end
vim.o.termguicolors = true
vim.g.colors_name = 'THEME_NAME'
require('LUA_MODULE_NAME').load()
```

No other logic belongs here.

### 3.3 `setup()` API

Users call `require('LUA_MODULE_NAME').setup(opts)` in their config before any `:colorscheme`
command. The setup only stores configuration — it does **not** load highlights. Highlights are
loaded when `:colorscheme THEME_NAME` is executed (i.e. when `colors/THEME_NAME.lua` runs).

```lua
-- Default config shape (implement in config.lua)
{
  variant      = "auto",    -- "dark" | "light" | "auto" (follows vim.o.background)
  transparent  = false,     -- make Normal/NormalFloat/SignColumn backgrounds transparent (NONE)
  italic = {
    comments   = true,
    keywords   = false,
    functions  = false,
    variables  = false,
    strings    = false,
  },
  bold = {
    functions  = false,
  },
  -- Optional per-group overrides applied after all highlights are set.
  -- Format: { GroupName = { fg = "#hex", bg = "#hex", bold = true, ... } }
  overrides    = {},
}
```

### 3.4 Transparency support

When `transparent = true`, set the following groups to `bg = "NONE"`:
`Normal`, `NormalNC`, `NormalFloat`, `SignColumn`, `FoldColumn`, `StatusLine`, `StatusLineNC`,
`WinBar`, `WinBarNC`, `TabLine`, `TabLineFill`, `TabLineSel`. Keep `fg` values intact.
Everything else inherits through the link chain automatically.

### 3.5 Terminal color variables

In `highlights/terminal.lua`, set `vim.g.terminal_color_0` through `vim.g.terminal_color_15`
using the palette's `term` table. These power `:terminal` buffers and many terminal-adjacent
plugins.

---

## SECTION 4 — HIGHLIGHT GROUP CATALOGUE

Implement **every** group below. Groups marked `-- 0.10+`, `-- 0.11+`, `-- 0.12+` must be
wrapped in `if vim.fn.has('nvim-X.YY') == 1 then ... end`. Groups marked `-- legacy` should
still be included for backward compat.

### 4.1 `highlights/editor.lua` — Core UI chrome

```
-- Window & layout
Normal                  NormalNC                NormalFloat
FloatBorder             FloatTitle              FloatFooter         -- FloatFooter: 0.11+
WinSeparator            VertSplit               -- (VertSplit: legacy alias for WinSeparator)
WinBar                  WinBarNC                                    -- 0.10+

-- Cursor family
Cursor                  lCursor                 CursorIM
TermCursor              TermCursorNC

-- Line indicators
CursorLine              CursorColumn            CursorLineNr
CursorLineFold          CursorLineSign          -- 0.10+
LineNr                  LineNrAbove             LineNrBelow

-- Columns & folds
SignColumn              FoldColumn              Folded
ColorColumn

-- Status & tabs
StatusLine              StatusLineNC            StatusLineTerm      StatusLineTermNC
TabLine                 TabLineSel              TabLineFill
WildMenu                ToolbarLine             ToolbarButton

-- Completion popup (Pmenu)
Pmenu                   PmenuSel                PmenuSbar           PmenuThumb
PmenuKind               PmenuKindSel
PmenuExtra              PmenuExtraSel
PmenuMatch              PmenuMatchSel           -- 0.11+
ComplMatchIns                                   -- 0.11+

-- Search & selection
Visual                  VisualNOS
Search                  IncSearch               CurSearch           Substitute
MatchParen              QuickFixLine

-- Messages & prompts
ErrorMsg                WarningMsg              MoreMsg             Question
ModeMsg                 MsgArea                 MsgSeparator

-- Special text
NonText                 EndOfBuffer             Whitespace
SpecialKey              Conceal

-- Diff
DiffAdd                 DiffChange              DiffDelete          DiffText
DiffTextAdd                                     -- 0.12+
Added                   Changed                 Removed             -- 0.10+

-- Spell
SpellBad                SpellCap                SpellRare           SpellLocal

-- Misc
Directory               Title                   Underlined          Ignore
RedrawDebugNormal       RedrawDebugClear        RedrawDebugComposed RedrawDebugRecompose

-- Snippet
SnippetTabstop                                  -- 0.10+
```

### 4.2 `highlights/syntax.lua` — Legacy :h group-name

These are the classic Vim syntax groups. All Treesitter parsers link `@`-captures to these by
default, so they are the second most important set after the editor chrome.

```
Comment
Constant    String      Character   Number      Float       Boolean
Identifier  Function
Statement   Conditional Repeat      Label       Operator    Keyword     Exception
PreProc     Include     Define      Macro       PreCondit
Type        StorageClass Structure  Typedef
Special     SpecialChar Tag         Delimiter   SpecialComment Debug
Error       Todo        Underlined  Ignore
```

### 4.3 `highlights/treesitter.lua` — Treesitter `@` captures

Neovim resolves `@a.b.c` via dot-shortening fallback: it tries `@a.b.c`, then `@a.b`, then `@a`.
You only need to define the *root* of each subtree; sub-captures inherit automatically unless you
want to differentiate them. Where a sub-capture warrants a distinct color, add it explicitly.

```lua
-- Variables
["@variable"]                   -- general variables → link to Identifier or define fg
["@variable.builtin"]           -- self, this, super → accent color
["@variable.parameter"]         -- function parameters → subtle differentiation
["@variable.parameter.builtin"] -- builtin params (e.g. _ in Python)
["@variable.member"]            -- struct/object fields

-- Constants
["@constant"]                   -- ALL_CAPS constants
["@constant.builtin"]           -- nil, true, false, None
["@constant.macro"]             -- #define FOO

-- Modules / namespaces
["@module"]                     -- module/namespace identifiers
["@module.builtin"]

-- Labels
["@label"]                      -- goto labels, case labels

-- Literals
["@string"]                     -- string literals
["@string.documentation"]       -- docstring content
["@string.regexp"]              -- regex literals
["@string.escape"]              -- escape sequences \n \t
["@string.special"]             -- other special string content
["@string.special.symbol"]      -- symbols / atoms (Ruby :foo, Elixir :foo)
["@string.special.url"]         -- URLs inside strings
["@string.special.path"]        -- paths inside strings
["@character"]                  -- character literals 'a'
["@character.special"]          -- special chars (wildcards, etc.)
["@boolean"]
["@number"]
["@number.float"]

-- Functions & callables
["@function"]                   -- function definitions
["@function.builtin"]           -- print(), len(), built-ins
["@function.call"]              -- function call sites (often same as @function)
["@function.macro"]             -- macro invocations
["@function.method"]            -- method definitions
["@function.method.call"]       -- method call sites
["@constructor"]                -- new Foo(), __init__

-- Types
["@type"]                       -- type identifiers
["@type.builtin"]               -- int, str, bool, etc.
["@type.definition"]            -- typedef / type alias LHS
["@type.qualifier"]             -- const, mut, readonly, volatile

-- Attributes / annotations
["@attribute"]                  -- @decorator, #[derive(...)]
["@attribute.builtin"]

-- Properties
["@property"]                   -- object.property access

-- Keywords (differentiate carefully — these drive most of the "vibe" of a theme)
["@keyword"]                    -- generic keyword fallback
["@keyword.coroutine"]          -- async, await, yield
["@keyword.function"]           -- function, fn, def, fun
["@keyword.operator"]           -- and, or, not, in, is
["@keyword.import"]             -- import, require, use
["@keyword.type"]               -- type, struct, class, enum
["@keyword.modifier"]           -- public, private, static, override
["@keyword.repeat"]             -- for, while, loop, do
["@keyword.return"]             -- return, yield
["@keyword.debug"]              -- debugger, breakpoint
["@keyword.exception"]          -- try, catch, throw, raise
["@keyword.conditional"]        -- if, else, elif, switch, case
["@keyword.conditional.ternary"]-- ternary ? :
["@keyword.directive"]          -- preprocessor directives
["@keyword.directive.define"]   -- #define, #ifdef

-- Operators & punctuation
["@operator"]                   -- +, -, *, /, =, ==, etc.
["@punctuation"]                -- fallback
["@punctuation.delimiter"]      -- , ; . :
["@punctuation.bracket"]        -- ( ) [ ] { }
["@punctuation.special"]        -- string interpolation ${ }, heredoc markers

-- Comments (give extra love — they're everywhere)
["@comment"]                    -- // /* #
["@comment.documentation"]      -- /** JSDoc, """ Python, /// Rust
["@comment.error"]              -- FIXME HACK
["@comment.warning"]            -- WARN DEPRECATED
["@comment.todo"]               -- TODO
["@comment.note"]               -- NOTE SAFETY

-- Markup (Markdown, AsciiDoc, rst — loaded for md/rst buffers)
["@markup"]
["@markup.strong"]              -- **bold**
["@markup.italic"]              -- *italic*
["@markup.strikethrough"]       -- ~~strike~~
["@markup.underline"]
["@markup.heading"]             -- generic heading fallback
["@markup.heading.1"]           -- # H1 (through .6)
["@markup.heading.2"]
["@markup.heading.3"]
["@markup.heading.4"]
["@markup.heading.5"]
["@markup.heading.6"]
["@markup.heading.marker"]      -- the # signs themselves
["@markup.quote"]               -- > blockquote
["@markup.math"]                -- $LaTeX$
["@markup.link"]                -- hyperlinks
["@markup.link.label"]          -- link display text
["@markup.link.url"]            -- link target URL
["@markup.raw"]                 -- inline code `foo`
["@markup.raw.block"]           -- fenced code blocks
["@markup.list"]                -- - * list markers
["@markup.list.checked"]        -- - [x]
["@markup.list.unchecked"]      -- - [ ]

-- Diff (used by diff/git parsers)
["@diff.plus"]                  -- added lines
["@diff.minus"]                 -- removed lines
["@diff.delta"]                 -- changed lines

-- HTML / JSX / XML tags
["@tag"]
["@tag.builtin"]                -- HTML built-in tags (div, span, etc.)
["@tag.attribute"]              -- class=, id=, onClick=
["@tag.delimiter"]              -- < > / in tags

-- Errors (parser errors — usually red underline)
["@error"]

-- Deprecated captures (keep as links to their replacements for 0.9 compat)
["@text"]                       -- link → @markup
["@text.literal"]               -- link → @markup.raw
["@text.reference"]             -- link → @markup.link
["@text.title"]                 -- link → @markup.heading
["@text.uri"]                   -- link → @markup.link.url
["@text.underline"]             -- link → @markup.underline
["@text.todo"]                  -- link → @comment.todo
["@text.warning"]               -- link → @comment.warning
["@text.note"]                  -- link → @comment.note
["@text.danger"]                -- link → @comment.error
["@parameter"]                  -- link → @variable.parameter
["@field"]                      -- link → @variable.member
["@namespace"]                  -- link → @module
["@method"]                     -- link → @function.method
["@method.call"]                -- link → @function.method.call
["@float"]                      -- link → @number.float
["@symbol"]                     -- link → @string.special.symbol
```

### 4.4 `highlights/lsp.lua` — LSP semantic tokens + reference highlights

#### Built-in LSP UI groups

```
LspReferenceText            -- references under cursor (background highlight)
LspReferenceRead            -- read references
LspReferenceWrite           -- write references
LspReferenceTarget          -- 0.11+: target definition
LspSignatureActiveParameter -- active param in signature help
LspCodeLens                 -- codelens virtual text
LspCodeLensSeparator        -- separator between codelens entries
LspInlayHint                -- inlay hint virtual text
```

#### Semantic token type groups (`@lsp.type.*`)

Neovim 0.9+ ships default links for most of these to the corresponding `@`-capture. Declare all
of them explicitly in your theme so the colors are intentional, not inherited by accident.

```
@lsp.type.namespace         → link @module
@lsp.type.type              → link @type
@lsp.type.class             → link @type
@lsp.type.enum              → link @type
@lsp.type.interface         → link @type
@lsp.type.struct            → link @type
@lsp.type.typeParameter     → link @type
@lsp.type.parameter         → link @variable.parameter
@lsp.type.variable          → link @variable
@lsp.type.property          → link @variable.member
@lsp.type.enumMember        → link @constant
@lsp.type.function          → link @function
@lsp.type.method            → link @function.method
@lsp.type.macro             → link @function.macro
@lsp.type.decorator         → link @attribute
@lsp.type.event             → link @type
@lsp.type.keyword           → link @keyword
@lsp.type.modifier          → link @keyword.modifier
@lsp.type.comment           → link @comment
@lsp.type.string            → link @string
@lsp.type.number            → link @number
@lsp.type.regexp            → link @string.regexp
@lsp.type.operator          → link @operator
@lsp.type.lifetime          → link @keyword.modifier   -- Rust lifetimes
@lsp.type.builtinType       → link @type.builtin
@lsp.type.selfKeyword       → link @variable.builtin
@lsp.type.selfTypeKeyword   → link @variable.builtin
@lsp.type.typeAlias         → link @type.definition
@lsp.type.generic           → link @type
@lsp.type.label             → link @label
```

#### Semantic token modifier groups (`@lsp.mod.*`)

```
@lsp.mod.deprecated         → { strikethrough = true }
@lsp.mod.readonly           → link @constant              -- or add italic
@lsp.mod.static             → link @keyword.modifier
@lsp.mod.abstract           → link @keyword.modifier
@lsp.mod.async              → link @keyword.coroutine
@lsp.mod.documentation      → link @comment.documentation
@lsp.mod.defaultLibrary     → link @function.builtin
```

#### Compound typemod groups (high-value overrides only)

```
@lsp.typemod.variable.readonly          → link @constant
@lsp.typemod.variable.defaultLibrary    → link @variable.builtin
@lsp.typemod.function.defaultLibrary    → link @function.builtin
@lsp.typemod.method.defaultLibrary      → link @function.builtin
@lsp.typemod.variable.static            → link @constant
@lsp.typemod.property.readonly          → link @constant
```

### 4.5 `highlights/diagnostic.lua` — Diagnostic system

Implement all severity × renderer combinations. The base `Diagnostic{Severity}` groups drive
everything else via Neovim's default links — but declare the derived groups explicitly anyway.

```lua
-- Severity bases (the colors that matter most)
DiagnosticError             DiagnosticWarn
DiagnosticInfo              DiagnosticHint              DiagnosticOk

-- Virtual text (inline at end of line)
DiagnosticVirtualTextError  DiagnosticVirtualTextWarn
DiagnosticVirtualTextInfo   DiagnosticVirtualTextHint   DiagnosticVirtualTextOk

-- Virtual lines (separate line below) — 0.11+
DiagnosticVirtualLinesError DiagnosticVirtualLinesWarn
DiagnosticVirtualLinesInfo  DiagnosticVirtualLinesHint  DiagnosticVirtualLinesOk

-- Underlines (squiggles, straight, etc.)
DiagnosticUnderlineError    DiagnosticUnderlineWarn
DiagnosticUnderlineInfo     DiagnosticUnderlineHint     DiagnosticUnderlineOk

-- Floating window diagnostics
DiagnosticFloatingError     DiagnosticFloatingWarn
DiagnosticFloatingInfo      DiagnosticFloatingHint      DiagnosticFloatingOk

-- Signs (gutter icons) — note: legacy :sign-define removed in 0.12
DiagnosticSignError         DiagnosticSignWarn
DiagnosticSignInfo          DiagnosticSignHint          DiagnosticSignOk

-- Semantic extras
DiagnosticDeprecated        -- strikethrough on deprecated symbols
DiagnosticUnnecessary       -- dimmed unused variables/imports
```

---

## SECTION 5 — `util.lua` REQUIREMENTS

Implement the following helpers. Do not use third-party libraries.

```lua
-- Applies a table of { [group_name] = opts } in a single loop.
-- Handles version-gated groups via opts._min_version = "0.11" etc.
M.apply(groups_table)

-- Wraps nvim_set_hl; strips unknown keys so it never errors on older Neovim.
-- Passes `update = true` only when nvim 0.12+ is detected.
M.set(ns, name, opts)

-- Returns true/false for a feature gate.
M.has(version_string)   -- e.g. M.has("0.11")

-- Blends two hex colors at a given ratio (0.0–1.0). Used for derived bg tints.
M.blend(fg_hex, bg_hex, ratio) → hex_string

-- Darkens or lightens a hex color by a percentage.
M.darken(hex, pct)
M.lighten(hex, pct)

-- Returns the resolved semantic color map for the current variant.
M.get_colors() → theme_table
```

---

## SECTION 6 — `plugin/LUA_MODULE_NAME.lua` — PACKAGE MANAGER COMPATIBILITY

This file is what makes the plugin loadable by any package manager. It must:

1. **Prevent double-loading** with a `vim.g.loaded_LUA_MODULE_NAME` guard.
2. **Register a `ColorScheme` autocmd** so switching colorschemes (`:colorscheme foo`, then
   `:colorscheme THEME_NAME`) correctly re-applies highlights.
3. **Not load any highlights on its own** — it only registers the guard and autocmd.
4. **Be compatible with all package managers** — use only features available in Neovim 0.10+.

```lua
-- Example structure (implement fully):
if vim.g.loaded_LUA_MODULE_NAME then return end
vim.g.loaded_LUA_MODULE_NAME = true

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'THEME_NAME',
  callback = function()
    require('LUA_MODULE_NAME').load()
  end,
})
```

### Package manager install snippets (include in README.md)

Generate valid, copy-paste install snippets for all of the following. Each snippet should include
both the plugin spec and the minimal setup call.

- **lazy.nvim** (with `lazy = false` and `priority = 1000`)
- **packer.nvim**
- **vim-plug**
- **rocks.nvim** (luarocks-compatible — note whether the plugin needs a `rockspec`)
- **dein.vim**
- **pathogen** (manual clone instructions)
- **Manual** (raw `runtimepath` addition)

---

## SECTION 7 — VIMDOC (`doc/THEME_NAME.txt`)

Generate a proper vimdoc help file with:

- Header with `*THEME_NAME.txt*` tag and short description.
- `CONTENTS` section with jump tags.
- `INSTALLATION` with all package manager snippets (brief form, pointing to README).
- `CONFIGURATION` documenting every `setup()` option with types and defaults.
- `HIGHLIGHT GROUPS` section listing the major groups the theme defines.
- `TERMINAL COLORS` section.
- Footer with `vim:tw=78:ts=8:noet:ft=help:norl:`

---

## SECTION 8 — QUALITY CONSTRAINTS

- **No hardcoded hex strings outside `palette.lua`**. Every highlight must use the semantic
  color map from `theme.lua`.
- **No `pcall` suppression of errors**. If a `nvim_set_hl` call fails, the error should surface.
- **Idempotent `load()`**. Calling `load()` twice must not error or produce visual glitches.
- **No `vim.schedule` wrapping** of highlight application. Apply synchronously from `load()`.
- **Every file must have a module-level comment** explaining its purpose.
- **No global state mutation** except the standard colorscheme globals:
  `vim.g.colors_name`, `vim.o.termguicolors`, `vim.g.terminal_color_*`.
- **Lua style**: 2-space indent, `local M = {}` module pattern, `return M` at EOF. Use
  `vim.tbl_deep_extend` for config merging.
- **`colors/THEME_NAME.lua` must remain thin** — no logic, just the four lines from Section 3.2.
- Test that `:colorscheme THEME_NAME` works in a `nvim --clean` session with just the plugin on
  runtimepath.

---

## SECTION 9 — IMPLEMENTATION ORDER

Implement the files in this exact order so each file is complete before the next depends on it:

1. `lua/LUA_MODULE_NAME/palette.lua`
2. `lua/LUA_MODULE_NAME/util.lua`
3. `lua/LUA_MODULE_NAME/theme.lua`
4. `lua/LUA_MODULE_NAME/config.lua`
5. `lua/LUA_MODULE_NAME/highlights/terminal.lua`
6. `lua/LUA_MODULE_NAME/highlights/editor.lua`
7. `lua/LUA_MODULE_NAME/highlights/syntax.lua`
8. `lua/LUA_MODULE_NAME/highlights/treesitter.lua`
9. `lua/LUA_MODULE_NAME/highlights/lsp.lua`
10. `lua/LUA_MODULE_NAME/highlights/diagnostic.lua`
11. `lua/LUA_MODULE_NAME/highlights/init.lua`
12. `lua/LUA_MODULE_NAME/init.lua`
13. `colors/THEME_NAME.lua`
14. `plugin/LUA_MODULE_NAME.lua`
15. `doc/THEME_NAME.txt`
16. `README.md`

---

## SECTION 10 — DO NOT DO THIS

- Do **not** import or reference any third-party plugin (telescope, lualine, nvim-cmp, etc.) in any
  highlight file. Plugin compatibility happens automatically through the hub group strategy.
- Do **not** use `vim.cmd('highlight ...')` or `vim.api.nvim_command('highlight ...')`.
- Do **not** use `require('LUA_MODULE_NAME').setup()` inside `colors/THEME_NAME.lua`. Setup is
  user-called; load is entry-point-called.
- Do **not** output a light variant if `VARIANTS` does not include `"light"` above.
- Do **not** add any runtime dependencies beyond Neovim's own standard library.
- Do **not** use `0` as a shorthand for `false` or vice versa in Lua — be explicit.
- Do **not** silently ignore unknown `setup()` keys — warn with `vim.notify`.

---

BEGIN IMPLEMENTATION NOW. Output every file in full, in the order specified in Section 9.
Do not summarise, truncate, or skip any file. If a file is long, output it completely.
