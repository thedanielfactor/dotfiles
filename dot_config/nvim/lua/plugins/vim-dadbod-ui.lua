local prefix = "<leader>B"

local utils = require "astrocore"

return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function()
      utils.set_mappings {
        n = {
          [prefix .. "u"] = {
            "<cmd>DBUIToggle<cr>",
            desc = "Toggle DadBod UI",
          },
          [prefix .. "f"] = {
            "<cmd>DBUIFindBuffer<cr>",
            desc = "Find DadBod UI Buffer",
          },
          [prefix .. "r"] = {
            "<cmd>DBUIRenameBuffer<cr>",
            desc = "Rename DadBod UI Buffer",
          },
          [prefix .. "l"] = {
            "<cmd>DBUILastQueryInfo<cr>",
            desc = "Last Query",
          },
        },
      }
    end,
  },
}
