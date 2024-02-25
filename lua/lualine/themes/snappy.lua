local colors = require("snappy.colors").setup({ transform = true })
local config = require("snappy.config").options

local snappy = {}

snappy.normal = {
	a = { bg = colors.blue, fg = colors.black, gui = "bold" },
	b = { bg = colors.fg_gutter, fg = colors.blue },
	c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
}

snappy.insert = {
	a = { bg = colors.green, fg = colors.black, gui = "bold" },
	b = { bg = colors.fg_gutter, fg = colors.green },
}

snappy.command = {
	a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
	b = { bg = colors.fg_gutter, fg = colors.yellow },
}

snappy.visual = {
	a = { bg = colors.magenta, fg = colors.black, gui = "bold" },
	b = { bg = colors.fg_gutter, fg = colors.magenta },
}

snappy.replace = {
	a = { bg = colors.red, fg = colors.black, gui = "bold" },
	b = { bg = colors.fg_gutter, fg = colors.red },
}

snappy.terminal = {
	a = { bg = colors.green1, fg = colors.black, gui = "bold" },
	b = { bg = colors.fg_gutter, fg = colors.green1 },
}

snappy.inactive = {
	a = { bg = colors.bg_statusline, fg = colors.blue, gui = "bold" },
	b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
	c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
}

if config.lualine_bold then
	for _, mode in pairs(snappy) do
		mode.a.gui = "bold"
	end
end

return snappy
