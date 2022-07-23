local path = require("utils.api.path")

local options = {
    -- Auto save Buffer
    auto_save_buffer = true,
    -- Automatically switch input method, currently only for Linux and Fcitx5
    auto_switch_input = true,
    --  Icon style to use
    -- • vscode (requires condicon.ttf installed)
    -- • kind (default)options.
    icons_style = "kind",
    -- theme style to use
    -- • catppuccin
    -- • vscode
    -- • github-theme
    colorscheme = "catppuccin",
    -- Whether the background is transparent
    -- • boolean
    transparent_background = false,
    -- lint configuration file
    -- • string
    nvim_lint_dir = path.join(vim.fn.stdpath("config"), "lint"),
    -- Code snippet storage directory
    -- • string
    code_snippets_directory = path.join(vim.fn.stdpath("config"), "snippets"),
}

-- database link configuration
options.database_config = {
    {
        name = "ods_dev",
        url = "postgresql://usr_raymondd@db-ods.dev.edgeapps.net:5432/ods_dev"
    },
    {
        name = "ods_test",
        url = "postgresql://usr_raymondd@db-ods.dev.edgeapps.net:5432/ods_test"
    },
    {
        name = "ods_stage",
        url = "postgresql://usr_raymondd@db-ods.stage.edgeapps.net:5432/ods_stage"
    },
    {
        name = "ods_prod",
        url = "postgresql://usr_raymondd@db-ods2.prod.edgeapps.net:5432/ods_prod"
    }
}

return options
