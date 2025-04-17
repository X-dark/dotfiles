local M = {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          follow = true,
        })
      end,
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep({
          additional_args = {
            "--follow",
          },
        })
      end,
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers({
          ignore_current_buffer = true,
        })
      end,
    },
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
    },
  },
}

return { M }
