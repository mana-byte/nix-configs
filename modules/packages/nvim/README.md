# NVF — mana-byte neovim config

Welcome to my NVF — a curated Neovim setup that's equal parts practical. It’s designed to be fast, modern, and friendly to both Vim veterans and curious newcomers. This README highlights the key plugins, notable settings, and the most important keymaps so you can get productive (and maybe smile a little) faster.

---

## TL;DR
- Neovim package: neovim-unwrapped
- Leader key: `,` (comma)
- Key features: LSP support, Telescope with fzf, Conform formatting, Noice notifications, Git integrations, and a handful of fun quality-of-life plugins

---

## Plugin highlights (what makes NVF sparkle)
This configuration enables (or configures) a broad set of plugins and modules. Here are the ones you’ll notice most:

- Telescope (+ fzf-native): powerful fuzzy finding across files, buffers, git history and more
- oil.nvim: modern file explorer with a minimal key to open it
- undotree: visual undo history explorer
- windows-nvim: smarter split and window handling (extra plugin)
- lensline-nvim, smear-cursor-nvim: small visual niceties for your statusline and cursor
- tiny-inline-diagnostic: inline diagnostics with style presets
- Conform (formatting): configured formatters (stylua, black, alejandra, biome)
- nvim-cmp: completion with friendly keymaps
- Noice + nvim-notify: polish for command-line and notifications
- Leap (motion): fast navigation with custom mappings
- surround, autopairs, comment-nvim: classic editor comforts
- WhichKey and todo-comments: discoverability and TODO highlighting
- Treesitter: better syntax highlighting and structural features
- LSP & trouble: integrated language intelligence and diagnostics
- Copilot + Avante: assistant features are enabled (Copilot completions integrated with cmp)

Extra plugins added explicitly:
- windows-nvim
- lensline-nvim
- smear-cursor-nvim
- tiny-inline-diagnostic-nvim

---

## Important keymaps (the juicy bits)
Leader is `,` (comma). Here are the keymaps you’ll likely use every day:

- Undo & history:
  - `,u` — Toggle Undotree (visual undo history)

- Splits (because muscle memory is sacred):
  - `<C-l>` — Vertical split (vsplit)
  - `<C-h>` — Horizontal split (split)

- Formatting:
  - `<Space>ff` — Format buffer via Conform (async, fall back to LSP)

- File explorer:
  - `-` — Open Oil file explorer

- Notifications:
  - `,nd` — Dismiss Noice notifications

- Telescope quick picks:
  - `,fo` — Recent files (Telescope oldfiles)
  - `,fh` — Help tags
  - `,fr` — Resume last Telescope session
  - `,fs` — Grep string under cursor
  - Additional Telescope mappings:
    - findFiles -> `<leader>ff`
    - buffers -> `<leader>fb`
    - gitBranches -> `<leader>gb`
    - gitCommits -> `<leader>gc`
    - liveGrep -> `<leader>fg`

- LSP helpers (when language server is running):
  - `,rn` — Rename symbol
  - `,ca` — Code action
  - `,gd` — Go to definition
  - `,gr` — References
  - `,gi` — Implementation
  - `,gs` — Signature help

- Diagnostics & navigation:
  - `,dn` — Next diagnostic (floating)
  - `,dp` — Previous diagnostic (floating)
  - `,dl` — Send diagnostics to location list
  - `<C-t>` — Open Trouble

- Window management & misc:
  - `,we` — Equalize windows
  - `,wm` — Maximise current window
  - `,mv` — Toggle Markdown view (Markview)
  - `,gg` — Open Git interface

Note: Leader is `,`, so e.g. `,rn` means press comma then r then n.

---

## Formatting defaults
Conform is configured to use these formatters by filetype:
- lua: stylua
- python: black
- nix: alejandra
- javascript/typescript/react: biome

---

## How to view this config quickly
- The main configuration file: `nvf-configuration.nix` (in this repo)
- Extra plugins are declared under `vim.extraPlugins` in the same file

