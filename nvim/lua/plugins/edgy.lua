return {
  {
    "folke/edgy.nvim",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local left = opts["left"]
      -- function dump(o)
      --   if type(o) == "table" then
      --     local s = "{ "
      --     for k, v in pairs(o) do
      --       if type(k) ~= "number" then
      --         k = '"' .. k .. '"'
      --       end
      --       s = s .. "[" .. k .. "] = " .. dump(v) .. ","
      --     end
      --     return s .. "} "
      --   else
      --     return tostring(o)
      --   end
      -- end
      for _, v in pairs(left) do
        if v["ft"] == "neo-tree" then
          -- delete first 6 characters
          v["title"] = v["title"]:sub(9)
          -- print(dump(v["title"]))
        end
      end
      table.insert(opts, { wo = { winhighlight = "" } })
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = {
        "NeoTreeNormal",
        "NeoTreeNormalNC",
      },
    },
    config = function()
      require("transparent").clear_prefix("BufferLine")
      require("transparent").clear_prefix("lualine")
    end,
    keys = {
      {
        "<leader>ut",
        function()
          require("transparent").toggle()
          require("incline").enable()
        end,
        desc = "Toggle Transparency",
      },
    },
  },
}
