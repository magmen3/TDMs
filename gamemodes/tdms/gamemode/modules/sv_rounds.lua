local roundNumber = 0
local roundStart = 0
local ROUND_TIME = 600
local MAX_ROUNDS = 20
//local specialRoundChance = 25 Когда нибудь

function GM:RoundStart()
    roundNumber = roundNumber + 1
    roundStart = CurTime()
end

function GM:RoundEnd(winningTeam)
    self:RoundStart()
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