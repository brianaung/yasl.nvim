local icon_cache = {}

return {
	name = "filetype",
	events = { "FileType", "BufEnter", "WinEnter" },
	update = function()
		local ft = vim.bo.filetype

		-- caching
		-- todo: clean up hl stuff
		if _YaslConfig.global_settings.enable_icons and not icon_cache[ft] then
			local icon, hl = require("nvim-web-devicons").get_icon_colors(
				vim.fn.expand("%:t"), -- need filename so nvim-web-devicons can compute it
				nil
			)
			local hl_group = "Yasl" .. ft

			vim.api.nvim_set_hl(0, hl_group, {
				fg = hl,
				bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg
			})

			icon_cache[ft] = {
				icon = icon,
				hl_group = hl_group,
			}
		end

		if _YaslConfig.global_settings.enable_icons then
			return string.format("%%#%s#%s%%* ", icon_cache[ft].hl_group, icon_cache[ft].icon or "")
		else
			return "%y"
		end
	end
}
