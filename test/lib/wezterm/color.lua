local M = {}

M.parse = function(v)
	if type(v) == "string" then
		return string.match(v, "^#%x%x%x%x%x%x$")
	else
		error("bad argument #1: expected string or number")
	end
end

M.get_builtin_schemes = function()
	return {
		["Codeschool (dark) (terminal.sexy)"] = {
			ansi = {
				"#232c31",
				"#2a5491",
				"#237986",
				"#a03b1e",
				"#484d79",
				"#c59820",
				"#b02f30",
				"#9ea7a6",
			},
			background = "#232c31",
			brights = {
				"#3f4944",
				"#2a5491",
				"#237986",
				"#a03b1e",
				"#484d79",
				"#c59820",
				"#b02f30",
				"#b5d8f6",
			},
			foreground = "#9ea7a6",
			indexed = {},
		},
		["Codeschool (light) (terminal.sexy)"] = {
			ansi = {
				"#232c31",
				"#2a5491",
				"#237986",
				"#a03b1e",
				"#484d79",
				"#c59820",
				"#b02f30",
				"#9ea7a6",
			},
			background = "#b5d8f6",
			brights = {
				"#3f4944",
				"#2a5491",
				"#237986",
				"#a03b1e",
				"#484d79",
				"#c59820",
				"#b02f30",
				"#b5d8f6",
			},
			foreground = "#2a343a",
			indexed = {},
		},
	}
end

M.load_base16_scheme = function(path)
	local test_colors = {
		ansi = {
			"#fbf1f2",
			"#d57e85",
			"#a3b367",
			"#dcb16c",
			"#7297b9",
			"#bb99b4",
			"#69a9a7",
			"#8b8198",
		},
		background = "#fbf1f2",
		brights = {
			"#bfb9c6",
			"#d57e85",
			"#a3b367",
			"#dcb16c",
			"#7297b9",
			"#bb99b4",
			"#69a9a7",
			"#585062",
		},
		cursor_bg = "#8b8198",
		cursor_border = "#8b8198",
		cursor_fg = "#8b8198",
		foreground = "#8b8198",
		indexed = {},
		selection_bg = "#8b8198",
		selection_fg = "#fbf1f2",
	}
	local test_metadata = {
		author = "Test Suite",
		name = "Test Base16 Scheme From YAML file",
	}
	if path ~= "/tmp/test.yaml" then
		error(string.format("read file %q: No such file or directory (os error 2)", path))
	end

	return test_colors, test_metadata
end

M.load_scheme = function(path)
	local test_metadata = {
		name = "Abernathy",
		origin_ul = "https://github.com/mbadolato/iTerm2-Color-Schemes",
	}
	local test_colors = {
		ansi = {
			"#000000",
			"#cd0000",
			"#00cd00",
			"#cdcd00",
			"#1093f5",
			"#cd00cd",
			"#00cdcd",
			"#faebd7",
		},
		background = "#111416",
		brights = {
			"#404040",
			"#ff0000",
			"#00ff00",
			"#ffff00",
			"#11b5f6",
			"#ff00ff",
			"#00ffff",
			"#ffffff",
		},
		cursor_bg = "#bbbbbb",
		cursor_border = "#bbbbbb",
		cursor_fg = "#ffffff",
		foreground = "#eeeeec",
		indexed = {},
		selection_bg = "#eeeeec",
		selection_fg = "#333333",
	}

	if path ~= "/tmp/testexternal.toml" then
		error("No such file or directory (os error 2)")
	end
	return test_colors, test_metadata
end

M.load_terminal_sexy_scheme = function(path)
	local test_metadata = {
		name = "",
		author = "",
	}
	local test_colors = {
		ansi = {
			"#282a2e",
			"#a54242",
			"#8c9440",
			"#de935f",
			"#5f819d",
			"#85678f",
			"#5e8d87",
			"#707880",
		},
		background = "#1d1f21",
		brights = {
			"#373b41",
			"#cc6666",
			"#b5bd68",
			"#f0c674",
			"#81a2be",
			"#b294bb",
			"#8abeb7",
			"#c5c8c6",
		},
		foreground = "#c5c8c6",
	}
	if path ~= "/tmp/test.json" then
		error(string.format("read file %q: No such file or directory (os error 2)", path))
	end

	return test_colors, test_metadata
end

return M
