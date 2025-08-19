local M = {}

local items = {
  "apple",
  "banana",
  "carrot",
  "date",
  "eggplant",
  "fig",
  "grapefruit",
  "honeydew",
  "iceberg lettuce",
}

function M.open()
  local ns = vim.api.nvim_create_namespace "mini-finder"

  local function create_floating_buf(height, row)
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.5)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded",
    })

    return buf, win
  end

  local input_buf, input_win = create_floating_buf(1, 5)
  local results_buf, results_win = create_floating_buf(10, 8)

  vim.api.nvim_set_option_value("buftype", "prompt", { buf = input_buf })
  vim.fn.prompt_setprompt(input_buf, "Find: ")
  vim.api.nvim_buf_set_lines(input_buf, 0, -1, false, { "" })

  M._state = {
    input_buf = input_buf,
    input_win = input_win,
    results_buf = results_buf,
    results_win = results_win,
    selected_index = 1,
    current_items = {},
    ns = ns,
  }

  local function render_results()
    local lines = {}
    for i, item in ipairs(M._state.current_items) do
      if i == M._state.selected_index then
        table.insert(lines, "> " .. item)
      else
        table.insert(lines, "  " .. item)
      end
    end

    vim.api.nvim_set_option_value("modifiable", true, { buf = M._state.results_buf })
    vim.api.nvim_buf_set_lines(M._state.results_buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value("modifiable", false, { buf = M._state.results_buf })
  end

  local function update_results(query)
    local filtered = {}
    for _, item in ipairs(items) do
      if query == "" or item:sub(1, #query):lower() == query:lower() then table.insert(filtered, item) end
    end

    for key, value in pairs(filtered) do
      vim.notify("Filtered for " .. query .. " : " .. key .. " : " .. value)
    end

    if not M._state then return end

    M._state.current_items = filtered
    M._state.selected_index = 1
    render_results()
  end

  local function move_selection(delta)
    local state = M._state
    local count = #state.current_items
    if count == 0 then return end

    state.selected_index = state.selected_index + delta
    if state.selected_index < 1 then state.selected_index = count end
    if state.selected_index > count then state.selected_index = 1 end

    render_results()
  end

  -- Set keymaps
  vim.keymap.set("i", "<Esc>", function() M.close() end, { buffer = input_buf })
  vim.keymap.set("i", "<Down>", function() move_selection(1) end, { buffer = input_buf })
  vim.keymap.set("i", "<Up>", function() move_selection(-1) end, { buffer = input_buf })
  vim.keymap.set("i", "<CR>", function()
    local item = M._state.current_items[M._state.selected_index]
    M.close()
    vim.notify("You selected: " .. item)
  end, { buffer = input_buf })

  -- Focus prompt buffer
  vim.api.nvim_set_current_win(input_win)
  vim.api.nvim_set_current_buf(input_buf)
  vim.cmd "startinsert"

  -- Defer initial result render
  vim.defer_fn(function() update_results "" end, 50)

  -- Key listener: defer update until buffer has caught up

  vim.on_key(function()
    vim.defer_fn(function()
      if not vim.api.nvim_buf_is_valid(M._state.input_buf) then return end
      local line = vim.api.nvim_buf_get_lines(M._state.input_buf, 0, 1, false)[1] or ""
      update_results(line)
    end, 20) -- Delay of 20 milliseconds
  end, vim.api.nvim_create_namespace "mini-finder")
end

function M.close()
  if M._state then
    pcall(vim.api.nvim_win_close, M._state.input_win, true)
    pcall(vim.api.nvim_win_close, M._state.results_win, true)
    vim.on_key(nil, M._state.ns)
    M._state = nil
  end
end

return M
