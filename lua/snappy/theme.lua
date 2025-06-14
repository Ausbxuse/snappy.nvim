local util = require("snappy.util")
local colors = require("snappy.colors")

local M = {}

---@class Highlight
---@field fg string|nil
---@field bg string|nil
---@field sp string|nil
---@field style string|nil|Highlight
---@field link string|nil
---@alias Highlights table<string,Highlight>
---@return Theme

function M.setup()
	local config = require("snappy.config")
	local options = config.options
	---@class Theme
	---@field highlights Highlights
	local theme = {
		config = options,
		colors = colors.setup(),
	}

	local c = theme.colors

	theme.highlights = {
		Foo = { bg = c.magenta2, fg = c.fg },

		Comment = { fg = c.comment, style = options.styles.comments }, -- any comment
		ColorColumn = { bg = c.black }, -- used for the columns set with 'colorcolumn'
		Conceal = { fg = c.dark5 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
		Cursor = { fg = c.bg, bg = c.fg }, -- character under the cursor
		lCursor = { fg = c.bg, bg = c.fg }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
		CursorIM = { fg = c.bg, bg = c.fg }, -- like Cursor, but used when in IME mode |CursorIM|
		CursorColumn = { bg = c.bg_highlight }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorLine = { bg = c.bg_highlight }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
		LineNr = { fg = c.dark3 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		CursorLineNr = { fg = c.orange, bold = true }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		Directory = { fg = c.blue }, -- directory names (and other special names in listings)
		DiffAdd = { bg = c.diff.add }, -- diff mode: Added line |diff.txt|
		DiffChange = { bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
		DiffDelete = { bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
		DiffText = { bg = c.diff.text }, -- diff mode: Changed text within a changed line |diff.txt|
		EndOfBuffer = { fg = c.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
		-- TermCursor  = { }, -- cursor in a focused terminal
		-- TermCursorNC= { }, -- cursor in an unfocused terminal
		ErrorMsg = { fg = c.error }, -- error messages on the command line
		VertSplit = { fg = c.border }, -- the column separating vertically split windows
		WinSeparator = { fg = c.violet, bold = true }, -- the column separating vertically split windows
		Folded = { fg = c.fg_dark, bg = options.transparent and c.none or c.bg }, -- line used for closed folds
		FoldColumn = { bg = options.transparent and c.none or c.bg, fg = c.comment }, -- 'foldcolumn'
		SignColumn = { bg = options.transparent and c.none or c.bg, fg = c.fg_gutter }, -- column where |signs| are displayed
		SignColumnSB = { bg = c.bg_sidebar, fg = c.fg_gutter }, -- column where |signs| are displayed
		Substitute = { bg = c.red, fg = c.black }, -- |:substitute| replacement text highlighting
		MatchParen = { fg = c.yellow1, bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg = { fg = c.green, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
		MsgArea = { fg = c.fg_dark }, -- Area for messages and cmdline
		-- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
		MoreMsg = { fg = c.blue }, -- |more-prompt|
		NonText = { fg = c.dark3 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		Normal = { fg = c.fg, bg = options.transparent and c.none or c.bg }, -- normal text
		NormalNC = { fg = c.fg, bg = options.transparent and c.none or options.dim_inactive and c.bg_dark or c.bg }, -- normal text in non-current windows
		NormalSB = { fg = c.fg_sidebar, bg = c.bg_sidebar }, -- normal text in sidebar
		NormalFloat = { fg = c.fg_float, bg = c.bg_dark }, -- Normal text in floating windows.
		FloatBorder = { fg = c.border_highlight, bg = c.bg_float },
		FloatTitle = { fg = c.border_highlight, bg = c.bg_float },
		Pmenu = { bg = c.bg_dark, fg = c.fg_dark }, -- Popup menu: normal item.
		PmenuSel = { bg = util.darken(c.fg_gutter, 0.8) }, -- Popup menu: selected item.
		PmenuSbar = { bg = util.lighten(c.bg, 0.95) }, -- Popup menu: scrollbar.
		PmenuThumb = { bg = c.fg_gutter }, -- Popup menu: Thumb of the scrollbar.
		Question = { fg = c.blue }, -- |hit-enter| prompt and yes/no questions
		QuickFixLine = { bg = c.bg_visual, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		Search = { bg = c.bg_search, fg = c.fg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
		IncSearch = { bg = c.orange, fg = c.black }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		CurSearch = { link = "IncSearch" },
		SpecialKey = { fg = c.dark3 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
		SpellBad = { sp = c.error, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		SpellCap = { sp = c.warning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		SpellLocal = { sp = c.info, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		SpellRare = { sp = c.hint, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
		StatusLine = { fg = c.fg, bg = c.bg_statusline, bold = true }, -- status line of current window
		StatusLineNC = { fg = c.fg_gutter, bg = c.bg_statusline }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		TabLine = { bg = options.transparent and c.none or c.bg, fg = util.darken(c.fg_gutter, 0.8) }, -- tab pages line, not active tab page label
		TabLineFill = { bg = options.transparent and c.none or c.bg }, -- tab pages line, where there are no labels
		TabLineSel = { fg = c.fg_dark, bg = util.darken(c.fg_gutter, 0.8) }, -- tab pages line, active tab page label
		Title = { fg = c.blue, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
		Visual = { bg = c.bg_visual }, -- Visual mode selection
		VisualNOS = { bg = c.bg_visual }, -- Visual mode selection when vim is "Not Owning the Selection".
		WarningMsg = { fg = c.warning }, -- warning messages
		Whitespace = { fg = c.fg_gutter }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion
		WinBar = { link = "StatusLine" }, -- window bar
		WinBarNC = { link = "StatusLineNC" }, -- window bar in inactive windows

		-- These groups are not listed as default vim groups,
		-- but they are defacto standard group names for syntax highlighting.
		-- commented out groups should chain up to their "preferred" group by
		-- default,
		-- Uncomment and edit if you want more specific syntax highlighting.

		Constant = { fg = c.green }, -- (preferred) any constant
		String = { fg = c.yellow }, --   a string constant: "this is a string"
		Character = { fg = c.yellow }, --  a character constant: 'c', '\n'
		Number = { fg = c.purple }, --   a number constant: 234, 0xff
		Boolean = { fg = c.green }, --  a boolean constant: TRUE, false
		-- Float         = { }, --    a floating point constant: 2.3e10

		Identifier = { fg = c.magenta, style = options.styles.variables, italic = true }, -- (preferred) any variable name
		Function = { fg = c.blue, style = options.styles.functions }, -- function name (also: methods for classes)

		Statement = { fg = c.orange }, -- (preferred) any statement
		Conditional = { fg = c.green, bold = true }, --  if, then, else, endif, switch, etc.
		Repeat = { fg = c.green }, --   for, do, while, etc.
		-- Label         = { }, --    case, default, etc.
		Operator = { fg = c.blue5 }, -- "sizeof", "+", "*", etc.
		Keyword = { fg = c.magenta, style = options.styles.keywords }, --  any other keyword
		-- Exception     = { }, --  try, catch, throw

		PreProc = { fg = c.green }, -- (preferred) generic Preprocessor
		Include = { fg = c.green }, --  preprocessor #include
		-- Define        = { }, --   preprocessor #define
		-- Macro         = { }, --    same as Define
		PreCondit = { fg = c.green }, --  preprocessor #if, #else, #endif, etc.

		Type = { fg = c.cyan, bold = true }, -- (preferred) int, long, char, etc.
		-- StorageClass  = { }, -- static, register, volatile, etc.
		-- Structure     = { }, --  struct, union, enum, etc.
		-- Typedef       = { }, --  A typedef

		Special = { fg = c.blue }, -- (preferred) any special symbol
		-- SpecialChar   = { }, --  special character in a constant
		-- Tag           = { }, --    you can use CTRL-] on this
		Delimiter = { link = "Special" }, --  character that needs attention
		-- SpecialComment= { }, -- special things inside a comment
		Debug = { fg = c.orange }, --    debugging statements

		Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
		Bold = { bold = true },
		Italic = { italic = true },

		-- ("Ignore", below, may be invisible...)
		-- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

		Error = { fg = c.error }, -- (preferred) any erroneous construct
		Todo = { bg = c.yellow, fg = c.bg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		qfLineNr = { fg = c.dark5 },
		qfFileName = { fg = c.blue },

		htmlH1 = { fg = c.magenta, bold = true },
		htmlH2 = { fg = c.blue, bold = true },

		-- mkdHeading = { fg = c.orange, bold = true },
		-- mkdCode = { bg = c.terminal_black, fg = c.fg },
		mkdCodeDelimiter = { bg = c.terminal_black, fg = c.fg },
		mkdCodeStart = { fg = c.teal, bold = true },
		mkdCodeEnd = { fg = c.teal, bold = true },
		-- mkdLink = { fg = c.blue, underline = true },

		markdownHeadingDelimiter = { fg = c.orange, bold = true },
		markdownCode = { fg = c.teal, bg = c.bg_dark },
		markdownCodeBlock = { fg = c.teal, bg = c.bg_dark },
		markdownH1 = { fg = c.magenta, bold = true },
		markdownH2 = { fg = c.blue, bold = true },
		markdownLinkText = { fg = c.blue, underline = true },
		--[[ ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
		ObsidianTilde = { bold = true, fg = "#ff5370" },
		ObsidianBullet = { bold = true, fg = "#89ddff" },
		ObsidianRefText = { underline = true, fg = "#c792ea" },
		ObsidianExtLinkIcon = { fg = "#c792ea" },
		ObsidianTag = { italic = true, fg = "#89ddff" },
		ObsidianBlockID = { italic = true, fg = "#89ddff" },
		ObsidianHighlightText = { bg = "#75662e" }, ]]

		["helpCommand"] = { bg = c.terminal_black, fg = c.blue },

		debugPC = { bg = util.darken(c.bg_highlight, 0.8) }, -- used for highlighting the current line in terminal-debug
		debugBreakpoint = { bg = util.darken(c.info, 0.8), fg = c.info }, -- used for breakpoint colors in terminal-debug

		dosIniLabel = { link = "@property" },

		-- These groups are for the native LSP client. Some other LSP clients may
		-- use these groups, or use their own. Consult your LSP client's
		-- documentation.
		LspReferenceText = { bg = c.fg_gutter }, -- used for highlighting "text" references
		LspReferenceRead = { bg = c.fg_gutter }, -- used for highlighting "read" references
		LspReferenceWrite = { bg = c.fg_gutter }, -- used for highlighting "write" references

		DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
		DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
		DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
		DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
		DiagnosticUnnecessary = { fg = c.terminal_black }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

		DiagnosticVirtualTextError = { bg = util.darken(c.error, 0.1), fg = c.error }, -- Used for "Error" diagnostic virtual text
		DiagnosticVirtualTextWarn = { bg = util.darken(c.warning, 0.1), fg = c.warning }, -- Used for "Warning" diagnostic virtual text
		DiagnosticVirtualTextInfo = { bg = util.darken(c.info, 0.1), fg = c.info }, -- Used for "Information" diagnostic virtual text
		DiagnosticVirtualTextHint = { bg = util.darken(c.hint, 0.1), fg = c.hint }, -- Used for "Hint" diagnostic virtual text

		DiagnosticUnderlineError = { undercurl = true, sp = c.error }, -- Used to underline "Error" diagnostics
		DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning }, -- Used to underline "Warning" diagnostics
		DiagnosticUnderlineInfo = { undercurl = true, sp = c.info }, -- Used to underline "Information" diagnostics
		DiagnosticUnderlineHint = { undercurl = true, sp = c.hint }, -- Used to underline "Hint" diagnostics

		LspSignatureActiveParameter = { bg = util.darken(c.bg_visual, 0.4), bold = true },
		LspCodeLens = { fg = c.comment },
		LspInlayHint = { bg = options.transparent and c.none or util.darken(c.blue7, 0.1), fg = c.dark5 },

		LspInfoBorder = { fg = c.border_highlight, bg = c.bg_float },

		ALEErrorSign = { fg = c.error },
		ALEWarningSign = { fg = c.warning },

		DapStoppedLine = { bg = util.darken(c.warning, 0.4) }, -- Used for "Warning" diagnostic virtual text

		-- These groups are for the Neovim tree-sitter highlights.
		["@annotation"] = { link = "PreProc" },
		["@attribute"] = { link = "PreProc" },
		["@boolean"] = { link = "Boolean" },
		["@character"] = { link = "Character" },
		["@character.special"] = { link = "SpecialChar" },
		["@comment"] = { link = "Comment" },
		["@keyword.conditional"] = { link = "Conditional", bold = true },
		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { link = "Constant", bold = true },
		["@constant.macro"] = { link = "Define" },
		["@keyword.debug"] = { link = "Debug" },
		["@keyword.directive.define"] = { link = "Define" },
		["@keyword.exception"] = { link = "Exception" },
		["@number.float"] = { link = "Float" },
		["@function"] = { link = "Function" },
		["@function.builtin"] = { link = "Special" },
		["@function.call"] = { link = "@function" },
		["@function.macro"] = { link = "Macro" },
		["@keyword.import"] = { link = "Include" },
		["@keyword.coroutine"] = { link = "@keyword" },
		["@keyword.operator"] = { link = "@operator" },
		["@keyword.return"] = { fg = c.magenta, bold = true, italic = true },
		["@function.method"] = { link = "Function" },
		["@function.method.call"] = { link = "@function.method" },
		["@namespace.builtin"] = { link = "@variable.builtin" },
		["@none"] = {},
		["@number"] = { link = "Number" },
		["@keyword.directive"] = { link = "PreProc" },
		["@keyword.repeat"] = { link = "Repeat" },
		["@keyword.storage"] = { link = "StorageClass" },
		["@string"] = { link = "String" },
		["@markup.link.label"] = { link = "SpecialChar" },
		["@markup.link.label.symbol"] = { link = "Identifier" },
		["@tag"] = { link = "Label" },
		["@tag.attribute"] = { link = "@property" },
		["@tag.delimiter"] = { link = "Delimiter" },
		["@markup"] = { link = "@none" },
		["@markup.environment"] = { link = "Macro" },
		["@markup.environment.name"] = { link = "Type" },
		["@markup.raw"] = { link = "String" },
		["@markup.raw.block"] = { bg = c.bg_dark },
		["@markup.math"] = { link = "Special" },
		["@markup.strong"] = { bold = true },
		["@markup.emphasis"] = { italic = true },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },
		["@markup.heading"] = { link = "Title" },
		["@comment.note"] = { fg = c.hint },
		["@comment.error"] = { fg = c.error },
		["@comment.hint"] = { fg = c.hint },
		["@comment.info"] = { fg = c.info },
		["@comment.warning"] = { fg = c.warning },
		["@comment.todo"] = { fg = c.todo },
		["@markup.link.url"] = { link = "Underlined" },
		["@type"] = { link = "Type" },
		["@type.definition"] = { link = "Typedef" },
		["@type.qualifier"] = { link = "@keyword" },

		--- Misc
		-- TODO:
		-- ["@comment.documentation"] = { },
		["@operator"] = { fg = c.magenta, bold = true }, -- For any operator: `+`, but also `->` and `*` in C.

		--- Punctuation
		["@punctuation.delimiter"] = { fg = c.blue5 }, -- For delimiters ie: `.`
		["@punctuation.bracket"] = { fg = c.fg_dark }, -- For brackets and parens.
		["@punctuation.special"] = { fg = c.blue5 }, -- For special symbols (e.g. `{}` in string interpolation)
		["@markup.list"] = { fg = c.blue5 }, -- For special punctutation that does not fall in the catagories before.
		["@markup.list.markdown"] = { fg = c.orange, bold = true },

		--- Literals
		["@string.documentation"] = { fg = c.yellow },
		["@string.regexp"] = { fg = c.blue6 }, -- For regexes.
		["@string.escape"] = { fg = c.magenta }, -- For escape characters within a string.

		--- Functions
		["@constructor"] = { fg = c.blue, bold = true }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
		["@variable.parameter"] = { fg = c.orange, italic = true }, -- For parameters of a function.
		["@variable.parameter.builtin"] = { fg = util.lighten(c.yellow, 0.8) }, -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]

		--- Keywords
		["@keyword"] = { fg = c.magenta, style = options.styles.keywords }, -- For keywords that don't fall in previous categories.
		["@keyword.function"] = { fg = c.cyan, style = options.styles.functions }, -- For keywords used to define a fuction.

		["@label"] = { fg = c.blue }, -- For labels: `label:` in C and `:label:` in Lua.

		--- Types
		["@type.builtin"] = { fg = c.cyan, bold = true },
		["@variable.member"] = { fg = c.cyan }, -- For fields.
		["@property"] = { fg = c.cyan, italic = true },

		--- Identifiers
		["@variable"] = { fg = c.fg, style = options.styles.variables }, -- Any variable name that does not have another highlight.
		["@variable.builtin"] = { fg = c.cyan }, -- Variable names that are defined by the languages, like `this` or `self`.
		["@module.builtin"] = { fg = c.green }, -- Variable names that are defined by the languages, like `this` or `self`.

		--- Text
		-- ["@markup.raw.markdown"] = { fg = c.blue },
		["@markup.raw.markdown_inline"] = { bg = c.bg_highlight, fg = c.fg_dark },
		["@markup.link"] = { fg = c.teal },

		["@markup.list.unchecked"] = { fg = c.blue }, -- For brackets and parens.
		["@markup.list.checked"] = { fg = c.green1 }, -- For brackets and parens.

		["@diff.plus"] = { link = "DiffAdd" },
		["@diff.minus"] = { link = "DiffDelete" },
		["@diff.delta"] = { link = "DiffChange" },

		["@module"] = { link = "Include", italic = true },

		-- tsx
		["@tag.tsx"] = { fg = c.red },
		["@constructor.tsx"] = { fg = c.blue1 },
		["@tag.delimiter.tsx"] = { fg = util.darken(c.blue, 0.7) },

		-- LSP Semantic Token Groups
		["@lsp.type.boolean"] = { link = "@boolean" },
		["@lsp.type.builtinType"] = { link = "@type.builtin" },
		["@lsp.type.comment"] = { link = "@comment" },
		["@lsp.type.decorator"] = { link = "@attribute" },
		["@lsp.type.deriveHelper"] = { link = "@attribute" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.enumMember"] = { link = "@constant" },
		["@lsp.type.escapeSequence"] = { link = "@string.escape" },
		["@lsp.type.formatSpecifier"] = { link = "@markup.list" },
		["@lsp.type.generic"] = { link = "@variable" },
		["@lsp.type.interface"] = { fg = util.lighten(c.blue1, 0.7) },
		["@lsp.type.keyword"] = { link = "@keyword" },
		["@lsp.type.lifetime"] = { link = "@keyword.storage" },
		["@lsp.type.namespace"] = { link = "@module" },
		["@lsp.type.number"] = { link = "@number" },
		["@lsp.type.operator"] = { link = "@operator" },
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
		["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
		["@lsp.type.string"] = { link = "@string" },
		["@lsp.type.typeAlias"] = { link = "@type.definition" },
		["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.error },
		["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
		["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
		["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
		["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
		["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
		["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
		["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.operator.injected"] = { link = "@operator" },
		["@lsp.typemod.string.injected"] = { link = "@string" },
		["@lsp.typemod.struct.defaultLibrary"] = { link = "@type.builtin" },
		["@lsp.typemod.type.defaultLibrary"] = { fg = util.darken(c.blue1, 0.8) },
		["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = util.darken(c.blue1, 0.8) },
		["@lsp.typemod.variable.callable"] = { link = "@function" },
		["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
		["@lsp.typemod.variable.injected"] = { link = "@variable" },
		["@lsp.typemod.variable.static"] = { link = "@constant" },
		-- NOTE: maybe add these with distinct highlights?
		-- ["@lsp.typemod.variable.globalScope"] (global variables)

		-- diff
		diffAdded = { fg = c.git.add },
		diffRemoved = { fg = c.git.delete },
		diffChanged = { fg = c.git.change },
		diffOldFile = { fg = c.yellow },
		diffNewFile = { fg = c.orange },
		diffFile = { fg = c.blue },
		diffLine = { fg = c.comment },
		diffIndexLine = { fg = c.magenta },

		-- Neogit
		NeogitBranch = { fg = c.magenta },
		NeogitRemote = { fg = c.purple },
		NeogitHunkHeader = { bg = c.bg_highlight, fg = c.fg },
		NeogitHunkHeaderHighlight = { bg = c.fg_gutter, fg = c.blue },
		NeogitDiffContextHighlight = { bg = util.darken(c.fg_gutter, 0.5), fg = c.fg_dark },
		NeogitDiffDeleteHighlight = { fg = c.git.delete, bg = c.diff.delete },
		NeogitDiffAddHighlight = { fg = c.git.add, bg = c.diff.add },

		GitSignsAdd = { fg = c.gitSigns.add },
		GitSignsChange = { fg = c.gitSigns.change },
		GitSignsDelete = { fg = c.gitSigns.delete },

		-- Neotest
		NeotestPassed = { fg = c.green },
		NeotestRunning = { fg = c.yellow },
		NeotestFailed = { fg = c.red },
		NeotestSkipped = { fg = c.blue },
		NeotestTest = { fg = c.fg_sidebar },
		NeotestNamespace = { fg = c.green2 },
		NeotestFocused = { fg = c.yellow },
		NeotestFile = { fg = c.teal },
		NeotestDir = { fg = c.blue },
		NeotestBorder = { fg = c.blue },
		NeotestIndent = { fg = c.fg_sidebar },
		NeotestExpandMarker = { fg = c.fg_sidebar },
		NeotestAdapterName = { fg = c.purple, bold = true },
		NeotestWinSelect = { fg = c.blue },
		NeotestMarked = { fg = c.blue },
		NeotestTarget = { fg = c.blue },
		--[[ NeotestUnknown = {}, ]]

		DropBarMenuNormalFloat = { link = "Pmenu" },
		DropBarMenuHoverEntry = { link = "IncSearch", reverse = true },
		-- Fzflua
		FzfLuaFzfMatch = { fg = c.orange, bold = true },
		FzfLuaNormal = { fg = c.fg, bg = c.bg_dark },
		FzfLuaBorder = { fg = c.fg_dark, bg = c.bg_dark },
		FzfLuaBackdrop = { bg = c.bg_dark },

		FzfLuaScrollBorderFull = { fg = c.fg_gutter },

		FzfLuaPreviewTitle = { fg = c.bg_dark, bg = c.green, bold = true },
		FzfLuaFzfScrollbar = { bg = c.bg_highlight }, -- does not work

		FzfLuaTitle = {
			fg = c.bg_dark,
			bg = c.red,
			bold = true,
		},
		FzfLuaFzfPrompt = {
			fg = c.bg_dark,
			bg = c.red,
			bold = true,
		},

		netrwCompress = { fg = c.green, bg = c.black },
		netrwData = { fg = c.blue, bg = c.black },
		netrwHdr = { fg = c.green },
		netrwLex = { fg = c.green },
		netrwYacc = { fg = c.green },
		netrwLib = { fg = c.yellow },
		netrwObj = { fg = c.red },
		netrwTilde = { fg = c.red },
		netrwTmp = { fg = c.red },
		netrwTags = { fg = c.red },
		netrwDoc = { fg = c.yellow, bg = c.blue },
		netrwSymLink = { fg = c.bg_2 },

		-- WhichKey
		WhichKey = { fg = c.cyan },
		WhichKeyGroup = { fg = c.blue },
		WhichKeyDesc = { fg = c.magenta },
		WhichKeySeperator = { fg = c.comment },
		WhichKeySeparator = { fg = c.comment },
		WhichKeyFloat = { bg = c.bg_sidebar },
		WhichKeyValue = { fg = c.dark5 },

		-- NeoVim
		healthError = { fg = c.error },
		healthSuccess = { fg = c.green1 },
		healthWarning = { fg = c.warning },

		TSNodeKey = { fg = c.magenta2, bold = true },
		TSNodeUnmatched = { fg = c.dark3 },

		FlashBackdrop = { fg = c.dark3 },
		FlashLabel = { bg = c.magenta2, bold = true, fg = c.bg_dark },

		-- Cmp
		CmpDocumentation = { fg = c.fg, bg = c.bg_float },
		CmpDocumentationBorder = { fg = c.border_highlight, bg = c.bg_float },
		CmpGhostText = { fg = c.terminal_black },
		BlinkCmpKind = { fg = c.fg_dark },

		CmpItemAbbr = { fg = c.fg_dark, bg = c.none },
		CmpItemAbbrDeprecated = { fg = c.fg_gutter, bg = c.none, strikethrough = true },
		CmpItemAbbrMatch = { fg = c.orange, bg = c.none },
		CmpItemAbbrMatchFuzzy = { fg = c.orange, bg = c.none },

		CmpItemMenu = { fg = c.comment, bg = c.none },

		CmpItemKindDefault = { fg = c.fg_dark, bg = c.none },

		CmpItemKindCodeium = { fg = c.teal, bg = c.none },
		CmpItemKindCopilot = { fg = c.teal, bg = c.none },
		CmpItemKindTabNine = { fg = c.teal, bg = c.none },

		-- Scrollbar
		ScrollbarHandle = { fg = c.none, bg = c.bg_highlight },

		ScrollbarSearchHandle = { fg = c.orange, bg = c.bg_highlight },
		ScrollbarSearch = { fg = c.orange, bg = c.none },

		ScrollbarErrorHandle = { fg = c.error, bg = c.bg_highlight },
		ScrollbarError = { fg = c.error, bg = c.none },

		ScrollbarWarnHandle = { fg = c.warning, bg = c.bg_highlight },
		ScrollbarWarn = { fg = c.warning, bg = c.none },

		ScrollbarInfoHandle = { fg = c.info, bg = c.bg_highlight },
		ScrollbarInfo = { fg = c.info, bg = c.none },

		ScrollbarHintHandle = { fg = c.hint, bg = c.bg_highlight },
		ScrollbarHint = { fg = c.hint, bg = c.none },

		ScrollbarMiscHandle = { fg = c.purple, bg = c.bg_highlight },
		ScrollbarMisc = { fg = c.purple, bg = c.none },

		-- Lazy
		LazyProgressDone = { bold = true, fg = c.magenta2 },
		LazyProgressTodo = { bold = true, fg = c.fg_gutter },

		-- Notify
		NotifyBackground = { fg = c.fg, bg = c.bg },
		--- Border
		NotifyERRORBorder = { fg = util.darken(c.error, 0.3), bg = options.transparent and c.none or c.bg },
		NotifyWARNBorder = { fg = util.darken(c.warning, 0.3), bg = options.transparent and c.none or c.bg },
		NotifyINFOBorder = { fg = util.darken(c.info, 0.3), bg = options.transparent and c.none or c.bg },
		NotifyDEBUGBorder = { fg = util.darken(c.comment, 0.3), bg = options.transparent and c.none or c.bg },
		NotifyTRACEBorder = { fg = util.darken(c.purple, 0.3), bg = options.transparent and c.none or c.bg },
		--- Icons
		NotifyERRORIcon = { fg = c.error },
		NotifyWARNIcon = { fg = c.warning },
		NotifyINFOIcon = { fg = c.info },
		NotifyDEBUGIcon = { fg = c.comment },
		NotifyTRACEIcon = { fg = c.purple },
		--- Title
		NotifyERRORTitle = { fg = c.error },
		NotifyWARNTitle = { fg = c.warning },
		NotifyINFOTitle = { fg = c.info },
		NotifyDEBUGTitle = { fg = c.comment },
		NotifyTRACETitle = { fg = c.purple },
		--- Body
		NotifyERRORBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
		NotifyWARNBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
		NotifyINFOBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
		NotifyDEBUGBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
		NotifyTRACEBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },

		-- Noice
		IndentBlankLineContextChar = { fg = c.fg_dark, bg = c.none },

		NoiceCompletionItemKindDefault = { fg = c.fg_dark, bg = c.none },
		-- BUG: can't use transparent background
		-- NoiceMini = { bg = c.bg },
		-- NoiceLspProgressSpinner = { bg = c.bg },
		-- NoiceLspProgressClient = { bg = c.bg },
		-- NoiceLspProgressTitle = { bg = c.bg },

		TreesitterContextBottom = { bg = options.transparent and c.none or c.bg },
		Hlargs = { fg = c.yellow },
		-- TreesitterContext = { bg = util.darken(c.bg_visual, 0.4) },
	}

	-- lsp symbol kind and completion kind highlights
	local kinds = {
		Array = "@punctuation.bracket",
		Boolean = "@boolean",
		Class = "@type",
		Color = "Special",
		Constant = "@constant",
		Constructor = "@constructor",
		Enum = "@lsp.type.enum",
		EnumMember = "@lsp.type.enumMember",
		Event = "Special",
		Field = "@variable.member",
		File = "MsgArea",
		Folder = "Directory",
		Function = "@function",
		Interface = "@lsp.type.interface",
		Key = "@variable.member",
		Keyword = "@lsp.type.keyword",
		Method = "@function.method",
		Module = "@module",
		Namespace = "@module",
		Null = "@constant.builtin",
		Number = "@number",
		Object = "@constant",
		Operator = "@operator",
		Package = "@module",
		Property = "@property",
		Reference = "@markup.link",
		Snippet = "Conceal",
		String = "@string",
		Struct = "@lsp.type.struct",
		Unit = "@lsp.type.struct",
		Text = "@markup",
		TypeParameter = "@lsp.type.typeParameter",
		Variable = "@variable",
		Value = "@string",
	}

	local kind_groups = { "BlinkCmpKind%s" }
	for kind, link in pairs(kinds) do
		local base = "LspKind" .. kind
		theme.highlights[base] = { link = link }
		for _, plugin in pairs(kind_groups) do
			theme.highlights[plugin:format(kind)] = { link = base }
		end
	end

	local markdown_rainbow = { c.magenta, c.yellow, c.green, c.cyan, c.blue, c.purple }

	for i, color in ipairs(markdown_rainbow) do
		theme.highlights["@markup.heading." .. i .. ".markdown"] = { fg = color, bold = true }
		theme.highlights["Headline" .. i] = { bg = util.darken(color, 0.05) }
	end
	theme.highlights["Headline"] = { link = "Headline1" }

	if not vim.diagnostic then
		local severity_map = {
			Error = "Error",
			Warn = "Warning",
			Info = "Information",
			Hint = "Hint",
		}
		local types = { "Default", "VirtualText", "Underline" }
		for _, type in ipairs(types) do
			for snew, sold in pairs(severity_map) do
				theme.highlights["LspDiagnostics" .. type .. sold] = {
					link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
				}
			end
		end
	end

	---@type table<string, table>
	theme.defer = {}

	local inactive = { bg = c.none, fg = c.fg_dark, sp = c.border }
	-- StatusLineNC
	theme.highlights.StatusLineNC = inactive

	options.on_highlights(theme.highlights, theme.colors)

	if config.is_day() then
		util.invert_colors(theme.colors)
		util.invert_highlights(theme.highlights)
	end

	return theme
end

return M
