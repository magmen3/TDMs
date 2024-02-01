
    concommand.Add("setteam", function(ply, cmd, args)
        local teamId = tonumber(args[1])
        if teamId and teamId >= 1 and teamId <= 2 and GAMEMODE:PlayerCanJoinTeam(ply, teamId) then
            ply:SetTeam(teamId)
            GAMEMODE:OnPlayerChangedTeam(ply, ply:Team(), teamId)
        end
    end)
end
