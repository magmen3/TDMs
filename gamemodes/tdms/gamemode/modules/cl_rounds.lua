net.Receive("RoundEndMessage", function()
    local team = net.ReadInt(8)
    if team == TEAM_CT then
        chat.AddText(Color(0, 0, 255), "Команда CT победила!")
    elseif team == TEAM_T then
        chat.AddText(Color(255, 0, 0), "Команда T победила!")
    end
end)