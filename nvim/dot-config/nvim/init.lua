require("config.lazy")

vim.opt.nu = true
vim.opt.colorcolumn = "80"
vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.cursorcolumn = true

vim.keymap.set("n", "<Leader>gf", vim.lsp.buf.format, { desc = "Format current Buffer" })
