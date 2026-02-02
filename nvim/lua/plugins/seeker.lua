return {
  "2kabhishek/seeker.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "Seeker" },
  keys = {
    { "<leader>fa", ":Seeker files<CR>", desc = "Seek Files" },
    { "<leader>ff", ":Seeker git_files<CR>", desc = "Seek Git Files" },
    { "<leader>fg", ":Seeker grep<CR>", desc = "Seek Grep" },
  },
  opts = {}, -- Required unless you call seeker.setup() manually, add your configs here
}
