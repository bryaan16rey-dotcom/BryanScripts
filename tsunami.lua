-- V86: CARGA DESDE GITHUB (ESTILO OSAKA)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BRYAN MAESTRO - GALAXY V86", "Midnight")

-- PESTAÑA PRINCIPAL
local Tab = Window:NewTab("Principal")
local Section = Tab:NewSection("Ruta a la Torre")

-- BOTÓN DE VIAJE (CLONADO DE OSAKA PERO CON -150m)
Section:NewButton("IR A LA TORRE (GALAXY)", "650 pasos a 4.5m - Inmune a Olas", function()
    local p = game.Players.LocalPlayer
    local c = p.Character or p.CharacterAdded:Wait()
    local r = c:WaitForChild("HumanoidRootPart")
    local h = c:WaitForChild("Humanoid")
    
    local sP = r.Position
    local sR = r.CFrame.Rotation
    local d = r.CFrame.LookVector
    r.Anchored = true
    
    task.spawn(function()
        -- 650 PASOS A 4.5m (PARA CRUZAR TODO EL MAPA)
        for i = 1, 650 do
            -- Bajamos a la Profundidad Galaxy -150
            r.CFrame = CFrame.new(sP + (d * (i * 4.5))) * CFrame.new(0, -150, 0) * sR
            
            -- Bloqueo de velocidad para que el server no te regrese
            r.Velocity = Vector3.new(0,0,0)
            h:ChangeState(11) 
            
            task.wait(0.01)
        end
        
        -- SUBIDA FINAL EN LA ESTRUCTURA
        r.CFrame = r.CFrame * CFrame.new(0, 162, 0)
        task.wait(0.2)
        r.Anchored = false
        h:ChangeState(12)
    end)
end)

-- SECCIÓN DE UTILIDADES
local Sec2 = Tab:NewSection("Extras para el Live")

Sec2:NewButton("AUTO-E (PREMIOS)", "Sin tiempo de espera", function()
    task.spawn(function()
        while task.wait(0.5) do
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
                end
            end)
