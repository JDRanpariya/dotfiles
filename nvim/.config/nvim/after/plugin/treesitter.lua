-- Tell Neovim how to treat .njk files
vim.filetype.add({
  extension = {
    njk = "html", -- Treat Nunjucks files as HTML
  },
})

-- Treesitter setup
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "python",
    "javascript",
    "html",
    "css",
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query"
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "html" }, -- allow regex highlighting for Jinja2/Nunjucks
  },
}

