local icon_cache = {}

return {
	name = "filetype",
	events = { "BufEnter", "WinEnter" },
	update = function()
		local filename = vim.fn.expand("%:t")

		-- caching
		-- todo: clean up hl stuff
		if _YaslConfig.global_settings.enable_icons and not icon_cache[filename] then
			local icon, hl = require("nvim-web-devicons").get_icon_colors(
				filename,
				nil
			)
			local hl_group = "Yasl" .. filename

			vim.api.nvim_set_hl(0, hl_group, {
				fg = hl,
				bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg
			})

			icon_cache[filename] = {
				icon = icon,
				hl_group = hl_group,
			}
		end

		if _YaslConfig.global_settings.enable_icons then
			return string.format("%%#%s#%s%%* ", icon_cache[filename].hl_group, icon_cache[filename].icon or "")
		else
			return "%y"
		end
	end
}
