return {
  "nvim-neorg/neorg",
  lazy = false,
  build = ":Neorg sync-parsers",
  version = "*",
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              ae = "~/notes/ae",
              bd = "~/notes/bd",
              mynotes = "~/notes/my",
            },
            default_workspace = "mynotes",
          },
        },
      },
    }
  end,
}
