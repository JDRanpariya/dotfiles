-- ─── Cursor ───────────────────────────────────────────────────────────────────
vim.opt.guicursor = ""          -- block cursor in all modes

-- ─── Line numbers ────────────────────────────────────────────────────────────
vim.opt.nu = true
vim.opt.relativenumber = true

-- ─── Indentation ─────────────────────────────────────────────────────────────
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- ─── Lines ───────────────────────────────────────────────────────────────────
vim.opt.wrap = false
vim.opt.colorcolumn = "80"

-- ─── Files ───────────────────────────────────────────────────────────────────
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- ─── Search ──────────────────────────────────────────────────────────────────
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- ─── Appearance ──────────────────────────────────────────────────────────────
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"      -- always show, prevents layout shift

-- ─── Scroll ──────────────────────────────────────────────────────────────────
vim.opt.scrolloff = 8

-- ─── Misc ────────────────────────────────────────────────────────────────────
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50         -- faster CursorHold events (gitsigns, diagnostics)
vim.opt.splitright = true       -- vertical splits open to the right
vim.opt.splitbelow = true       -- horizontal splits open below
