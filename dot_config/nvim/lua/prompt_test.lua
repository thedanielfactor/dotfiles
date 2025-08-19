local M = {}

function M.open()
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set as prompt buffer BEFORE setting lines
  vim.api.nvim_set_option_value("buftype", "prompt", { buf = buf })
  vim.fn.prompt_setprompt(buf, "Search: ")
  vim.fn.prompt_setcallback(buf, function(text) vim.notify("You typed: " .. text) end)

  -- Must add a line AFTER setting buftype/prompt
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "" })

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = 40,
    height = 1,
    row = 10,
    col = 10,
    style = "minimal",
    border = "rounded",
  })

  -- Force focus and startinsert
  vim.api.nvim_set_current_win(win)
  vim.api.nvim_set_current_buf(buf)
  vim.cmd "startinsert"
end

return M
