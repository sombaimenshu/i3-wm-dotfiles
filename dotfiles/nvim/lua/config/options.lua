vim.g.mapleader = " "          -- must be set BEFORE lazy loads

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true   -- required for colors/transparency to work
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.swapfile = false

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "rounded"}
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { border = "rounded" }
)
vim.diagnostic.config({
  float = { border = "rounded" },
})

vim.opt.laststatus = 3        -- global statusline instead of per window
vim.opt.showmode = true      -- removes the -- INSERT -- text at bottom too
