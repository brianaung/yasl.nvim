-- todo: is there a better way than polluting global namespace?
_G.diagnostics = require("yasl.component").diagnostics
_G.branch = require("yasl.component").branch
_G.gitdiff = require("yasl.component").gitdiff

local default_opts = require("yasl.default")

local components = {
	["mode"] = "%{mode()}",
	["filename"] = "%<%t%h%m%r%w",
	["branch"] = "%{luaeval('branch()')}",
	["gitdiff"] = "%{luaeval('gitdiff()')}",
	["diagnostics"] = "%{luaeval('diagnostics()')}",
	["filetype"] = "%y",
	["progress"] = "%P",
	["location"] = "%-8.(%l, %c%V%)",
}

local refresh_events = { "LspAttach", "WinEnter", "BufEnter" }

local fallback_color = vim.api.nvim_get_hl(0, { name = "StatusLine" })


-- some component can have empty content, in which case we don't want to show the bg
local function is_component_empty(component)
	if component == "filetype" and #vim.fn.expand("%") == 0 then
		return true
	end
	if component == "diagnostics" and diagnostics() == "" then
		return true
	end
	return false
end

local function get_status_grp(section, grp_name)
	if section.components == nil or
			#section.components == 0 or
			(#section.components == 1 and is_component_empty(section.components[1])) then
		return ""
	end

	-- set highlight (or its fallback)
	vim.api.nvim_set_hl(0, grp_name, vim.F.if_nil(section.highlight, fallback_color))

	local curr = string.format("%s%s%s", "%#", grp_name, "#")
	for _, val in ipairs(section.components) do
		curr = string.format("%s %s", curr, components[val])
	end
	return string.format("%s %s", curr, "%*")
end

local function set_statusline(sections)
	vim.api.nvim_set_option("statusline", table.concat({
		get_status_grp(vim.F.if_nil(sections.a, {}), "a"),
		get_status_grp(vim.F.if_nil(sections.b, {}), "b"),
		"%=",
		get_status_grp(vim.F.if_nil(sections.c, {}), "c"),
		"%=",
		get_status_grp(vim.F.if_nil(sections.d, {}), "d"),
		get_status_grp(vim.F.if_nil(sections.e, {}), "e")
	}))
end

local M = {}

function M.setup(opts)
	-- opts.global
	local global = default_opts.global
	if (opts and opts.global ~= nil) then
		global = opts.global
	end
	if global then
		vim.api.nvim_set_option("laststatus", 3)
	else
		vim.api.nvim_set_option("laststatus", 2)
	end

	-- opts.sections
	local sections = (opts and opts.sections) and opts.sections or default_opts.sections
	set_statusline(sections)
	vim.api.nvim_create_autocmd(refresh_events, {
		callback = function()
			set_statusline(sections)
		end
	})
end

return M
