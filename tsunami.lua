-- LIMPIEZA TOTAL
if game:GetService("CoreGui"):FindFirstChild("BryanMenu") then
    game:GetService("CoreGui").BryanMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BryanMenu"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 160)
Frame.Position = UDim2.new(0.5, -110, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Negro total
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true 
Frame.Parent = ScreenGui

-- BOTÓN E (EL COMPAÑERO FIABLE)
local btnE = Instance.new("TextButton")
btnE.Size = UDim2.new(1, -20, 0, 40)
btnE.Position = UDim2.new(0, 10, 0, 10)
btnE.Text = "RECOJO E: ON"
btnE.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
btnE.TextColor3 = Color3.new(1,1,1)
btnE.Parent = Frame

local instantE = true -- Activado por defecto para ahorrar tiempo
btnE.MouseButton1Click:Connect(function()
    instantE = not instantE
    btnE.Text = instantE and "RECOJO E: ON" or "RECOJO E: OFF"
    btnE.BackgroundColor3 = instantE and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    task.spawn(function()
        while instantE do
            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
            end
            task.wait(1.5)
        end
    end)
end)

-- BOTÓN VIAJE AL VACÍO V31 (-80 STUDS)
local btnViaje = Instance.new("TextButton")
btnViaje.Size = UDim2.new(1, -20, 0, 40)
btnViaje.Position = UDim2.new(0, 10, 0, 60)
btnViaje.Text = "MODO VACÍO (-80m)"
btnViaje.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
btnViaje.TextColor3 = Color3.new(1,1,1)
btnViaje.Parent = Frame

btnViaje.MouseButton1Click:Connect(function()
    btnViaje.Interactable = false
    btnViaje.Text = "BAJANDO AL LÍMITE..."
    
    task.spawn(function()
        local char = game.Players.LocalPlayer.Character
        local root = char:WaitForChild("HumanoidRootPart")
        
        -- DIRECCIÓN Y PROFUNDIDAD DE SEGURIDAD MÁXIMA
        local lookVector = root.CFrame.LookVector
        local startPos = root.Position
        local targetY = root.Position.Y - 80 -- LÍMITE ANTES DEL VOID
        
        -- CONGELAMOS PARA QUE EL JUEGO NO NOS MUEVA
        root.Anchored = true 
        
        -- VIAJE RECTO (150 STUDS PARA CRUZAR TODA LA OLA)
        local distanciaRecorrida = 0
        while distanciaRecorrida < 150 do 
            -- Movimiento forzado manteniendo la profundidad de -80
            local nuevaPos = root.Position + (lookVector * 2
