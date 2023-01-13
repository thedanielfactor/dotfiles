-- https://github.com/KadoB/nvim-spotify

local api = require("utils.api")

local M = {
    requires = {
        "nvim-spotify",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.setup()
end

function M.after() end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>sp",
            rhs = "<Plug>(SpotifyPause)",
            options = { silent = true },
            description = "Spotify Play / Pause",
        },
        {
            mode = { "n" },
            lhs = "<leader>sj",
            rhs = "<Plug>(SpotifySkip)",
            options = { silent = true },
            description = "Spotify Go Next",
        },
        {
            mode = { "n" },
            lhs = "<leader>sk",
            rhs = "<Plug>(SpotifyPrev)",
            options = { silent = true },
            description = "Spotify Go Previous",
        },
        {
            mode = { "n" },
            lhs = "<leader>sf",
            rhs = "<Plug>(SpotifyShuffle)",
            options = { silent = true },
            description = "Spotify Show",
        },
        {
            mode = { "n" },
            lhs = "<leader>sv",
            rhs = "<Plug>(SpotifySave)",
            options = { silent = true },
            description = "Spotify Save to Library",
        },
        {
            mode = { "n" },
            lhs = "<leader>sh",
            rhs = ":Spotify<CR>",
            options = { silent = true },
            description = "Spotify Search",
        },
        {
            mode = { "n" },
            lhs = "<leader>sd",
            rhs = ":SpotifyDevices<CR>",
            options = { silent = true },
            description = "Spotify Devices",
        },
    })
end

return M
