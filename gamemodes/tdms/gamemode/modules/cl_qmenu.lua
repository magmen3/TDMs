local blacklist = {
	"weapon_hands", -- ну и тд
}

local function OpenQMenu() -- потом надо сделать дерма менюшку покрасивее или на vgui
	local ply, w, h = LocalPlayer(), ScrW(), ScrH()
	local wep = ply:GetActiveWeapon()
	if not (IsValid(ply) or IsValid(wep)) or wep == NULL then return end
	local class = wep:GetClass()
	local qmenu = vgui.Create("DMenu")
	qmenu:SetPos(w / 2.15, h / 1.6)
	qmenu:MakePopup()
	qmenu:SetKeyboardInputEnabled(false)
	--------------------------------
	if wep:IsWeapon() and not table.HasValue(blacklist, class) then
		local submenu1 = qmenu:AddOption("Drop Weapon", function() LocalPlayer():ConCommand("cw_dropweapon") end)
		submenu1:SetIcon("icon16/gun.png")
	end

	--------------------------------
	local submenu2 = qmenu:AddOption("Suicide", function() LocalPlayer():ConCommand("kill") end)
	submenu2:SetIcon("icon16/bomb.png")
	--------------------------------
	local submenu3 = qmenu:AddOption("Dance", function() LocalPlayer():ConCommand("act dance") end)
	submenu3:SetIcon("icon16/box.png")
end

hook.Add("Think", "tdms-qmenu", function() if input.IsKeyDown(KEY_Q) then OpenQMenu() end end)