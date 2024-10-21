return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup {
      api_key_cmd = "op read op://private/OpenAI/credential --no-newline",
      predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/thedanielfactor/awesome-chatgpt-prompts/main/prompts.csv",
    }
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
