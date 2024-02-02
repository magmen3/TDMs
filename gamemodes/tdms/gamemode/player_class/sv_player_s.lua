AddCSLuaFile()
DEFINE_BASECLASS("player_default")
local PLAYER = {}

PLAYER.Models = {"models/player/skeleton.mdl", "models/player/charple.mdl", "models/player/group01/male_03.mdl"}
PLAYER.Color = Color(255, 255, 255)
PLAYER.SlowWalkSpeed = 80
PLAYER.WalkSpeed = 140
PLAYER.RunSpeed = 260
PLAYER.CrouchedWalkSpeed = 0.3
PLAYER.DuckSpeed = 0.5
PLAYER.UnDuckSpeed = 0.5
PLAYER.JumpPower = 180
PLAYER.CanUseFlashlight = true
PLAYER.CanUseSuitZoom = false
PLAYER.MaxHealth = 100
PLAYER.MaxArmor = 100
PLAYER.StartHealth = 100
PLAYER.StartArmor = 0
PLAYER.DropWeaponOnDie = true
PLAYER.TeammateNoCollide = false
PLAYER.AvoidPlayers = true
PLAYER.UseVMHands = true


PLAYER.TeamBased = true 
PLAYER.NoCollideAll = true 
PLAYER.AllowPickup = false 
PLAYER.AllowButtons = false 

function PLAYER:SetupDataTables()
	BaseClass.SetupDataTables(self)
end

function PLAYER:Spawn()
	BaseClass.Spawn(self)
	local ply = self.Player
	ply:SetCanZoom(self.CanUseSuitZoom or false)

	-- dla spectatora
	ply:SetTeam(TEAM_SPECTATOR) 
	ply:StripWeapons() 
	ply:Spectate(OBS_MODE_ROAMING) 
end

function PLAYER:SetModel()
	BaseClass.SetModel(self)
	local ply = self.Player

	
	ply:SetNoDraw(true) 
end

function PLAYER:Loadout()
	
end

function PLAYER:GetHandsModel()
	BaseClass.GetHandsModel(self)
end

player_manager.RegisterClass("player_spectator", PLAYER, "player_default")
