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
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true 
Frame.Parent = ScreenGui

-- BOTÓN E (Mantenemos lo funcional)
local btnE = Instance.new("TextButton")
btnE.Size = UDim2.new(1, -20, 0, 40)
btnE.Position = UDim2.new(0, 10, 0, 10)
btnE.Text = "RECOJO E: OFF"
btnE.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
btnE.TextColor3 = Color3.new(1,1,1)
btnE.Parent = Frame

local instantE = false
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

-- BOTÓN VIAJE RECTO (V27)
local btnViaje = Instance.new("TextButton")
btnViaje.Size = UDim2.new(1, -20, 0, 40)
btnViaje.Position = UDim2.new(0, 10, 0, 60)
btnViaje.Text = "TEST VIAJE RECTO (20m)"
btnViaje.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
btnViaje.TextColor3 = Color3.new(1,1,1)
btnViaje.Parent = Frame

btnViaje.MouseButton1Click:Connect(function()
    btnViaje.Interactable = false
    btnViaje.Text = "VIAJANDO..."
    
    task.spawn(function()
        local char = game.Players.LocalPlayer.Character
        local root = char:WaitForChild("HumanoidRootPart")
        
        -- CAPTURAMOS DIRECCIÓN Y ALTURA OBJETIVO
        local lookVector = root.CFrame.LookVector
        local targetY = root.Position.Y - 5 -- Bajamos un poco más para asegurar que no te suba
        local startPos = root.Position
        
        -- ANCLA DE FÍSICA: Evitamos que el juego nos empuje
        root.Anchored = true 
        
        -- BUCLE DE MOVIMIENTO (20 metros)
        local distanciaRecorrida = 0
        while distanciaRecorrida < 60 do 
            -- Calculamos la nueva posición manteniendo la Y fija
            local nuevaPos = root.Position + (lookVector * 1.5)
            root.CFrame = CFrame.new(nuevaPos.X, targetY, nuevaPos.Z) * CFrame.Angles(0, math.atan2(lookVector.X, lookVector.Z) + math.pi, 0)
            
            distanciaRecorrida = (Vector3.new(root.Position.X, 0, root.Position.Z) - Vector3.new(startPos.X, 0, startPos.Z)).Magnitude
            task.wait(0.02)
        end
        
        -- SOLTAMOS EL ANCLA Y SUBIMOS
        root.CFrame = CFrame.new(root.Position.X, targetY + 6, root.Position.Z)
        root.Anchored = false
        
        btnViaje.Text = "TEST VIAJE RECTO (20m)"
        btnViaje.Interactable = true
    end)
end)

local btnClose = Instance.new("TextButton")
btnClose.Size = UDim2.new(1, -20, 0, 30)
btnClose.Position = UDim2.new(0, 10, 0, 110)
btnClose.Text = "CERRAR"
btnClose.Parent = Frame
btnClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
