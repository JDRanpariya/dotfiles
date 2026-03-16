-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Colorscheme
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000, -- load before other plugins
        config = function()
            -- colors config is still handled by after/plugin/colors.lua
        end,
    },

    -- Syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- config is handled by after/plugin/treesitter.lua
    },

    -- Jinja2 / Nunjucks syntax
    "Glench/Vim-Jinja2-Syntax",

    -- Undo history visualizer
    "mbbill/undotree",

    -- File bookmarks
    {
        "theprimeagen/harpoon",
        branch = "master", -- pin to harpoon 1 API
    },

    -- Git integration
    "tpope/vim-fugitive",

    -- Markdown preview
    {
        "selimacerbas/markdown-preview.nvim",
        dependencies = { "selimacerbas/live-server.nvim" },
        config = function()
            require("markdown_preview").setup({
                -- all optional; sane defaults shown
                instance_mode = "takeover",  -- "takeover" (one tab) or "multi" (tab per instance)
                port = 0,                    -- 0 = auto (8421 for takeover, OS-assigned for multi)
                open_browser = true,
                debounce_ms = 300,
            })
        end,
    },

    -- Auto close brackets
    "m4xshen/autoclose.nvim",

    -- LSP
    "neovim/nvim-lspconfig",

    -- Mason: LSP server installer
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Completion (blink.cmp)
    {
        "saghen/blink.cmp",
        version = "*", -- use a release tag for pre-built binaries
        opts = {
            keymap = { preset = "default" },
            appearance = {
                use_nvim_cmp_as_default = true,
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            completion = {
                accept = { auto_brackets = { enabled = true } },
            },
        },
    },

})
