-- return {
--   "saghen/blink.cmp",
--   opts = function(_, opts)
--     -- TODO: wair for this PR to be merged to set: https://github.com/LazyVim/LazyVim/pull/6183
--     opts.keymap.preset = "super-tab"
--     opts.completion.ghost_text.show_with_menu = false
--   end,
-- }
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<Tab>"] = {
        require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
        require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
    },
    completion = {
      ghost_text = {
        show_with_menu = false,
      },
    },
  },
}
