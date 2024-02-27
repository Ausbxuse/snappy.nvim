local util = require("snappy.util")

local M = {}

---@class Palette
M.default = {
	none = "NONE",
	bg_dark = "#181a1c",
	bg = "#1e2233",
	bg_highlight = "#292e42",
	terminal_black = "#414868",
	fg = "#e1e3e4",
	fg_dark = "#a9b1d6",
	fg_gutter = "#3b4261",
	dark3 = "#545c7e",
	comment = "#565f89",
	dark5 = "#737aa2",
	blue0 = "#3d59a1",
	blue = "#4fc1ff",
	cyan = "#6dcae8",
	-- cyan1 = "#62d8f1",
	blue1 = "#2ac3de",
	blue2 = "#0db9d7",
	blue5 = "#89ddff",
	blue6 = "#b4f9f8",
	blue7 = "#394b70",
	magenta = "#ff6578",
	magenta2 = "#ec5f67",
	purple = "#ba9cf3",
	-- purple1 = "#ae81ff",
	orange = "#f69c5e",
	yellow = "#f4bf75",
	yellow1 = "#f3f99d",
	green = "#9ed06c",
	green1 = "#9acd68",
	green2 = "#a6e22e",
	teal = "#1abc9c",
	red = "#f7768e",
	red1 = "#ff6d7e",
	git = { change = "#354157", add = "#394634", delete = "#55393d" },
	gitSigns = {
		add = "#394634",
		change = "#354157",
		delete = "#55393d",
	},
}

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
	colors.border = colors.black

	-- Popups and statusline always get a dark background
	colors.bg_popup = colors.bg_dark
	colors.bg_statusline = colors.bg_dark

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
