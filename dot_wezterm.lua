-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- This will hold the configuration
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font({ family = "Liga SFMono Nerd Font", weight = "Bold" })
config.font_size = 13.0

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false -- removes the + button
config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"

--  WINDOW DECORATION
config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "Liga SFMono Nerd Font", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 12.0,

	active_titlebar_bg = "#C6A0F6",
	inactive_titlebar_bg = "#181926",

	active_titlebar_fg = "#CAD3F5",
	inactive_titlebar_fg = "#6e738d",
}

local function truncate_with_ellipsis(text, max_width)
	if #text <= max_width then
		return text
	end

	if max_width <= 3 then
		return string.sub(text, 1, max_width)
	end

	return string.sub(text, 1, max_width - 5) .. "..."
end

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end

	if tab_info.active_pane and tab_info.active_pane.title then
		return tab_info.active_pane.title
	end

	return "Terminal"
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
	local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
	local CHEVRON_RIGHT = wezterm.nerdfonts.cod_chevron_right

	local active_tab_index = nil
	for _, t in ipairs(tabs) do
		if t.is_active then
			active_tab_index = t.tab_index
			break
		end
	end

	local title = tab_title(tab)
	title = truncate_with_ellipsis(title, max_width - 2)

	local is_active = tab.is_active
	local is_first = tab.tab_index == 0
	local is_last = tab.tab_index == (#tabs - 1)
	local is_immediately_left_of_active = active_tab_index ~= nil and tab.tab_index == active_tab_index - 1
	local is_immediately_right_of_active = active_tab_index ~= nil and tab.tab_index == active_tab_index + 1

	local tab_left_side_color = "#C6A0F6"
	local tab_left_side_background_color = "#1E2030"
	local background = "#1E2030"
	local foreground = "#CAD3F5"
	local tab_right_side_color = "#1E2030"
	local tab_right_side_background_color = "#1E2030"

	local left_divider = CHEVRON_RIGHT
	local right_divider = CHEVRON_RIGHT

	if is_active then
		tab_left_side_color = "#1E2030"
		tab_left_side_background_color = "#C6A0F6"
		left_divider = SOLID_LEFT_ARROW

		background = "#C6A0F6"
		foreground = "#181926"

		tab_right_side_color = "#C6A0F6"
		tab_right_side_background_color = "#1E2030"
		right_divider = SOLID_RIGHT_ARROW
	else
		-- Normal inactive tab
		tab_left_side_color = "#1E2030"
		tab_left_side_background_color = "#1E2030"

		left_divider = CHEVRON_RIGHT

		background = "#1E2030"
		foreground = "#CAD3F5"

		tab_right_side_color = "#C6A0F6"
		tab_right_side_background_color = "#1E2030"
		right_divider = CHEVRON_RIGHT

		if tab.tab_index == 1 then
			tab_left_side_color = "#C6A0F6"
			left_divider = CHEVRON_RIGHT
		end

		if is_immediately_left_of_active then
			tab_right_side_color = "#1E2030"
			tab_right_side_background_color = "#1E2030"
			left_divider = CHEVRON_RIGHT
		end
		-- Special case:
		-- this tab is immediately to the right of the active tab,
		-- so its LEFT edge should visually continue the active tab boundary
		if is_immediately_right_of_active then
			tab_left_side_background_color = "#1E2030"
			if tab.tab_index > 1 then
				tab_left_side_color = "#C6A0F6"
			end
			left_divider = ""
		end
		if is_first then
			right_divider = ""
		end
	end

	if is_first then
		tab_left_side_color = background
	end

	return {
		{ Background = { Color = tab_left_side_background_color } },
		{ Foreground = { Color = tab_left_side_color } },
		{ Text = left_divider },

		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },

		{ Background = { Color = tab_right_side_background_color } },
		{ Foreground = { Color = tab_right_side_color } },
		{ Text = right_divider },
	}
end)

config.colors = {
	tab_bar = {
		background = "#1E2030",
		active_tab = {
			bg_color = "#C6A0F6",
			fg_color = "#181926",
			intensity = "Half",
		},
		inactive_tab = {
			bg_color = "#1E2030",
			fg_color = "#CAD3F5",
			intensity = "Half",
		},
		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,
		},
		new_tab = {
			bg_color = "#808080",
			fg_color = "#C6A0F6",
		},
		new_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,
		},
	},
}

config.text_background_opacity = 1.0
config.window_background_opacity = 0.75

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Make task numbers clickable
-- The first matched regex group is captured in $1.
table.insert(config.hyperlink_rules, {
	regex = [[\b[tt](\d+)\b]],
	format = "https://example.com/tasks/?t=$1",
})

-- Make username/project paths clickable. This implies paths like the following are for GitHub.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
	format = "https://www.github.com/$1/$3",
})

config.keys = {
	{
		key = "l",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "j",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Left",
			size = { Percent = 50 },
		}),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Up",
			size = { Percent = 50 },
		}),
	},
}

local function split_tabs(raw)
	local tabs = {}
	if not raw or raw == "" then
		return tabs
	end

	for item in string.gmatch(raw, "([^|]+)") do
		table.insert(tabs, item)
	end

	return tabs
end

local function parse_tab(raw)
	if raw == "opencode" then
		return "OpenCode", { "/bin/zsh", "-lc", "opencode; exec zsh" }
	end

	if raw == "terminal" then
		return "Terminal", nil
	end

	local name, cmd = raw:match("^(.-)::(.*)$")
	if name and cmd then
		return name, { "/bin/zsh", "-lc", cmd .. "; exec zsh" }
	end

	return raw, nil
end

wezterm.on("gui-startup", function(cmd)
	local bootstrap = os.getenv("WEZTERM_WORKSPACE_BOOTSTRAP")
	if bootstrap ~= "1" then
		return
	end

	local workspace = os.getenv("WEZTERM_WORKSPACE_NAME")
	local cwd = os.getenv("WEZTERM_WORKSPACE_DIR")
	local tabs_raw = os.getenv("WEZTERM_WORKSPACE_TABS") or ""

	if not workspace or workspace == "" or not cwd or cwd == "" then
		return
	end

	-- If workspace already exists, just switch to it.
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			mux.set_active_workspace(workspace)
			local gui_window = window:gui_window()
			if gui_window then
				gui_window:focus()
			end
			return
		end
	end

	local tabs = split_tabs(tabs_raw)
	if #tabs == 0 then
		tabs = { "terminal" }
	end

	local first_name, first_args = parse_tab(tabs[1])

	local spawn_args = {
		workspace = workspace,
		cwd = cwd,
	}

	if first_args then
		spawn_args.args = first_args
	end

	local tab, pane, window = mux.spawn_window(spawn_args)
	tab:set_title(first_name)
	window:set_title(workspace)

	for i = 2, #tabs do
		local tab_name, tab_args = parse_tab(tabs[i])
		local new_tab

		if tab_args then
			new_tab = window:spawn_tab({
				cwd = cwd,
				args = tab_args,
			})
		else
			new_tab = window:spawn_tab({
				cwd = cwd,
			})
		end

		new_tab:set_title(tab_name)
	end

	mux.set_active_workspace(workspace)
	local gui_window = window:gui_window()
	if gui_window then
		gui_window:focus()
	end

	-- Focus specific tab if requested via environment variable
	local focus_tab = os.getenv("WEZTERM_FOCUS_TAB")
	if focus_tab then
		local tab_index = tonumber(focus_tab)
		if tab_index and tab_index >= 0 then
			local all_tabs = window:tabs()
			if all_tabs and all_tabs[tab_index + 1] then
				all_tabs[tab_index + 1]:activate()
			end
		end
	end
end)

return config
