local M = {
  "nvimtools/none-ls.nvim",
  opts = function()
    local null_ls = require("null-ls")
    local ret = {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.hover.printenv,
      },
    }
    return ret
  end,
}

return { M }
