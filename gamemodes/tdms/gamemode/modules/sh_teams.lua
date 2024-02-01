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

function GM:ShowTeam(ply)
	if not GAMEMODE.TeamBased then return end
	local TimeBetweenSwitches = GAMEMODE.SecondsBetweenTeamSwitches or 10
	if ply.LastTeamSwitch and RealTime() - ply.LastTeamSwitch < TimeBetweenSwitches then
		--ply.LastTeamSwitch = ply.LastTeamSwitch + 1
		ply:ChatPrint(Format("Please wait %i more seconds before trying to change team again", (TimeBetweenSwitches - (RealTime() - ply.LastTeamSwitch)) + 1))
		return
	end

	ply:SendLua("GAMEMODE:ShowTeam()")
end

function GM:PlayerCanJoinTeam(ply, teamid)
	local TimeBetweenSwitches = GAMEMODE.SecondsBetweenTeamSwitches or 10
	if ply.LastTeamSwitch and RealTime() - ply.LastTeamSwitch < TimeBetweenSwitches then
		--ply.LastTeamSwitch = ply.LastTeamSwitch + 1
		ply:ChatPrint(Format("Please wait %i more seconds before trying to change team again", (TimeBetweenSwitches - (RealTime() - ply.LastTeamSwitch)) + 1))
		return false
	end

	if ply:Team() == teamid then
		ply:ChatPrint("You're already on that team")
		return false
	end
	return true
end

function GM:OnPlayerChangedTeam(ply, oldteam, newteam)
	if newteam == TEAM_SPECTATOR then
		local Pos = ply:EyePos()
		ply:Spawn()
		ply:SetPos(Pos)
	elseif oldteam == TEAM_SPECTATOR then
		ply:Spawn()
	end

	PrintMessage(HUD_PRINTTALK, Format("%s joined '%s'", ply:Nick(), team.GetName(newteam)))
end

function GM:PlayerInitialSpawn(ply, transition)
	self:PlayerSpawnAsSpectator(ply)
	if GAMEMODE.TeamBased then ply:ConCommand("gm_showteam") end
end

hook.Add("PlayerSpawn", "tdms-teams-plyspawn", function(ply, transition)
	if ply:Team() ~= TEAM_SPECTATOR then
		ply:Freeze(true)
		ply:GodEnable()
		timer.Simple(3, function()
			if not IsValid(ply) then return end
			ply:Freeze(false)
			ply:GodDisable()
		end)
	end

	if ply:Team() == TEAM_CT then
		player_manager.SetPlayerClass(ply, "player_ct")
	elseif ply:Team() == TEAM_T then
		player_manager.SetPlayerClass(ply, "player_t")
	end
end)