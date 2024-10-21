-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.highlight = {
      enable = true,
      disable = { "csv" }, -- list of languages to disable
    }
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "vim",
      "html",
      -- add more arguments for adding more treesitter parsers
    })
  end,
}
