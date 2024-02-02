
concommand.Add("spec_mode", function(ply, cmd, args)
    if ply:Team() ~= TEAM_SPECTATOR then return end

    local mode = ply:GetObserverMode()

    if mode == OBS_MODE_NONE then
        ply:SetObserverMode(OBS_MODE_ROAMING)
    elseif mode == OBS_MODE_ROAMING then
        local target = FindClosestPlayer(ply)
        if target then
            ply:SpectateEntity(target)
            ply:SetObserverMode(OBS_MODE_CHASE)
        end
    elseif mode == OBS_MODE_CHASE then
        ply:SetObserverMode(OBS_MODE_IN_EYE)
    elseif mode == OBS_MODE_IN_EYE then
        ply:SetObserverMode(OBS_MODE_ROAMING)
    end

    net.Start("SpecModeChanged")
    net.WriteInt(ply:GetObserverMode(), 8)
    net.Send(ply)
end)

function FindClosestPlayer(ply)
    local closest = nil
    local dist = math.huge

    for _, p in pairs(player.GetAll()) do
        if p:Team() ~= TEAM_SPECTATOR and p:Alive() then
            local d = p:GetPos():Distance(ply:GetPos())
            if d < dist then
                closest = p
                dist = d
            end
        end
    end

    return closest
end



net.Receive("SpecModeChanged", function()
    local mode = net.ReadInt(8)

    if mode == OBS_MODE_ROAMING then
        chat.AddText(Color(255, 255, 255), "Free-Cam")
    elseif mode == OBS_MODE_CHASE then
        chat.AddText(Color(255, 255, 255), "Following-Cam")
    elseif mode == OBS_MODE_IN_EYE then
        chat.AddText(Color(255, 255, 255), "FPV-Cam")
    end
end)


hook.Add("KeyPress", "SpecModeSwitch", function(ply, key)
    if ply:Team() == TEAM_SPECTATOR and key == IN_JUMP then
        RunConsoleCommand("spec_mode")
    end
end)

hook.Add("PlayerDeath", "SpecModeDeath", function(ply, inflictor, attacker)
    ply:SetTeam(TEAM_SPECTATOR)
    ply:SetObserverMode(OBS_MODE_ROAMING)
end)