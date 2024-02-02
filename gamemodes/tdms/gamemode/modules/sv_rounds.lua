local roundNumber = 0
local roundStart = 0
local ROUND_TIME = 600
local MAX_ROUNDS = 20

function GM:RoundStart()
    roundNumber = roundNumber + 1
    roundStart = CurTime()


    for _, ply in pairs(player.GetAll()) do
        if ply:Team() ~= TEAM_SPECTATOR then
            ply:Spawn()
        end
    end
end

function GM:RoundEnd(winningTeam)
    if roundNumber < MAX_ROUNDS then
        self:RoundStart()
    else
        game.SetTimeScale(0.1) 
        timer.Simple(5, function() game.SetTimeScale(1) end) 

        net.Start("RoundEndMessage")
        net.WriteInt(winningTeam, 8) 
        net.Broadcast() 
        timer.Simple(10, function() game.ConsoleCommand("changelevel " .. game.GetMap() .. "\n") end)
    end
end

function GM:RoundThink()
    local ctAlive = #team.GetPlayers(TEAM_CT)
    local tAlive = #team.GetPlayers(TEAM_T)

    if ctAlive == 0 and tAlive > 0 then
        self:RoundEnd(TEAM_T)
    elseif tAlive == 0 and ctAlive > 0 then
        self:RoundEnd(TEAM_CT)
    elseif ctAlive == 0 and tAlive == 0 then
        roundNumber = roundNumber - 1
        self:RoundStart()
    elseif CurTime() - roundStart >= ROUND_TIME then
        self:RoundStart()
    end
end

hook.Add("Think", "tdms-roundthink", function() GAMEMODE:RoundThink() end)
print("Rounds module loaded!!!!")