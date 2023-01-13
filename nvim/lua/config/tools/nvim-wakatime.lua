-- https://github.com/wakatime/vim-wakatime

local M = {
    requires = {
        "vim-wakatime",
    },
}

function M.before() end

function M.load()
    M.vim_wakatime.setup()
end

function M.after() end

return M
