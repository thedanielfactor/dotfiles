return {
  -- {
  --   "tamton-aquib/zone.nvim",
  --   config = function()
  --     require("zone").setup {
  --       style = "treadmill",
  --       after = 60, -- Idle timeout
  --       exclude_filetypes = { "TelescopePrompt", "NvimTree", "neo-tree", "dashboard", "lazy" },
  --       -- More options to come later
  --
  --       treadmill = {
  --         direction = "left",
  --         headache = true,
  --         tick_time = 30, -- Lower, the faster
  --         -- Opts for Treadmill style
  --       },
  --       epilepsy = {
  --         stage = "aura", -- "aura" or "ictal"
  --         tick_time = 100,
  --       },
  --       dvd = {
  --         -- text = {"line1", "line2", "line3", "etc"}
  --         tick_time = 100,
  --         -- Opts for Dvd style
  --       },
  --     }
  --     -- etc
  --   end,
  -- },
  {
    "folke/drop.nvim",
    opts = {
      ---@type DropTheme|string
      theme = "auto", -- when auto, it will choose a theme based on the date
      ---@type ({theme: string}|DropDate|{from:DropDate, to:DropDate}|{holiday:"us_thanksgiving"|"easter"})[]
      themes = {
        { theme = "new_year", month = 1, day = 1 },
        { theme = "valentines_day", month = 2, day = 14 },
        { theme = "st_patricks_day", month = 3, day = 17 },
        { theme = "easter", holiday = "easter" },
        { theme = "april_fools", month = 4, day = 1 },
        { theme = "us_independence_day", month = 7, day = 4 },
        { theme = "halloween", month = 10, day = 31 },
        { theme = "us_thanksgiving", holiday = "us_thanksgiving" },
        { theme = "xmas", from = { month = 12, day = 24 }, to = { month = 12, day = 25 } },
        { theme = "leaves", from = { month = 9, day = 22 }, to = { month = 12, day = 20 } },
        { theme = "snow", from = { month = 12, day = 21 }, to = { month = 3, day = 19 } },
        { theme = "spring", from = { month = 3, day = 20 }, to = { month = 6, day = 20 } },
        { theme = "summer", from = { month = 6, day = 21 }, to = { month = 9, day = 21 } },
      },
      max = 75, -- maximum number of drops on the screen
      interval = 100, -- every 150ms we update the drops
      screensaver = 1000 * 60, -- show after 5 minutes. Set to false, to disable
      filetypes = { "dashboard", "alpha", "ministarter" }, -- will enable/disable automatically for the following filetypes
      winblend = 100, -- winblend for the drop window
    },
  },
  {
    "eandrju/cellular-automaton.nvim",
    config = function()
      require("cellular-automaton").setup {
        vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>"),
      }
    end,
  },
}