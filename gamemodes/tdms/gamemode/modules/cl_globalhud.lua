if CLIENT then
    local teamCounts = { [TEAM_CT] = 0, [TEAM_T] = 0 }

    local function updateTeamCounts()
        teamCounts[TEAM_CT] = #team.GetPlayers(TEAM_CT)
        teamCounts[TEAM_T] = #team.GetPlayers(TEAM_T)
    end

    local function drawTeamCounts()
        local scrW, scrH = ScrW(), ScrH()
        local boxW, boxH = 200, 100
        local boxX, boxY = scrW / 2 - boxW / 2, 30

        draw.RoundedBox(10, boxX, boxY, boxW, boxH, Color(10, 10, 10, 200))

        draw.SimpleText("Counter-Terrorists: " .. teamCounts[TEAM_CT], "DermaLarge", boxX + 10, boxY + 10, Color(0, 0, 255), TEXT_ALIGN_LEFT)
        draw.SimpleText("Terrorists: " .. teamCounts[TEAM_T], "DermaLarge", boxX + 10, boxY + 50, Color(255, 150, 0), TEXT_ALIGN_LEFT)
    end

    hook.Add("HUDPaint", "DrawTeamCounts", drawTeamCounts)
    hook.Add("Think", "UpdateTeamCounts", updateTeamCounts)
end
-- пояснялка, пытаюсь сделать худ как в радуге чтоб сверху отображались живые игроки 


-- Выбор команды 
if CLIENT then
    local function createTeamSelectionMenu()
        local frame = vgui.Create("DFrame")
        frame:SetSize(ScrW() * 0.8, ScrH() * 0.8)
        frame:Center()
        frame:MakePopup()
        frame:SetTitle("Выберите команду")

        local ctButton = vgui.Create("DButton", frame)
        ctButton:SetSize(frame:GetWide() * 0.4, frame:GetTall() * 0.8)
        ctButton:SetPos(frame:GetWide() * 0.05, frame:GetTall() * 0.1)
        ctButton:SetText("Counter-Terrorists")
        ctButton:SetFont("DermaLarge")
        ctButton.DoClick = function()
            RunConsoleCommand("setteam", TEAM_CT)
            frame:Close()
        end

        local tButton = vgui.Create("DButton", frame)
        tButton:SetSize(frame:GetWide() * 0.4, frame:GetTall() * 0.8)
        tButton:SetPos(frame:GetWide() * 0.55, frame:GetTall() * 0.1)
        tButton:SetText("Terrorists")
        tButton:SetFont("DermaLarge")
        tButton.DoClick = function()
            RunConsoleCommand("setteam", TEAM_T)
            frame:Close()
        end
    end

    hook.Add("InitPostEntity", "CreateTeamSelectionMenu", createTeamSelectionMenu)
end
