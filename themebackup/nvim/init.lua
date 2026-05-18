require("config.options")
require("config.keymaps")

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load all plugins from lua/plugins/
require("lazy").setup("plugins")

-- transparency (after colorscheme loads)
vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC",    { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn",  { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#4aafe3"})
vim.api.nvim_set_hl(0, "StatusLine",   { bg = "none" })
vim.api.nvim_set_hl(0, "WinBar",       { bg = "none" })

vim.opt.cursorline = true  -- keep it on, just make it look better
vim.api.nvim_set_hl(0, "CursorLine",   { bg = "" })  -- add cursor background highlight here
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff1378", bold = true })  -- current line number glows
