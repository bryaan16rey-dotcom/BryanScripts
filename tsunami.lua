local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BRYAN SYSTEM V23", "DarkTheme")

-- PESTAÑA ÚNICA
local Main = Window:NewTab("Funciones")
local Section = Main:NewSection("Misiones y Recojo")

-- 1. RECOJO INSTANTÁNEO (E)
local instantE = false
Section:NewToggle("Recojo Instantáneo (E)", "Elimina la carga de la E", function(state)
    instantE = state
    task.spawn(function()
        while instantE do
            pcall(function()
                for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                    if v:IsA("ProximityPrompt") then
                        v.HoldDuration = 0
                    end
                end
            end)
            task.wait(2)
        end
    end)
end)

-- 2. VIAJE A LA TORRE (LÍNEA RECTA)
local viajando = false
Section:NewToggle("Viaje Recto a la Torre", "Va por debajo del suelo", function(state)
    viajando = state
    if viajando then
        task.spawn(function()
            local p = game.Players.LocalPlayer
            local root = p.Character:WaitForChild("HumanoidRootPart")
            
            -- BAJAR AL RAS (Casi tocando el suelo)
            root.CFrame = root.CFrame * CFrame.new(0, -1.8, 0)
            
            while viajando do
                -- Movimiento recto hacia adelante
                root.CFrame = root.CFrame * CFrame.new(0, 0, -3)
                
                -- DISTANCIA: Parada en la zona oscura
                if math.abs(root.Position.Z) > 2500 then break end
                
                task.wait(0.01)
            end
            
            if viajando then
                root.CFrame = root.CFrame * CFrame.new(0, 3, 0) -- Subir
            end
        end)
    end
end)

Section:NewButton("Cerrar Script", "Destruye el menú", function()
    viajando = false
    instantE = false
    game:GetService("CoreGui"):FindFirstChild("BRYAN SYSTEM V23"):Destroy()
end)
