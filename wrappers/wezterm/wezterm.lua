local wezterm = require("wezterm")
local M = {}

-- JANK COLOUR SCHEME STUFF!!!
local my_colour_scheme = wezterm.color.get_builtin_schemes()["Oxocarbon Dark (Gogh)"]

M.color_schemes = {
	["My Colour Scheme"] = my_colour_scheme,
}

M.color_scheme = "My Colour Scheme"

-- fonts
M.font = wezterm.font_with_fallback({
	{ family = "Monospace" },
})

-- window padding
M.window_padding = {
	left = "15px",
	right = "15px",
	top = "15px",
	bottom = "15px",
}

-- bar (this is why i did that jank)
M.enable_tab_bar = false

M.window_close_confirmation = "NeverPrompt"

wezterm.on("format-window-title", function()
	local title = "WezTerm"
	return title
end)

return M
