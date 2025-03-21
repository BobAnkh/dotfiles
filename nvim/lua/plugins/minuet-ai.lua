-- return {}
local kind_icons = {
  -- LLM Provider icons
  claude = "󰋦",
  openai = "󱢆",
  codestral = "󱎥",
  gemini = "",
  Groq = "",
  Openrouter = "󱂇",
  Ollama = "󰳆",
  ["Llama.cpp"] = "󰳆",
  Deepseek = "",
}

return {
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        provider = "claude",
        blink = {
          enable_auto_complete = false,
        },
      })
      -- require("blink-cmp").setup({
      --   keymap = {
      --     -- Manually invoke minuet completion.
      --     ["<A-a>"] = require("minuet").make_blink_map(),
      --   },
      --   sources = {
      --     -- Enable minuet for autocomplete
      --     default = { "lsp", "path", "buffer", "snippets", "minuet" },
      --     -- For manual completion only, remove 'minuet' from default
      --     providers = {
      --       minuet = {
      --         name = "minuet",
      --         module = "minuet.blink",
      --         score_offset = 8, -- Gives minuet higher priority among suggestions
      --       },
      --     },
      --   },
      --   -- Recommended to avoid unnecessary request
      --   completion = { trigger = { prefetch_on_insert = false } },
      -- })
    end,
    keys = {
      {
        "<leader>am",
        "<cmd>Minuet blink toggle<CR>",
        desc = "Code Companion Chat",
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
        kind_icons = kind_icons,
      },
      keymap = {
        ["<A-y>"] = {
          function(cmp)
            cmp.show({ providers = { "minuet" } })
          end,
        },
      },
      sources = {
        -- if you want to use auto-complete
        default = { "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
