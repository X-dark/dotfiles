local M = {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    close_if_last_window = true,
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true})
      end,
      desc = "Explorer NeoTree",
    },
  },
}

return { M }
