local api = require("utils.api")

local options = {}

options.transparent = false
options.float_border = true
options.show_winbar = true

options.download_source = "https://github.com/"

options.lint_directory = api.path.join(vim.fn.stdpath("config"), "lint")
options.snippets_directory = api.path.join(vim.fn.stdpath("config"), "snippets")

-- auto command manager
options.auto_save = true
options.auto_switch_input = true
options.auto_restore_cursor_position = true
options.auto_remove_new_lines_comment = true

options.database_connect = {
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
    },
}

return options
