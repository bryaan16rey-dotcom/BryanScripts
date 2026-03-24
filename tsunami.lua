-- V88: VERSIÓN GITHUB ESTABLE
local L = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local W = L.CreateLib("BRYAN MAESTRO V88", "Midnight")

local T = W:NewTab("Principal")
local S = T:NewSection("Viaje a la Torre")

S:NewButton("IR A LA TORRE (GALAXY)", "650 Pasos - Inmune a Olas", function()
    local p = game.Players.LocalPlayer
    local c = p.Character or p.CharacterAdded:Wait()
    local r = c:WaitForChild("HumanoidRootPart")
    local h = c:WaitForChild("Humanoid")
    
    local sP = r.Position
    local sR = r.CFrame.Rotation
    local d = r.CFrame.LookVector
    r.Anchored = true
    
    task.spawn(function()
        -- 650 PASOS A 5.0m (DISTANCIA DOBLE)
        for i = 1, 650 do
            -- MODO GALAXY -150m (INMUNE A OLAS)
            r.CFrame = CFrame.new(sP + (d * (i * 5.0))) * CFrame.new(0, -150, 0) * sR
            r.Velocity = Vector3.new(0,0,0) -- ANTI-RETROCESO
            h:ChangeState(11) 
            task.wait(0.01)
        end
        r.CFrame = r.CFrame * CFrame.new(0, 162, 0)
        task.wait(0.3)
        r.Anchored = false
        h:ChangeState(12)
    end)
end)

local S2 = T:NewSection("Extras")
S2:NewButton("AUTO-E (ON)", "Recoge premios solo", function()
    task.spawn(function()
        while task.wait(0.5) do
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
                end
            end)
        end
    end)
end)
