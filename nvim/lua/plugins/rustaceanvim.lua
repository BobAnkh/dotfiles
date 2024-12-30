return {
  "mrcjkb/rustaceanvim",
  opts = function(_, opts)
    opts.server.default_settings["rust-analyzer"]["cargo"]["allFeatures"] = nil
  end,
}
