-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Make Y behave like C or D
vim.keymap.set("n", "Y", "y$")

-- Select all
vim.keymap.set("n", "==", "gg<S-v>G")
-- Copy text to + register
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank into + register" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank into + register" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank into + register" })

-- Paste text from + register
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from + register" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from + register" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from + register" })
vim.keymap.set("v", "<leader>P", '"+P', { desc = "Paste from + register" })

-- Delete text to _ register
vim.keymap.set("n", "<localleader>d", '"_d', { desc = "Delete into _ register" })
vim.keymap.set("n", "<localleader>D", '"_D', { desc = "Delete into _ register" })
vim.keymap.set("v", "<localleader>d", '"_d', { desc = "Delete into _ register" })
vim.keymap.set("v", "<localleader>p", '"_dP', { desc = "Delete into _ register and paste" })
vim.keymap.set("n", "<localleader>c", '"+d', { desc = "Cut into + register" })
vim.keymap.set("n", "<localleader>C", '"+D', { desc = "Cut into + register" })
vim.keymap.set("v", "<localleader>c", '"+d', { desc = "Cut into + register" })

-- Move block
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Block Down" })
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Block Up" })

-- Move with arrow keys
-- vim.keymap.set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- vim.keymap.set("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- vim.keymap.set("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
