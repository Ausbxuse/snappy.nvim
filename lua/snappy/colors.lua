local util = require("snappy.util")

local M = {}

--[[ local colors = {
        _nc = '#16141f',
        base = '#191724',
        surface = '#1f1d2e',
        overlay = '#26233a',
        muted = '#6e6a86',
        subtle = '#908caa',
        text = '#e0def4',
        magenta = '#fc317e',
        orange = '#f69c5e',
        yellow = '#f6c177',
        green = '#9cce6a',
        blue = '#4fc1ff',
        cyan = '#62d8f1',
        cyan2 = '#89ddff',
        purple = '#bd93f9',
        highlight_low = '#21202e',
        highlight_med = '#403d52',
        highlight_high = '#524f67',
        none = 'NONE',
      } ]]
---@class Palette
M.default = {
	none = "NONE",
	bg_dark = "#1b1e2d",
	bg_1 = "#1c1f24",
	bg_2 = "#282a36",
	bg_3 = "#3a3d4d",
	bg = "#1e2233",
	bg_highlight = "#292e42",
	terminal_black = "#414868",
	fg_dark = "#a9b1d6",
	fg_gutter = "#3b4261",
	dark3 = "#545c7e",
	comment = "#565f89",
	dark5 = "#737aa2",
	blue0 = "#3d59a1",
	blue1 = "#2ac3de",
	blue2 = "#0db9d7",
	blue5 = "#89ddff",
	blue6 = "#b4f9f8",
	blue7 = "#394b70",
	magenta2 = "#ec5f67",

	-- bg = "#161617",
	-- fg = "#c9c7cd",
	-- green = "#90b99f",
	-- cyan = "#85b5ba",
	-- blue = "#92a2d5",
	-- purple = "#aca1cf",
	-- magenta = "#e29eca",
	-- red = "#ea83a5",
	-- orange = "#f5a191",
	-- yellow = "#e6b99d",
	--
	-- fg = "#f0e9fa", -- a gentle, light lavender for primary text
	-- cyan = "#7ac9e8", -- a soft, airy cyan
	-- blue = "#6ab0f7", -- a calming pastel blue
	-- magenta = "#fb8ea6", -- a subtle, soothing magenta
	-- purple = "#cbb8f8", -- a delicate pastel purple
	-- orange = "#f8a57e", -- a warm, mellow orange
	-- yellow = "#f5c07e", -- a gentle, soft yellow
	-- green = "#a8d88b", -- a muted, earthy green
	-- red = "#f97c8e", -- a soft, warm red

	-- fg = "#e0def4",
	-- cyan = "#62d8f1",
	-- blue = "#4fc1ff",
	-- magenta = "#fc317e",
	-- purple = "#bd93f9",
	-- purple2 = "#c792ea",
	-- orange = "#f69c5e",
	-- yellow = "#f4bf75",
	-- green = "#9ece6a",
	-- red = "#f7768e",

	fg = "#d4d2e2", -- Softer foreground (light grayish lavender)
	cyan = "#8fd3e6", -- Muted cyan (soft teal)
	blue = "#77bdfb", -- Softer blue (muted sky blue)
	magenta = "#e68098", -- Muted magenta (soft rose)
	purple = "#a890d3", -- Softer purple (desaturated lavender)
	purple2 = "#b79acb", -- Muted violet (pastel violet)
	orange = "#e5a782", -- Softer orange (muted peach)
	yellow = "#e6c27a", -- Muted yellow (soft gold)
	green = "#a3c88b", -- Softer green (dusty sage)
	red = "#e38b96", -- Muted red (soft coral)

	violet = "#b4befe",

	yellow1 = "#f3f99d",
	green1 = "#9acd68",
	green2 = "#a6e22e",
	teal = "#1abc9c",
	red1 = "#ff2740",
	git = { change = "#354157", add = "#394634", delete = "#55393d" },
	gitSigns = {
		add = "#9ece6a",
		change = "#f3f99d",
		delete = "#ff2740",
	},
}

--[[ ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
		ObsidianTilde = { bold = true, fg = "#ff5370" },
		ObsidianBullet = { bold = true, fg = "#89ddff" },
		ObsidianRefText = { underline = true, fg = "#c792ea" },
		ObsidianExtLinkIcon = { fg = "#c792ea" },
		ObsidianTag = { italic = true, fg = "#89ddff" },
		ObsidianBlockID = { italic = true, fg = "#89ddff" },
		ObsidianHighlightText = { bg = "#75662e" }, ]]

M.night = {
	bg = "#1a1b26",
	bg_dark = "#16161e",
}
M.day = M.night

---@return ColorScheme
function M.setup(opts)
	opts = opts or {}
	local config = require("snappy.config")

	local style = config.is_day() and config.options.light_style or config.options.style
	local palette = M[style] or {}
	if type(palette) == "function" then
		palette = palette()
	end

	vim.fn.expand("$home")

	-- Color Palette
	---@class ColorScheme: Palette
	local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

	util.bg = colors.bg
	util.day_brightness = config.options.day_brightness

	colors.diff = {
		add = util.darken(colors.green2, 0.15),
		delete = util.darken(colors.red1, 0.15),
		change = util.darken(colors.blue7, 0.15),
		text = colors.blue7,
	}

	colors.git.ignore = colors.dark3
	colors.black = util.darken(colors.bg, 0.8, "#000000")
	colors.border_highlight = util.darken(colors.blue1, 0.8)
	colors.border = config.options.styles.sidebars == "transparent" and colors.none
		or config.options.styles.sidebars == "dark" and colors.bg_dark
		or colors.bg

	-- Popups and statusline always get a dark background
	colors.bg_popup = colors.bg_dark
	colors.bg_statusline = config.options.styles.sidebars == "transparent" and colors.none
		or config.options.styles.sidebars == "dark" and colors.bg_dark
		or colors.bg

	-- Sidebar and Floats are configurable
	colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
		or config.options.styles.sidebars == "dark" and colors.bg_dark
		or colors.bg

	colors.bg_float = config.options.styles.floats == "transparent" and colors.none
		or config.options.styles.floats == "dark" and colors.bg_dark
		or colors.bg

	colors.bg_visual = util.darken(colors.blue0, 0.4)
	colors.bg_search = colors.blue0
	colors.fg_sidebar = colors.fg_dark
	-- colors.fg_float = config.options.styles.floats == "dark" and colors.fg_dark or colors.fg
	colors.fg_float = colors.fg

	colors.error = colors.red1
	colors.todo = colors.blue
	colors.warning = colors.yellow
	colors.info = colors.blue2
	colors.hint = colors.teal

	colors.delta = {
		add = util.darken(colors.green2, 0.45),
		delete = util.darken(colors.red1, 0.45),
	}

	config.options.on_colors(colors)
	if opts.transform and config.is_day() then
		util.invert_colors(colors)
	end

	return colors
end

return M
