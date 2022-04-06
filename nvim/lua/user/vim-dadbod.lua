local au = require('user.au')

local status_ok, dadbod = pcall(require, "vim-dadbod-completeion")
if not status_ok then
  return
end

au.BufEnter = {
    '*.*.sql',
    function()
        if vim.bo.buftype == 'help' then
            au.cmd('wincmd L')
            local nr = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_keymap(nr, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
        end
    end,
}
