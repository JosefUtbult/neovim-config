local M = {}

local function fileExists(path)
	local exists = vim.loop.fs_stat(path) ~= nil
	print("[DEBUG] Checking file exists:", path, exists and "✅ Found" or "❌ Not Found")
	return exists
end

local function readTargetFromConfig(config_path)
	print("[DEBUG] Reading target from:", config_path)
	local file = io.open(config_path, "r")
	if not file then
		print("[DEBUG] ❌ Failed to open config file:", config_path)
		return nil
	end

	for line in file:lines() do
		local target = line:match('^%s*target%s*=%s*"([^"]+)"')
		if target then
			file:close()
			print("[DEBUG] ✅ Found target:", target)
			return target
		end
	end

	file:close()
	print("[DEBUG] ❌ No target found in config")
	return nil
end

local function readProjectNameFromCargo(cargo_path)
	print("[DEBUG] Reading project name from:", cargo_path)
	local file = io.open(cargo_path, "r")
	if not file then
		print("[DEBUG] ❌ Failed to open Cargo.toml:", cargo_path)
		return nil
	end

	local in_package_section = false
	for line in file:lines() do
		if line:match("^%s*%[package%]%s*$") then
			in_package_section = true
		elseif in_package_section then
			local project_name = line:match('^%s*name%s*=%s*"([^"]+)"')
			if project_name then
				file:close()
				print("[DEBUG] ✅ Found project name:", project_name)
				return project_name
			end
		end
	end

	file:close()
	print("[DEBUG] ❌ No project name found in Cargo.toml")
	return nil
end

function M.findExecutablePath(file)
	print("[DEBUG] Searching for executable path from:", file)

	-- Ensure path is a directory (remove file name)
	local path = file:match("(.*/)")
	local last_path = nil -- Store the last checked path

	while path and path ~= "" do
		print("[DEBUG] Checking directory:", path)

		local cargo_path = path .. "Cargo.toml"
		local config_path = path .. ".cargo/config.toml"

		if fileExists(cargo_path) then
			print("[DEBUG] ✅ Found Cargo.toml at:", cargo_path)

			local project_name = readProjectNameFromCargo(cargo_path)
			if not project_name then
				error("[ERROR] Unable to find project name from Cargo.toml at " .. cargo_path)
				return nil
			end

			local target_value = fileExists(config_path) and readTargetFromConfig(config_path) or "debug"
			print("[DEBUG] Using target:", target_value)

			local executable_path = path .. "target/" .. target_value .. "/debug/" .. project_name
			print("[DEBUG] ✅ Executable path resolved:", executable_path)

			return executable_path
		end

		-- Move up one level using Lua string matching
		local new_path = path:match("(.*/)[^/]+/?$")

		-- Prevent infinite loop (stop at root `/`)
		if not new_path or new_path == path or new_path == last_path then
			print("[ERROR] Reached filesystem root, stopping search.")
			break
		end

		last_path = path -- Store the last valid path
		path = new_path
	end

	error("[ERROR] No Cargo.toml found in any parent directories.")
	return nil
end

return M
