return {
  "akinsho/git-conflict.nvim",
  version = "*",
  opts = {
    default_mappings = {
      ours = "<leader>go",
      theirs = "<leader>gt",
      none = "<leader>gn",
      both = "<leader>gb",
      next = "]x",
      prev = "[x",
    },
  },
  keys = {
    {
      "<leader>gx",
      "<cmd>GitConflictListQf<cr>",
      desc = "List Conflicts",
    },
    {
      "<leader>gr",
      "<cmd>GitConflictRefresh<cr>",
      desc = "Refresh Conflicts",
    },
  },
}
