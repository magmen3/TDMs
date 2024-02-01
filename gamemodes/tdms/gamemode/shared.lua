DEFINE_BASECLASS("gamemode_base")
GM.Name = "TDMs"
GM.Author = "Mannytko, Deka, sekta"
GM.Email = "N/A"
GM.Website = "N/A"
GM.TeamBased = true
GM.SecondsBetweenTeamSwitches = 5
function GM:CreateTeams()
	TEAM_CT = 1
	team.SetUp(TEAM_CT, "Counter-Terrorists", Color(0, 0, 255))
	team.SetSpawnPoint(TEAM_CT, {"info_player_counterterrorist", "info_player_combine", "info_player_deathmatch", "info_player_axis"})
	------------------------------------------------------------
	TEAM_T = 2
	team.SetUp(TEAM_T, "Terrorists", Color(255, 150, 0))
	team.SetSpawnPoint(TEAM_T, {"info_player_terrorist", "info_player_rebel", "info_player_deathmatch", "info_player_allies"})
	------------------------------------------------------------
	team.SetSpawnPoint(TEAM_SPECTATOR, "worldspawn")
end

function GM:PlayerNoClip(ply, on)
	-- Don't allow if player is in vehicle
	if not IsValid(ply) or ply:InVehicle() or not ply:Alive() then return false end
	-- Always allow to turn off noclip, and in single player
	if not on or game.SinglePlayer() then return true end
	return GetConVar("sv_cheats"):GetInt() > 0
end