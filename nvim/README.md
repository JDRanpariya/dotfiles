# Neovim Config — Usage Reference

> Leader key: `Space`  
> All plugin keymaps only activate after their plugin loads (lazy-loaded on first use).

---

## Core Movement & Editing

These are remapped Vim defaults that change how built-in motions behave.

| Key | Mode | What it does |
|-----|------|-------------|
| `<C-d>` | Normal | Half-page down, cursor stays centered |
| `<C-u>` | Normal | Half-page up, cursor stays centered |
| `n` / `N` | Normal | Next/prev search result, cursor stays centered |
| `J` | Normal | Join line below — cursor stays in place (not end of line) |
| `J` / `K` | Visual | Move selected lines down / up (re-indents automatically) |
| `jj` | Insert | Exit insert mode |
| `Q` | Normal | Disabled (prevents accidental Ex mode) |

---

## Clipboard & Registers

| Key | Mode | What it does |
|-----|------|-------------|
| `<leader>y` | Normal / Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank line to system clipboard |
| `<leader>p` | Visual | Paste over selection without overwriting your yank register |
| `<leader>d` | Normal / Visual | Delete to void register (doesn't pollute `"`) |

**Why this matters:** In vanilla Vim, `d` overwrites your yank register. `<leader>d` lets you delete freely without losing what you copied. `<leader>p` lets you paste the same thing multiple times over different selections.

---

## File Navigation

### Oil — filesystem as a buffer
| Key | What it does |
|-----|-------------|
| `<leader>e` | Open Oil file explorer in current directory |
| `<leader>pv` | Open netrw (fallback, built-in) |

Inside Oil, you edit the directory like a text buffer. Rename by editing text. Delete by deleting a line. Create by adding a line. Write with `:w` to apply changes. Press `-` to go up a directory, `<CR>` to enter. This is the fastest way to navigate unfamiliar repos.

### Telescope — fuzzy finder
| Key | What it does |
|-----|-------------|
| `<leader>pf` | Find files (all files in project) |
| `<C-p>` | Find files (git-tracked only — faster, respects .gitignore) |
| `<leader>ps` | Grep string across project (prompts for input) |
| `<leader>pb` | Browse open buffers |
| `<leader>ph` | Search help tags |

Inside Telescope results: `<C-q>` sends all results to the quickfix list for batch editing.

**Tip:** Prefer `<C-p>` over `<leader>pf` in git repos — it's significantly faster and won't surface build artifacts.

### Harpoon — instant file switching
Harpoon lets you pin up to 4 files and jump to them instantly. Use it for the files you're actively working in right now.

| Key | What it does |
|-----|-------------|
| `<leader>a` | Pin current file to Harpoon |
| `<C-e>` | Open Harpoon menu (reorder or remove pins) |
| `<C-h>` | Jump to pinned file 1 |
| `<C-t>` | Jump to pinned file 2 |
| `<C-n>` | Jump to pinned file 3 |
| `<C-s>` | Jump to pinned file 4 |

**Workflow:** Open your 3–4 main files for a task, pin them all with `<leader>a`, then use `<C-h/t/n/s>` to switch with zero latency. Clear and re-pin when you switch tasks.

---

## LSP — Code Intelligence

LSP keymaps only activate in buffers where a language server is attached. Supported languages: Lua, HTML/Nunjucks, Python, TypeScript/JavaScript, CSS, JSON, Bash.

| Key | What it does |
|-----|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Show all references |
| `gi` | Go to implementation |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol (renames across all files) |
| `<leader>ca` | Code actions (auto-imports, fixes, refactors) |
| `<leader>f` | Format current file |
| `[d` / `]d` | Jump to prev / next diagnostic |
| `<leader>e` | Show diagnostic detail in float |

**Tip:** `<leader>rn` is project-wide rename — far more reliable than search/replace for variable names. `<leader>ca` on an unresolved import will auto-add it.

### Completion (blink.cmp)

Completion triggers automatically. Default keymap preset:

| Key | What it does |
|-----|-------------|
| `<Tab>` / `<S-Tab>` | Navigate completion menu |
| `<CR>` | Accept selected completion |
| `<C-space>` | Trigger completion manually |
| `<C-e>` | Close completion menu |

Function signatures appear automatically as you type arguments — no keymap needed.

### Mason — LSP server management

Run `:Mason` to open the installer UI. Servers that are in `ensure_installed` auto-install on first launch. To add a new server: install it via `:Mason`, then add it to `ensure_installed` and `vim.lsp.enable()` in `lazy.lua`.

---

## Git

### Gitsigns — inline hunk operations

Changes in your buffer are marked in the sign column. Use these without leaving the file.

| Key | What it does |
|-----|-------------|
| `]h` / `[h` | Jump to next / prev changed hunk |
| `<leader>hs` | Stage current hunk |
| `<leader>hr` | Reset (discard) current hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hu` | Undo last staged hunk |
| `<leader>hp` | Preview hunk diff in float |
| `<leader>hb` | Show full blame for current line |
| `<leader>hd` | Diff current file against HEAD |

**Workflow:** Use `<leader>hs` to stage individual hunks before committing — much more granular than `git add -p` in a terminal.

### Fugitive — Git commands

| Key / Command | What it does |
|---------------|-------------|
| `<leader>gs` | Open Git status window |
| `:Git commit` | Commit staged changes |
| `:Git push` | Push |
| `:Git pull` | Pull |
| `:Gdiffsplit` | Open diff split for current file |
| `:Gclog` | Show commit log for current file |

Inside the Fugitive status window: `s` to stage, `u` to unstage, `cc` to commit, `=` to inline diff, `<CR>` to open file.

---

## AI Assistant (CodeCompanion)

Requires `ANTHROPIC_API_KEY` set in your shell environment. Uses `claude-sonnet-4-20250514` by default.

| Key | Mode | What it does |
|-----|------|-------------|
| `<leader>cc` | Normal / Visual | Toggle AI chat panel |
| `<leader>ca` | Normal / Visual | Open actions menu (explain, test, refactor, etc.) |
| `<leader>ci` | Normal / Visual | Inline assist — give an instruction, get an edit |

**Chat (`<leader>cc`):** Persistent conversation panel. Ask architectural questions, paste errors, discuss code. Select code in visual mode first to include it in the chat context.

**Actions (`<leader>ca`):** Menu of pre-built prompts — explain code, generate tests, fix diagnostics, add documentation. Works on visual selection or entire buffer.

**Inline (`<leader>ci`):** You type an instruction ("extract this into a function", "add error handling"), CodeCompanion edits the code directly. Works best on visual selections.

**Setup:** Add to your shell rc file:
```bash
export ANTHROPIC_API_KEY="sk-ant-..."
```

---

## Undo History

| Key | What it does |
|-----|-------------|
| `<leader>u` | Toggle undotree panel |

Undotree shows the full branching undo history as a tree — you can recover changes that were overwritten by later edits. Neovim persists undo history across sessions (stored in `~/.vim/undodir`), so you can undo changes from previous sessions.

---

## Quickfix & Search

| Key | What it does |
|-----|-------------|
| `<C-k>` / `<C-j>` | Next / prev quickfix item |
| `<leader>k` / `<leader>j` | Next / prev location list item |
| `<leader>s` | Project-wide rename word under cursor (opens substitution command) |

The quickfix list is populated by Telescope's `<C-q>`, LSP references (`gr`), and `:Gclog`. Use `<C-k/j>` to navigate through all matches after sending results there.

**`<leader>s` workflow:** Place cursor on a word, press `<leader>s`, the substitution pattern is pre-filled with that word — just type the replacement and press Enter. Runs across the entire file.

---

## Treesitter Debugging

These are built into Neovim core (no plugin needed):

| Command | What it does |
|---------|-------------|
| `:InspectTree` | Show the treesitter parse tree for the current buffer |
| `:EditQuery` | Interactively write and test treesitter queries |

---

## Plugin Management (lazy.nvim)

| Command | What it does |
|---------|-------------|
| `:Lazy` | Open plugin manager UI |
| `:Lazy update` | Update all plugins |
| `:Lazy sync` | Install missing + update + clean unused |
| `:Lazy clean` | Remove plugins no longer in config |
| `:Lazy profile` | Show startup time breakdown per plugin |

Plugin updates are checked silently in the background. You won't be notified — run `:Lazy` periodically to see if updates are available.

---

## Misc

| Key / Command | What it does |
|---------------|-------------|
| `<leader>x` | `chmod +x` current file (make it executable) |
| `<leader><leader>` | Source (reload) current Lua file |
| `:MarkdownPreview` | Open live markdown preview in browser (`.md` files only) |
| `colorcolumn` | Pink line at column 80 — target for line length |

---

## Language Support Summary

| Language | Highlighting | LSP | Formatter |
|----------|-------------|-----|-----------|
| Python | ✓ Treesitter | Pyright | `<leader>f` |
| TypeScript / JS | ✓ Treesitter | ts_ls | `<leader>f` |
| HTML / Nunjucks | ✓ Treesitter + Jinja2 | html | `<leader>f` |
| CSS | ✓ Treesitter | cssls | `<leader>f` |
| JSON | ✓ Treesitter | jsonls | `<leader>f` |
| Lua | ✓ Treesitter | lua_ls | `<leader>f` |
| Bash | ✓ Treesitter | bashls | `<leader>f` |
| Markdown | ✓ Treesitter | — | `:MarkdownPreview` |
| C | ✓ Treesitter | — | — |

---

## Recommended Workflows

**Starting a new task**
1. Open the repo root with `nvim .` — Oil opens automatically
2. Navigate to your entry files with Oil or `<C-p>`
3. Pin your 3–4 working files with `<leader>a`
4. Use `<C-h/t/n/s>` to switch between them from now on

**Reviewing a diff before committing**
1. `<leader>gs` to open Fugitive status
2. `=` on a file to see inline diff
3. `<leader>hp` on individual hunks to preview
4. `<leader>hs` to stage only the hunks you want
5. `cc` in Fugitive to commit

**Refactoring with AI**
1. Visual-select the code you want to change
2. `<leader>ci` for a direct edit ("extract this into a class", "add type hints")
3. Or `<leader>cc` to open chat for a more involved discussion
4. Use `<leader>rn` to rename symbols after restructuring

**Tracking down a bug**
1. `<leader>ps` to grep for the error string or function name
2. `<C-q>` in Telescope to send all matches to quickfix
3. `<C-k/j>` to step through each match
4. `gr` on the symbol to see all references
5. `<leader>hb` to blame a line if it's a regression
