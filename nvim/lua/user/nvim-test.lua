local status_ok, nvimTest = pcall(require, "nvim-test")
if not status_ok then
  return
end

nvimTest.setup {
  commands_create = true,   -- create commands (TestFile, TestLast, ...)
  silent = false,           -- less notifications
  run = true,               -- run test commands
  term = "terminal",        -- a terminal to run (terminal|toggleterm)
  filename_modifier = ":.",  -- modify filename before tests run (:h filename-modifiers)
  termOpts = {
    direction = "vertical", -- terminal's direction (horizontal|vertical|float)
    width = 96,             -- terminal's width (for vertical|float)
    height = 24,            -- terminal's height (for horizontal|float)
    go_back = false,        -- return focus to original window after executing
    stopinsert = "auto",    -- exit from insert mode (true|false|"auto")
    keep_one = true,        -- only for term 'terminal', use only one buffer for testing
  },
  runners = {               -- setup tests runners
    go = "nvim-test.runners.go-test",
    javascript = "nvim-test.runners.jest",
    lua = "nvim-test.runners.busted",
    python = "nvim-test.runners.pytest",
    rust = "nvim-test.runners.cargo-test",
    typescript = "nvim-test.runners.ts-mocha",
  }
}

local status_ok, nvimTestMocha = pcall(require, "nvim-test.runners.mocha")
if not status_ok then
  return
end

nvimTestMocha:setup {
    command = "~/node_modules/.bin/mocha", -- a command to run the test runner
    args = { "--timeout 10000 -r ts-node/register -r tsconfig-paths/register -r ts-node/esm -r test/beforeAll.ts" }, -- default arguments
    filename_modifier = nil,              -- modify filename before tests run (:h filename-modifiers)
  }
