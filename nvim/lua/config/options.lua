-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Sync clipboard with system clipboard
-- vim.opt.clipboard = vim.env.SSH_TTY and "unnamed" or "unnamedplus"
vim.opt.diffopt = "filler,internal,closeoff,algorithm:histogram,context:5,linematch:60"
if vim.g.neovide then
  vim.o.guifont = "Hack Nerd Font Mono:h12"
end
