local default_opts = require("yasl.default")
local set_statusline = require("yasl.statusline").set_statusline
local on_enter_refresh_events = { "LspAttach", "WinEnter", "BufEnter" }
local on_leave_refresh_events = { "WinLeave", "BufLeave" }

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

	-- refresh events
	vim.api.nvim_create_autocmd(on_enter_refresh_events, {
		callback = function()
			set_statusline(sections)
		end
	})
	vim.api.nvim_create_autocmd(on_leave_refresh_events, {
		callback = function()
			-- clear status line back to default
			vim.api.nvim_win_set_option(0, "statusline", "")
		end
	})
end

return M
