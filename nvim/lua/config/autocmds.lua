-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Fix snacks.image aspect ratio for WezTerm over SSH.
-- TIOCGWINSZ reports square cells (e.g. 8x8 px) over SSH because WezTerm does not
-- forward actual font cell pixel dimensions in the PTY handshake. snacks.image uses
-- cell_width/cell_height to convert image pixels → cell counts; square cells produce
-- a 1:1 ratio that distorts every image. Patch terminal.size() to apply a 2:1
-- height:width ratio (typical for monospace fonts) whenever square cells are detected.
-- NOTE: this file is sourced during VeryLazy, so vim.schedule defers one tick to
-- after all plugin setup in the current event-loop tick is complete.
vim.schedule(function()
  pcall(function()
    local terminal = require("snacks.image.terminal")
    local _orig_size = terminal.size
    terminal.size = function()
      local s = _orig_size()
      if s.cell_width > 0 and s.cell_width == s.cell_height then
        s = vim.deepcopy(s)
        s.cell_height = s.cell_width * 2
        s.height = s.rows * s.cell_height
      end
      return s
    end
  end)
end)

-- Image buffer lifecycle for snacks.image in WezTerm fallback mode.
-- Kitty-graphics images render at absolute terminal coordinates and persist on screen
-- until an explicit delete is sent. snacks's hide() doesn't send the delete in fallback
-- mode, so images from a previous buffer paint over the next one. Clean on BufHidden
-- (which fires only when the buffer is no longer shown in any window — unlike BufLeave
-- which also fires on focus changes that don't actually swap the buffer out) and
-- re-attach on BufEnter so returning to the buffer redraws.
local img_group = vim.api.nvim_create_augroup("snacks_image_cleanup", { clear = true })

vim.api.nvim_create_autocmd("BufHidden", {
  group = img_group,
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "image" then
      vim.b[ev.buf]._image_was_hidden = true
      pcall(function()
        Snacks.image.placement.clean(ev.buf)
      end)
    end
  end,
})

-- Only re-attach if BufHidden previously cleaned this buffer. Skips the redundant
-- attach on first open (BufReadCmd already attached) and avoids flicker.
vim.api.nvim_create_autocmd("BufEnter", {
  group = img_group,
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "image" and vim.b[ev.buf]._image_was_hidden then
      vim.b[ev.buf]._image_was_hidden = false
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(ev.buf) then
          pcall(Snacks.image.buf.attach, ev.buf)
        end
      end)
    end
  end,
})

-- Some image render paths spuriously flip the buffer's 'modified' flag, so :q nags
-- the user about unsaved changes when they just wanted to view the file. Reset it
-- whenever it flips true; the guard prevents an infinite BufModifiedSet loop.
vim.api.nvim_create_autocmd("BufModifiedSet", {
  group = img_group,
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "image" and vim.bo[ev.buf].modified then
      vim.bo[ev.buf].modified = false
    end
  end,
})
