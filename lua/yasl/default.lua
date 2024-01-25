return {
	global = true,
	components = {
		"mode",
		" ",
		"%<%t%h%m%r%w", -- filename
		" ",
		"branch",
		" ",
		"gitdiff",
		"%=",
		"diagnostics",
		" ",
		"%y",
		" ",
		"[%-8.(%l, %c%V%) %P]", -- filetype, location, and progress
		" ",
	}
}
