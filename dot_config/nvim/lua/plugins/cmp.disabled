return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "jc-doyle/cmp-pandoc-references",
    "kdheepak/cmp-latex-symbols",
    "chrisgrieser/cmp-nerdfont",
    "hrsh7th/cmp-cmdline",
    "tamago324/cmp-zsh",
    "petertriho/cmp-git",
    "David-Kunz/cmp-npm",
    "rcarriga/cmp-dap",
    --    "codota/tabnine-nvim",
    -- codeium
    {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      build = ":Codeium Auth",
      opts = {},
    },
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    local compare = require "cmp.config.compare"
    local luasnip = require "luasnip"

    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    return require("astrocore").extend_tbl(opts, {
      window = { completion = { col_offset = -1, side_padding = 0 } },
      sources = cmp.config.sources {
        {
          name = "codeium",
          group_index = 1,
          priority = 100,
        },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "pandoc_references", priority = 725 },
        { name = "omni", priority = 800 },
        -- { name = "tabnine-nvim", priority = 773 },
        { name = "luasnip", priority = 750 },
        { name = "vim-dadbod-completion", priority = 700 },
        { name = "emoji", priority = 700 },
        { name = "latex_symbols", priority = 700 },
        { name = "calc", priority = 650 },
        { name = "path", priority = 500 },
        { name = "fish", priority = 300 },
        { name = "zsh", priority = 300 },
        { name = "npm", priority = 300 },
        { name = "git", priority = 300 },
        { name = "buffer", priority = 250 },
        { name = "nerdfont", priority = 200 },
        { name = "cmdline", priority = 200 },
      },
      sorting = {
        comparators = {
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find "^_+"
            local _, entry2_under = entry2.completion_item.label:find "^_+"
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
      mapping = {
        -- tab complete
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.confirm { select = true }
          else
            fallback()
          end
        end, { "i", "s" }),
        -- <C-n> and <C-p> for navigating snippets
        ["<C-n>"] = cmp.mapping(function()
          if luasnip.jumpable(1) then luasnip.jump(1) end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function()
          if luasnip.jumpable(-1) then luasnip.jump(-1) end
        end, { "i", "s" }),
        -- <C-j> for starting completion
        ["<C-j>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
          else
            cmp.complete()
          end
        end, { "i", "s" }),
      },
    })
  end,
  {
    "mtoohey31/cmp-fish",
    dependencies = { "hrsh7th/nvim-cmp" },
    -- config = function()
    -- 	-- Add bindings which show up as group name
    -- 	local cmp = require("cmp")
    -- 	local config = cmp.get_config()
    -- 	table.insert(config.sources, {
    -- 		{ name = "fish" },
    -- 	})
    -- 	cmp.setup(config)
    -- end,
    ft = "fish",
  },
  {
    "tamago324/cmp-zsh",
    dependencies = { "hrsh7th/nvim-cmp" },
    -- config = function()
    -- 	-- Add bindings which show up as group name
    -- 	local cmp = require("cmp")
    -- 	local config = cmp.get_config()
    -- 	table.insert(config.sources, {
    -- 		{ name = "zsh" },
    -- 	})
    -- 	cmp.setup(config)
    -- end,
    ft = "zsh",
  },
  {
    "petertriho/cmp-git",
    dependencies = { "hrsh7th/nvim-cmp" },
    -- config = function()
    -- 	-- Add bindings which show up as group name
    -- 	local cmp = require("cmp")
    -- 	local config = cmp.get_config()
    -- 	table.insert(config.sources, {
    -- 		{ name = "git" },
    -- 	})
    -- 	cmp.setup(config)
    -- end,
    ft = "gitcommit",
  },
  {
    "David-Kunz/cmp-npm",
    dependencies = { "hrsh7th/nvim-cmp", "nvim-lua/plenary.nvim" },
    -- config = function()
    -- 	-- Add bindings which show up as group name
    -- 	require("cmp-npm").setup({})
    -- 	local cmp = require("cmp")
    -- 	local config = cmp.get_config()
    -- 	table.insert(config.sources, {
    -- 		{ name = "npm", keyword_length = 4 },
    -- 	})
    -- 	cmp.setup(config)
    -- end,
    ft = "json",
  },
}
