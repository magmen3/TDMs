-- Фордж фабрик модлоадер
local start = SysTime()
print("[TDMs] Started gamemode.")
local function LoadFile(fileName)
	if fileName:find("sv_") then
		include(fileName)
	elseif fileName:find("shared.lua") or fileName:find("sh_") then
		if SERVER then AddCSLuaFile(fileName) end
		include(fileName)
	elseif fileName:find("cl_") then
		if SERVER then
			AddCSLuaFile(fileName)
		else
			include(fileName)
		end
	end

	print("[TDMs] Loaded: " .. fileName)
end

local function LoadFolder(directory)
	local files, folders = file.Find(directory .. "/*", "LUA")
	for _, fld in ipairs(folders) do
		LoadFolder(directory .. "/" .. fld)
	end

	for _, fl in ipairs(files) do
		LoadFile(directory .. "/" .. fl)
	end
end

LoadFolder("tdms/gamemode/modules")
LoadFolder("tdms/gamemode/player_class")
print("[TDMs] Ended gamemode for " .. math.Round(SysTime() - start, 4) .. "s")