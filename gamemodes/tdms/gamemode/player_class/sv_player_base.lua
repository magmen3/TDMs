AddCSLuaFile()
DEFINE_BASECLASS("player_default")
local PLAYER = {}
-- можно писать тейблом и просто одной моделью
PLAYER.Models = {"models/player/skeleton.mdl", "models/player/charple.mdl", "models/player/group01/male_03.mdl"}
PLAYER.Color = Color(255, 255, 255) -- можно писать как колором так и вектором
-- еще можно false поставить чтобы ставило цвет тимы игрока
PLAYER.SlowWalkSpeed = 80 -- How fast to move when slow-walking (+WALK)
PLAYER.WalkSpeed = 140 -- How fast to move when not running
PLAYER.RunSpeed = 260 -- How fast to move when running
PLAYER.CrouchedWalkSpeed = 0.3 -- Multiply move speed by this when crouching
PLAYER.DuckSpeed = 0.5 -- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed = 0.5 -- How fast to go from ducking, to not ducking
PLAYER.JumpPower = 180 -- How powerful our jump should be
PLAYER.CanUseFlashlight = true -- Can we use the flashlight
PLAYER.CanUseSuitZoom = false -- ставить на true только гордону фримену когда его добавим
PLAYER.MaxHealth = 100 -- Max health we can have
PLAYER.MaxArmor = 100 -- Max armor we can have
PLAYER.StartHealth = 100 -- How much health we start with
PLAYER.StartArmor = 0 -- How much armour we start with
PLAYER.DropWeaponOnDie = true -- Do we drop our weapon when we die
PLAYER.TeammateNoCollide = false -- Do we collide with teammates or run straight through them
PLAYER.AvoidPlayers = true -- Automatically swerves around other players
PLAYER.UseVMHands = true -- Uses viewmodel hands
-------------------------------------------------
function PLAYER:SetupDataTables()
	BaseClass.SetupDataTables(self)
end

function PLAYER:Spawn()
	BaseClass.Spawn(self)
	local ply = self.Player
	ply:SetCanZoom(self.CanUseSuitZoom or false)
end

function PLAYER:SetModel()
	--BaseClass.SetModel(self)
	local ply = self.Player
	if istable(self.Models) then
		ply:SetModel(table.Random(self.Models))
	else
		ply:SetModel(self.Models)
	end

	if self.Color and self.Color ~= false then
		if IsColor(self.Color) then
			ply:SetPlayerColor(self.Color:ToVector())
		elseif isvector(self.Color) then
			ply:SetPlayerColor(self.Color)
		end
	else
		ply:SetPlayerColor(team.GetColor(ply:Team()))
	end
end

function PLAYER:Loadout()
	--
end

function PLAYER:GetHandsModel()
	BaseClass.GetHandsModel(self)
end

player_manager.RegisterClass("player_base", PLAYER, "player_default")