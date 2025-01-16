local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local Keys = {}
-- you can put the rest of your Wezterm config here

local function get_default_program()
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		-- Windows-specific program (starting WSL)
		return {"pwsh.exe"}
	elseif wezterm.target_triple:find("linux") then
		-- Linux-specific program
		return { "/home/linuxbrew/.linuxbrew/bin/nu" }
	else
		return { "/opt/homebrew/bin/nu" }
	end
end
local function get_default_domain()
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		-- Windows-specific program (starting WSL)
		return 'WSL:Ubuntu'
	elseif wezterm.target_triple:find("linux") then
		-- Linux-specific program
		return  "local" 
	else
		return  "local" 
	end
end
local function get_default_font()
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		-- Windows-specific program (starting WSL)
		return 10.5
	elseif wezterm.target_triple:find("linux") then
		return 10.0
	else
		return 14.0
	end
end
local nord = {
	nord0 = '#2E3440',    -- Dark gray (background)
	nord1 = '#3B4252',    -- Darker gray
	nord2 = '#434C5E',    -- Dark grayish blue
	nord3 = '#4C566A',    -- Gray blue
	nord4 = '#D8DEE9',    -- Light gray
	nord5 = '#E5E9F0',    -- Lighter gray
	nord6 = '#ECEFF4',    -- Almost white
	nord7 = '#8FBCBB',    -- Cyan
	nord8 = '#88C0D0',    -- Light blue
	nord9 = '#81A1C1',    -- Blue
	nord10 = '#5E81AC',   -- Dark blue
}

local everforest = {
    everforest0 = '#2B3339',  -- Dark gray (background)
    everforest1 = '#323C41',  -- Darker gray
    everforest2 = '#3A454A',  -- Medium gray
    everforest3 = '#445055',  -- Gray
    everforest4 = '#D3C6AA',  -- Light warm gray
    everforest5 = '#E9E8D2',  -- Lighter warm gray
    everforest6 = '#FDF6E3',  -- Almost white
    everforest7 = '#7FBBB3',  -- Sage green
    everforest8 = '#83C092',  -- Forest green
    everforest9 = '#A7C080',  -- Light green
    everforest10 = '#859289', -- Muted green
}
config = {
	automatically_reload_config = true,
	enable_tab_bar = true,
	default_domain = get_default_domain(),
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	force_reverse_video_cursor = true,
	font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
	default_prog = get_default_program(),
	font_size = get_default_font(),
	color_scheme = "Everforest Dark (Gogh)",
	front_end="WebGpu",
	max_fps = 144,
	use_fancy_tab_bar = false,
	tab_max_width=250,
	inactive_pane_hsb = {
		saturation = 1,
		brightness = 1,
	},
	colors = {
		tab_bar = {
			background = everforest.everforest0,

			active_tab = {
				bg_color = everforest.everforest8,
				fg_color = everforest.everforest0,
				intensity = 'Normal',
			},

			inactive_tab = {
				bg_color = everforest.everforest2,
				fg_color = everforest.everforest4,
			},

			inactive_tab_hover = {
				bg_color = everforest.everforest3,
				fg_color = everforest.everforest6,
			},

			new_tab = {
				bg_color = everforest.everforest1,
				fg_color = everforest.everforest4,
			},

			new_tab_hover = {
				bg_color = everforest.everforest3,
				fg_color = everforest.everforest6,
			},
		},
	}
}
function Keys.setup(config)
	smart_splits.apply_to_config(config, {
		-- the default config is here, if you'd like to use the default keys,
		-- you can omit this configuration table parameter and just use
		-- smart_splits.apply_to_config(config)

		-- directional keys to use in order of: left, down, up, right
		direction_keys = { "j", "k", "l", "'" },
		-- modifier keys to combine with direction_keys
		modifiers = {
			move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
			resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
		},
	})
	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
	config.disable_default_key_bindings = false
	config.hyperlink_rules = wezterm.default_hyperlink_rules()
	config.mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	}
	config.keys = {
		{
			key = "p",
			mods = "LEADER",
			action = wezterm.action.ActivateCommandPalette,
		},
		{
			key = "w",
			mods = "ALT",
			action = wezterm.action.QuickSelect,
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "LeftArrow",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "DownArrow",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "UpArrow",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "RightArrow",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = [[\]],
			mods = "LEADER",
			action = wezterm.action({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = [[|]],
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				top_level = true,
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			key = [[-]],
			mods = "LEADER",
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = [[_]],
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				top_level = true,
				direction = "Down",
				size = { Percent = 25 },
			}),
		},
		{
			key = "n",
			mods = "ALT",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},
		{
			key = "p",
			mods = "ALT|SHIFT",
			action = wezterm.action.ShowLauncherArgs({
				flags = "LAUNCH_MENU_ITEMS|FUZZY|TABS|DOMAINS|WORKSPACES",
			}),
		},
		 {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            wezterm.action.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
		{
			key = "Q",
			mods = "ALT",
			action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
		},
		{ key = "q",   mods = "ALT",        action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		{ key = "F11", mods = "",           action = wezterm.action.ToggleFullScreen },
		{ key = "[",   mods = "ALT",        action = wezterm.action({ ActivateTabRelative = -1 }) },
		{ key = "]",   mods = "ALT",        action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ key = "{",   mods = "SHIFT|ALT",  action = wezterm.action.MoveTabRelative(-1) },
		{ key = "}",   mods = "SHIFT|ALT",  action = wezterm.action.MoveTabRelative(1) },
		{ key = "y",   mods = "ALT",        action = wezterm.action.ActivateCopyMode },
		{ key = "c",   mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
		{ key = "v",   mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{ key = "z",   mods = "ALT",        action = wezterm.action.TogglePaneZoomState },
		{ key = "=",   mods = "CTRL",       action = wezterm.action.IncreaseFontSize },
		{ key = "-",   mods = "CTRL",       action = wezterm.action.DecreaseFontSize },
		{ key = "1",   mods = "ALT",        action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2",   mods = "ALT",        action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3",   mods = "ALT",        action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4",   mods = "ALT",        action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5",   mods = "ALT",        action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6",   mods = "ALT",        action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7",   mods = "ALT",        action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8",   mods = "ALT",        action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9",   mods = "ALT",        action = wezterm.action({ ActivateTab = 8 }) },
	}
end

-- return keys and mouse
--
Keys.setup(config)
return config
