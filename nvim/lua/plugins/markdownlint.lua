return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    },
    linters = {
      ['markdownlint-cli2'] = {
        args = {
          '--config',
          vim.fn.stdpath('config') .. '/lua/plugins/cfg_linters/.markdownlint-cli2.yaml',
          '--',
        },
      },
    },
  },
}
