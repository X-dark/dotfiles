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
}

return { M }
