-- Leader must be set before lazy loads any plugins
vim.g.mapleader = " "

-- ─── File navigation ──────────────────────────────────────────────────────────
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

-- ─── Visual mode: move selected lines ────────────────────────────────────────
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ─── Cursor stays in place on J and half-page jumps ──────────────────────────
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- ─── Keep search results centered ────────────────────────────────────────────
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- ─── Paste without losing register ───────────────────────────────────────────
-- "greatest remap ever" - paste over selection without yanking it
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yank" })

-- ─── System clipboard ────────────────────────────────────────────────────────
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- ─── Delete to void (don't pollute register) ─────────────────────────────────
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void" })

-- ─── Escape from insert mode ─────────────────────────────────────────────────
-- Using jj instead of jk — less likely to fire accidentally mid-word
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- ─── Disable Ex mode ─────────────────────────────────────────────────────────
vim.keymap.set("n", "Q", "<nop>")

-- ─── Quickfix / location list navigation ─────────────────────────────────────
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev location" })

-- ─── Project-wide rename current word ────────────────────────────────────────
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor" })

-- ─── Make file executable ────────────────────────────────────────────────────
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "chmod +x current file" })

-- ─── Quick source current file ───────────────────────────────────────────────
vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>", { desc = "Source current file" })

-- NOTE: <leader>f (format) is intentionally NOT set here.
-- It is set buffer-locally in the LspAttach autocmd in lazy.lua
-- so it only activates when an LSP is actually attached.
