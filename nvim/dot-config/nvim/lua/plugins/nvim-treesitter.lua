local M = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  dependencies = { "OXY2DEV/markview.nvim" },
  lazy = false,
  build = ":TSUpdate",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      -- optional: install directory, logging, etc.
    })

    ts.install({
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}

return { M }
