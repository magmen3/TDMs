AddCSLuaFile()
DEFINE_BASECLASS("player_base")
local PLAYER = {}
PLAYER.WalkSpeed = 140 -- How fast to move when not running
PLAYER.RunSpeed = 260 -- How fast to move when running
PLAYER.CrouchedWalkSpeed = 0.35 -- Multiply move speed by this when crouching
PLAYER.DuckSpeed = 0.5 -- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed = 0.5 -- How fast to go from ducking, to not ducking
PLAYER.JumpPower = 180 -- How powerful our jump should be
PLAYER.StartArmor = 50 -- How much armour we start with
-------------------------------------------------
function PLAYER:Loadout()
	local ply = self.Player
	ply:Give("cw_ar15")
	ply:Give("cw_m1911")
	ply:Give("cw_flash_grenade")
	------------------------------
	ply:GiveAmmo(120, "5.56x45MM", true)
	ply:GiveAmmo(24, ".45 ACP", true)
	ply:GiveAmmo(2, "Flash Grenades", true)
end

player_manager.RegisterClass("player_ct", PLAYER, "player_base")