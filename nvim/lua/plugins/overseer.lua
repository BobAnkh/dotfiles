return {
  "stevearc/overseer.nvim",
  opts = function(_, opts)
    require("overseer").load_template("custom.cargo")
  end,
}
