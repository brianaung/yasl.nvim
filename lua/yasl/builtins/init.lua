local modules = {
	["mode"] = "yasl.builtins.mode",
	["diagnostics"] = "yasl.builtins.diagnostics",
	["branch"] = "yasl.builtins.branch",
	["gitdiff"] = "yasl.builtins.gitdiff",
	["filetype"] = "yasl.builtins.filetype",
}

-- lazy load modules
return setmetatable({}, {
	__index = function(loaded_modules, key)
		local module_path = modules[key]

		if not module_path then
			return nil
		end

		local module = require(module_path)
		loaded_modules[key] = module -- Cache the module for future use
		return loaded_modules[key]
	end
})
