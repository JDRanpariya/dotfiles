-- ─── Mason ────────────────────────────────────────────────────────────────────
require("mason").setup({
    PATH = "append",
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "html",
        "ltex",
        "pyright",
    },
    automatic_installation = true,
})

-- ─── Shared on_attach ─────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd",         vim.lsp.buf.definition,    "Go to Definition")
        map("gD",         vim.lsp.buf.declaration,   "Go to Declaration")
        map("gr",         vim.lsp.buf.references,    "References")
        map("gi",         vim.lsp.buf.implementation,"Go to Implementation")
        map("K",          vim.lsp.buf.hover,         "Hover Docs")
        map("<leader>rn", vim.lsp.buf.rename,        "Rename")
        map("<leader>ca", vim.lsp.buf.code_action,   "Code Action")
        map("<leader>f",  vim.lsp.buf.format,        "Format")
        map("[d",         vim.diagnostic.goto_prev,  "Prev Diagnostic")
        map("]d",         vim.diagnostic.goto_next,  "Next Diagnostic")
        map("<leader>e",  vim.diagnostic.open_float, "Show Diagnostic")
    end,
})

-- ─── Capabilities (from blink.cmp) ────────────────────────────────────────────
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- ─── Server configs (vim.lsp.config — Neovim 0.11+) ──────────────────────────

vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config("html", {
    capabilities = capabilities,
    filetypes = { "html", "htmldjango", "njk" },
})

vim.lsp.config("ltex", {
    capabilities = capabilities,
    settings = {
        ltex = { language = "en-US" },
    },
})

vim.lsp.config("pyright", {
    capabilities = capabilities,
})

-- Enable all configured servers
vim.lsp.enable({ "lua_ls", "html", "ltex", "pyright" })
