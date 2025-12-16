return {
  "benomahony/uv.nvim",
  ft = { "python" },
  dependencies = {
    "folke/snacks.nvim",
  },
  opts = {
    picker_integration = true,
  },
  config = function()
    require("uv").setup()
  end,
}
