AddCSLuaFile()
DEFINE_BASECLASS("player_base")
local PLAYER = {}
PLAYER.Models = {"models/player/arctic.mdl", "models/player/guerilla.mdl", "models/player/leet.mdl", "models/player/phoenix.mdl"}
PLAYER.Color = false
PLAYER.WalkSpeed = 150 -- How fast to move when not running
PLAYER.RunSpeed = 265 -- How fast to move when running
PLAYER.CrouchedWalkSpeed = 0.4 -- Multiply move speed by this when crouching
PLAYER.DuckSpeed = 0.45 -- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed = 0.5 -- How fast to go from ducking, to not ducking
PLAYER.JumpPower = 185 -- How powerful our jump should be
PLAYER.StartArmor = 40 -- How much armour we start with
-------------------------------------------------
function PLAYER:Loadout()
	local ply = self.Player
	ply:Give("cw_ak74")
	ply:Give("cw_makarov")
	ply:Give("cw_frag_grenade")
	------------------------------
	ply:GiveAmmo(120, "5.45x39MM", true)
	ply:GiveAmmo(24, "9x18MM", true)
	ply:GiveAmmo(2, "Frag Grenades", true)
end

player_manager.RegisterClass("player_t", PLAYER, "player_base")