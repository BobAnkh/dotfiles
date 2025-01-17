return {
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    keys = {

      {
        "gVd",
        "<cmd>lua require().goto_preview_definition()<CR>",
        mode = "n",
        desc = "Preview Definition",
        noremap = true,
      },

      {
        "gVy",
        "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
        mode = "n",
        desc = "Preview T[y]pe Definition",
        noremap = true,
      },

      {
        "gVI",
        "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
        mode = "n",
        desc = "Preview Implementation",
        noremap = true,
      },

      {
        "gVD",
        "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
        mode = "n",
        desc = "Preview Declaration",
        noremap = true,
      },

      {
        "gVq",
        "<cmd>lua require('goto-preview').close_all_win()<CR>",
        mode = "n",
        desc = "Close All Preview Windows",
        noremap = true,
      },

      {
        "gVr",
        "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
        mode = "n",
        desc = "Preview References",
        noremap = true,
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "gV", group = "pre[V]iew" },
      },
    },
  },
}
