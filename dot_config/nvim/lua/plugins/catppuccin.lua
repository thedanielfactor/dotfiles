return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function() require("catppuccin").setup() end,
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      dim_inactive = { enabled = true, percentage = 0.25 },
      integration_default = false,
      transparent_background = true, -- disables setting the background color.
      integrations = {
        alpha = false,
        aerial = true,
        barbecue = false,
        cmp = true,
        dap = { enabled = true, enable_ui = true },
        dashboard = true,
        dropbar = false,
        flash = false,
        headlines = true,
        indent_blankline = false,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = false,
          },
        },
        navic = false,
        neogit = true,
        neotree = true,
        noice = true,
        notify = true,
        nvimtree = true,
        sandwich = true,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = { enabled = true, style = "nvchad" },
        ts_rainbow = false,
        ts_rainbow2 = false,
        which_key = true,
      },
      custom_highlights = {
        -- disable italics  for treesitter highlights
        TabLineFill = { link = "StatusLine" },
        LspInlayHint = { style = { "italic" } },
        ["@parameter"] = { style = {} },
        ["@type.builtin"] = { style = {} },
        ["@namespace"] = { style = {} },
        ["@text.uri"] = { style = { "underline" } },
        ["@tag.attribute"] = { style = {} },
        ["@tag.attribute.tsx"] = { style = {} },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
}
