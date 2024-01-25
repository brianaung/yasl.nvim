return {
	global = true,
	components = {
		"mode",
		" ",
		"%<%t%h%m%r%w", -- filename
		"branch",
		"%=",
		"diagnostics",
		"gitdiff",
		"%=",
		"%y %-8.(%l, %c%V%) %P", -- filetype, location, and progress
	}
}
