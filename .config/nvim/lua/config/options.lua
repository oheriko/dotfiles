vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.cmdheight = 0
vim.opt.guicursor = "n-v-c-i:block-blinkwait1000-blinkon500-blinkoff500"
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 999
vim.opt.backupcopy = "yes"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.listchars:append({
  tab = "❘-",
  trail = "￮",
  extends = "▶",
  precedes = "◀",
  nbsp = "⏑",
})
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500
vim.opt.autoread = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup", "preview" }
vim.opt.pumheight = 15
vim.opt.pumwidth = 25
vim.opt.shortmess:append("c")
