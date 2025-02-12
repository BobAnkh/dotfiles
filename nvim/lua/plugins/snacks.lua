local excluded = {
  "node_modules",
  "dist",
  ".git",
  "build",
  "target",
}

return {
  "snacks.nvim",
  keys = {
    {
      "<leader>qh",
      function()
        Snacks.dashboard()
      end,
      desc = "Go Back to Homepage",
    },
  },
  opts = {
    picker = {
      sources = {
        explorer = {
          -- show hidden files like .env
          hidden = true,
          -- show files ignored by git like node_modules
          ignored = true,
          follow = true,
          exclude = excluded,
          -- layout = {
          --   auto_hide = { "input" },
          -- },
        },
        files = {
          -- show hidden files like .env
          hidden = true,
          -- show files ignored by git like node_modules
          ignored = true,
          follow = true,
          exclude = excluded,
        },
      },
    },
  },
}
