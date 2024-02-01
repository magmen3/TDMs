--
function GM:RoundStart()
end

function GM:RoundEnd()
end

function GM:RoundThink()
end

hook.Add("Think", "tdms-roundthink", GM:RoundThink())
print("Rounds module loaded!!!!")