return {
  "abidibo/nvim-httpyac",
  lazy = false,
  config = function ()
    require('nvim-httpyac').setup()
    -- if you want to set up the keymaps
    vim.keymap.set('n', '<Leader>rr', '<cmd>:NvimHttpYac<CR>', { desc='Run request'})
    vim.keymap.set('n', '<Leader>ra', '<cmd>:NvimHttpYacAll<CR>', { desc='Run all requests'})
  end
}
