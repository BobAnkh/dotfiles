local excluded = {
  ".vagrant",
  "node_modules",
  "dist",
  ".git",
  "build",
  "target",
  ".venv",
  ".ruff_cache",
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
      previewers = {
        diff = {
          builtin = false, -- use Neovim for previewing diffs (true) or use an external tool (false)
          cmd = { "delta" }, -- example to show a diff with delta
        },
      },
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
