local M = {
  "OXY2DEV/markview.nvim",

  version = "*",

  lazy = false,
  priority = 49,

  opts = {
    preview = {
      icon_provider = "devicons", -- "mini" or "devicons"
    },
  },

  keys = {
    {
      "<leader>pp",
      function()
        vim.cmd("Markview Toggle")
      end,
      desc = "Toggle Markview",
    },
  },
}

return { M }
