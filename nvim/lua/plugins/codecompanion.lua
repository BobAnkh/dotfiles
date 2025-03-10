return {
  {
    "olimorris/codecompanion.nvim",
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
            slash_commands = {
              ["buffer"] = { opts = { provider = LazyVim.pick.picker.name } },
              ["file"] = { opts = { provider = LazyVim.pick.picker.name } },
            },
          },
          inline = {
            adapter = "anthropic",
          },
        },
      })
      vim.cmd([[cab cc CodeCompanion]])
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "saghen/blink.cmp",
    },
    keys = {
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<CR>",
        desc = "Code Companion Chat",
      },
      {
        "<leader>ai",
        "<cmd>CodeCompanion<CR>",
        desc = "Code Companion Inline",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "CodeCompanion" },
      },
    },
  },
}
