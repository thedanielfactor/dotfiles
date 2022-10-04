-- https://github.com/Vonr/align.nvim
local api = require("utils.api")

local M = {
    requires = {
        "align",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.algin.setup()
end

function M.after() end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "x" },
            lhs = "aa",
            rhs = function()
                require("align").align_to_char(1, true)
            end,
            options = { noremap = true, silent = true },
            description = "Align paragraph to 1 character, looking left, no preview",
        },
        -- {
        --     mode = { "x" },
        --     lhs = "as",
        --     rhs = function()
        --         require("align").align_to_char(2, true, true)
        --     end,
        --     options = { noremap = true, silent = true },
        --     description = "Align paragraph to 2 character, looking left, with preview",
        -- },
        -- {
        --     mode = { "x" },
        --     lhs = "aw",
        --     rhs = function()
        --         require("align").align_to_string(false, true, true)
        --     end,
        --     options = { noremap = true, silent = true },
        --     description = "Align paragraph to string, looking left, with preview",
        -- },
        -- {
        --     mode = { "x" },
        --     lhs = "ar",
        --     rhs = function()
        --         require("align").align_to_string(true, true, true)
        --     end,
        --     options = { noremap = true, silent = true },
        --     description = "Align paragraph to string, with pattern, looking left, with preview",
        -- },
        -- {
        --     mode = { "n" },
        --     lhs = "gaw",
        --     rhs = function()
        --         require("align").align_to_string(false, true, true)
        --     end,
        --     options = { noremap = true, silent = true },
        --     description = "Align paragraph to string, looking left, with previews",
        -- },
        {
            mode = { "n" },
            lhs = "gaa",
            rhs = function()
                    local a = require'align'

                    a.operator(
                        a.align_to_string,
                        { is_pattern = false, reverse = true, preview = true }
                    )
                  end,
            options = { noremap = true, silent = true },
            description = "Align a paragraph to 1 character, looking left",
        },
    })
end

return M
