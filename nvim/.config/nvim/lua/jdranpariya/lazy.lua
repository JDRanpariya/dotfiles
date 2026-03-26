-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
vim.fn.search()
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

-- ─── Colorscheme ──────────────────────────────────────────────────────────────
-- Load eagerly so every other plugin gets correct highlight groups
{
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            variant = "auto",
            dark_variant = "main",
            dim_nc_background = false,
            disable_background = false,
            disable_italics = true,
            groups = {
                background = "base",
                panel = "surface",
                border = "highlight_med",
                comment = "muted",
                link = "iris",
                punctuation = "subtle",
                error = "love",
                hint = "iris",
                info = "foam",
                warn = "gold",
                headings = {
                    h1 = "iris", h2 = "foam", h3 = "rose",
                    h4 = "gold", h5 = "pine", h6 = "foam",
                },
            },
            highlight_groups = {
                ColorColumn = { bg = "rose" },
                CursorLine = { bg = "foam", blend = 10 },
                StatusLine = { fg = "love", bg = "love", blend = 10 },
                Search = { bg = "gold", inherit = false },
            },
        })
        vim.cmd("colorscheme rose-pine")
    end,
},

-- ─── Syntax highlighting ──────────────────────────────────────────────────────
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }, -- lazy: load after buffer opens
    config = function()
        vim.filetype.add({ extension = { njk = "html" } })

        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then return end
        configs.setup({
            ensure_installed = {
                "python", "javascript", "typescript", "tsx",
                "html", "css", "json", "yaml", "toml",
                "c", "lua", "vim", "vimdoc", "query",
                "markdown", "markdown_inline", "bash",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "html" },
            },
            indent = { enable = true },
        })
    end,
},

-- Jinja2 / Nunjucks syntax (complements treesitter for template tags)
{
    "Glench/Vim-Jinja2-Syntax",
    ft = { "html", "njk", "jinja" },
},

-- ─── Fuzzy finder ────────────────────────────────────────────────────────────
{
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",                          -- lazy: load on :Telescope command
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end,  desc = "Find files" },
        { "<C-p>",      function() require("telescope.builtin").git_files() end,   desc = "Git files" },
        { "<leader>ps", function()
            require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
        end, desc = "Grep string" },
        { "<leader>pb", function() require("telescope.builtin").buffers() end,     desc = "Buffers" },
        { "<leader>ph", function() require("telescope.builtin").help_tags() end,   desc = "Help tags" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        defaults = {
            mappings = {
                i = { ["<C-q>"] = "send_to_qflist" },
            },
        },
    },
},

-- ─── File navigation ─────────────────────────────────────────────────────────
-- oil.nvim: edit filesystem like a buffer, much better than netrw for exploration
{
    "stevearc/oil.nvim",
    lazy = false,   -- load at startup so it can handle `nvim .`
    keys = {
        { "<leader>dir", "<cmd>Oil<CR>", desc = "Open file explorer (Oil)" },
    },
    opts = {
        view_options = { show_hidden = true },
        float = { padding = 2 },
    },
},

-- ─── File bookmarks ───────────────────────────────────────────────────────────
{
    "theprimeagen/harpoon",
    branch = "master",                          -- pin to harpoon 1 API
    keys = {
        { "<leader>a", function() require("harpoon.mark").add_file() end,       desc = "Harpoon: add file" },
        { "<C-e>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: menu" },
        { "<C-h>",     function() require("harpoon.ui").nav_file(1) end,         desc = "Harpoon: file 1" },
        { "<C-t>",     function() require("harpoon.ui").nav_file(2) end,         desc = "Harpoon: file 2" },
        { "<C-n>",     function() require("harpoon.ui").nav_file(3) end,         desc = "Harpoon: file 3" },
        { "<C-s>",     function() require("harpoon.ui").nav_file(4) end,         desc = "Harpoon: file 4" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
},

-- ─── Undo history ────────────────────────────────────────────────────────────
{
    "mbbill/undotree",
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undotree" },
    },
},

-- ─── Git ─────────────────────────────────────────────────────────────────────
{
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Gclog" },
    keys = {
        { "<leader>gs", vim.cmd.Git, desc = "Git status (fugitive)" },
    },
},

-- gitsigns: inline git hunks, blame, stage from buffer
{
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        signs = {
            add          = { text = "▎" },
            change       = { text = "▎" },
            delete       = { text = "" },
            topdelete    = { text = "" },
            changedelete = { text = "▎" },
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local map = function(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            -- Navigation
            map("n", "]h", gs.next_hunk,              "Next hunk")
            map("n", "[h", gs.prev_hunk,              "Prev hunk")
            -- Actions
            map("n", "<leader>hs", gs.stage_hunk,     "Stage hunk")
            map("n", "<leader>hr", gs.reset_hunk,     "Reset hunk")
            map("n", "<leader>hS", gs.stage_buffer,   "Stage buffer")
            map("n", "<leader>hu", gs.undo_stage_hunk,"Undo stage hunk")
            map("n", "<leader>hp", gs.preview_hunk,   "Preview hunk")
            map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
            map("n", "<leader>hd", gs.diffthis,       "Diff this")
        end,
    },
},

-- ─── AI assistant ────────────────────────────────────────────────────────────
-- codecompanion: chat + inline assist, works with Claude/GPT/Ollama
{
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
        { "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>",   mode = { "n", "v" }, desc = "AI: toggle chat" },
        { "<leader>ca", "<cmd>CodeCompanionActions<CR>",        mode = { "n", "v" }, desc = "AI: actions" },
        { "<leader>ci", "<cmd>CodeCompanion<CR>",               mode = { "n", "v" }, desc = "AI: inline assist" },
    },
    opts = {
        -- Set your preferred adapter. Options: "anthropic", "openai", "ollama"
        -- Set ANTHROPIC_API_KEY or OPENAI_API_KEY in your shell env.
        strategies = {
            chat   = { adapter = "anthropic" },
            inline = { adapter = "anthropic" },
        },
        adapters = {
            anthropic = function()
                return require("codecompanion.adapters").extend("anthropic", {
                    schema = { model = { default = "claude-sonnet-4-20250514" } },
                })
            end,
        },
    },
},

-- ─── LSP ─────────────────────────────────────────────────────────────────────
{
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim",           build = ":MasonUpdate" },
        { "williamboman/mason-lspconfig.nvim" },
        { "saghen/blink.cmp" },                -- must be set up before lspconfig
    },
    event = { "BufReadPost", "BufNewFile" },   -- lazy: load when a real file opens
    config = function()
        -- Mason
        require("mason").setup({ PATH = "append" })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "html",
                "pyright",
                "ts_ls",          -- TypeScript / JavaScript
                "cssls",          -- CSS
                "jsonls",         -- JSON
                "bashls",         -- Bash
            },
            automatic_installation = true,
        })

        -- Keymaps — set buffer-locally when LSP attaches
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

        -- Capabilities from blink.cmp
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        -- Server configs (Neovim 0.11+ API)
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

        vim.lsp.config("pyright", {
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        vim.lsp.config("ts_ls",   { capabilities = capabilities })
        vim.lsp.config("cssls",   { capabilities = capabilities })
        vim.lsp.config("jsonls",  { capabilities = capabilities })
        vim.lsp.config("bashls",  { capabilities = capabilities })

        vim.lsp.enable({ "lua_ls", "html", "pyright", "ts_ls", "cssls", "jsonls", "bashls" })
    end,
},

-- ─── Completion ───────────────────────────────────────────────────────────────
{
    "saghen/blink.cmp",
    version = "*",
    lazy = false,   -- must be available before LSP config runs
    opts = {
        keymap = { preset = "enter" },
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
            accept = { auto_brackets = { enabled = true } },
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
            menu = { draw = { treesitter = { "lsp" } } },
        },
        signature = { enabled = true },  -- show function signature while typing args
    },
},

-- ─── Auto close brackets ─────────────────────────────────────────────────────
{
    "m4xshen/autoclose.nvim",
    event = "InsertEnter",  -- lazy: only needed in insert mode
    opts = {},
},

-- ─── Markdown preview ────────────────────────────────────────────────────────
{
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
},

}, {
    -- lazy.nvim options
    checker = { enabled = true, notify = false }, -- silent background update checks
    change_detection = { notify = false },         -- don't nag about config changes
})

-- only apply in WSL2
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "clip.exe",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw))',
    },
    cache_enabled = 0,
  }
end
