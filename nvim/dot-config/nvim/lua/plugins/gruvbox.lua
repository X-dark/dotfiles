local M = {
  {
    "morhetz/gruvbox",
    enable = false,
    config = function()
      -- vim.g.gruvbox_italic = 1
      vim.g.gruvbox_transparent_bg = 1
      -- vim.g.gruvbox_contrast_dark = "hard"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}

return { M }
