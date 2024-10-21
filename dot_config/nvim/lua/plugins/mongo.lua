return {
  {
    "donus3/mongo.nvim",
    dependencies = {
      "ibhagwan/fzf-lua",
    },
    config = function() require("mongo").setup() end,
  },
}
