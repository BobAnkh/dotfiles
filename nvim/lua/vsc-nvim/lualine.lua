local com_sep = { left = " ", right = " " }
local sec_sep = { left = " ", right = " " }
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.component_separators = com_sep
      opts.options.section_separators = sec_sep
      opts.sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {},
      }
    end,
  },
}
