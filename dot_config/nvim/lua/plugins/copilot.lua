return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    config = function()
      require("copilot").setup {
        -- panel = {
        --   enabled = false,
        --   auto_refresh = false,
        --   keymap = {
        --     jump_prev = "[[",
        --     jump_next = "]]",
        --     accept = "<CR>",
        --     refresh = "gr",
        --     open = "<M-CR>",
        --   },
        --   layout = {
        --     position = "bottom", -- | top | left | right | horizontal | vertical
        --     ratio = 0.4,
        --   },
        -- },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = false,
          debounce = 75,
          trigger_on_accept = true,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<esc>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
        copilot_node_command = "node", -- Node.js version must be > 20
        copilot_model = "gpt-4o-copilot", -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
        root_dir = function() return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1]) end,
        server = {
          type = "nodejs", -- "nodejs" | "binary"
          custom_server_filepath = nil,
        },
        server_opts_overrides = {},
      }
    end,
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              -- set the ai_accept function
              ai_accept = function()
                if require("copilot.suggestion").is_visible() then
                  require("copilot.suggestion").accept()
                  return true
                end
              end,
            },
          },
        },
      },
    },
  },
  {
    "giuxtaposition/blink-cmp-copilot",
    after = { "copilot.lua" },
  },
}
