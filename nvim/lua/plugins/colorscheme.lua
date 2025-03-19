return {
  -- Theme: hardhacker
  -- {
  --   "hardhackerlabs/theme-vim",
  --   name = "hardhacker",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.hardhacker_hide_tilde = 1
  --     vim.g.hardhacker_keyword_italic = 1
  --     -- custom highlights
  --     vim.g.hardhacker_custom_highlights = {
  --       [[hi NonText guifg=#abb2bf]],
  --     }
  --     -- vim.cmd("colorscheme hardhacker")
  --   end,
  -- },
  -- Theme: kanagawa
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = vim.g.transparent_enabled, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
        -- Add this temporarily to wait for the PR #268 to merge
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- SnacksDashboard
            SnacksDashboardHeader = { fg = theme.vcs.removed },
            SnacksDashboardFooter = { fg = theme.syn.comment },
            SnacksDashboardDesc = { fg = theme.syn.identifier },
            SnacksDashboardIcon = { fg = theme.ui.special },
            SnacksDashboardKey = { fg = theme.syn.special1 },
            SnacksDashboardSpecial = { fg = theme.syn.comment },
            SnacksDashboardDir = { fg = theme.syn.identifier },
            -- SnacksNotifier
            SnacksNotifierBorderError = { link = "DiagnosticError" },
            SnacksNotifierBorderWarn = { link = "DiagnosticWarn" },
            SnacksNotifierBorderInfo = { link = "DiagnosticInfo" },
            SnacksNotifierBorderDebug = { link = "Debug" },
            SnacksNotifierBorderTrace = { link = "Comment" },
            SnacksNotifierIconError = { link = "DiagnosticError" },
            SnacksNotifierIconWarn = { link = "DiagnosticWarn" },
            SnacksNotifierIconInfo = { link = "DiagnosticInfo" },
            SnacksNotifierIconDebug = { link = "Debug" },
            SnacksNotifierIconTrace = { link = "Comment" },
            SnacksNotifierTitleError = { link = "DiagnosticError" },
            SnacksNotifierTitleWarn = { link = "DiagnosticWarn" },
            SnacksNotifierTitleInfo = { link = "DiagnosticInfo" },
            SnacksNotifierTitleDebug = { link = "Debug" },
            SnacksNotifierTitleTrace = { link = "Comment" },
            SnacksNotifierError = { link = "DiagnosticError" },
            SnacksNotifierWarn = { link = "DiagnosticWarn" },
            SnacksNotifierInfo = { link = "DiagnosticInfo" },
            SnacksNotifierDebug = { link = "Debug" },
            SnacksNotifierTrace = { link = "Comment" },
            -- SnacksProfiler
            SnacksProfilerIconInfo = { bg = theme.ui.bg_search, fg = theme.syn.fun },
            SnacksProfilerBadgeInfo = { bg = theme.ui.bg_visual, fg = theme.syn.fun },
            SnacksScratchKey = { link = "SnacksProfilerIconInfo" },
            SnacksScratchDesc = { link = "SnacksProfilerBadgeInfo" },
            SnacksProfilerIconTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
            SnacksProfilerBadgeTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
            SnacksIndent = { fg = theme.ui.bg_p2, nocombine = true },
            SnacksIndentScope = { fg = theme.ui.pmenu.bg, nocombine = true },
            SnacksZenIcon = { fg = theme.syn.statement },
            SnacksInputIcon = { fg = theme.ui.pmenu.bg },
            SnacksInputBorder = { fg = theme.syn.identifier },
            SnacksInputTitle = { fg = theme.syn.identifier },
            -- SnacksPicker
            SnacksPickerInputBorder = { fg = theme.syn.constant },
            SnacksPickerInputTitle = { fg = theme.syn.constant },
            SnacksPickerBoxTitle = { fg = theme.syn.constant },
            SnacksPickerSelected = { fg = theme.syn.number },
            SnacksPickerToggle = { link = "SnacksProfilerBadgeInfo" },
            SnacksPickerPickWinCurrent = { fg = theme.ui.fg, bg = theme.syn.number, bold = true },
            SnacksPickerPickWin = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
          }
        end,
      })
      vim.cmd("colorscheme kanagawa-wave")
    end,
  },
  -- Theme: tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "storm", transparent = vim.g.transparent_enabled },
  },
}
