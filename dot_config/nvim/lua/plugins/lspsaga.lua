local prefix = "<leader>l"

return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = "LspAttach",
  config = function() require("lspsaga").setup {} end,
  keys = {
    {
      prefix .. "p",
      "<cmd>Lspsaga peek_type_definition<CR>",
      desc = "Peek Type Definition under cursor",
      mode = { "n" },
    },
  },
}
