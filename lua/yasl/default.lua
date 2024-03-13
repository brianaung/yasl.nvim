return {
	laststatus = 3,
	enable_icons = true,
	transparent = false,
	components = {
		"mode",
		" ",
		"%<%t%h%m%r%w", -- filename
		" ",
		"branch",
		-- " ",
		-- "gitdiff",
		"%=",
		"diagnostics",
		" ",
		"filetype",
		" ",
		"[%-8.(%l, %c%V%) %P]", -- location, and progress
		" ",
	}
}
