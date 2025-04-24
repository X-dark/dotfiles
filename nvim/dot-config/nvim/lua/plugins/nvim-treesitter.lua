local M = {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}

return { M }
