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

-- BOTÓN E (LO QUE YA FUNCIONA)
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

-- BOTÓN VIAJE RECTO (V26)
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
        
        -- CAPTURAMOS LA DIRECCIÓN FIJA AL INICIO
        local lookVector = root.CFrame.LookVector
        local startPos = root.Position
        local targetY = root.Position.Y - 4.5 -- Bajamos 1.5 metros aprox
        
        -- INICIAMOS VIAJE
        local distanciaRecorrida = 0
        while distanciaRecorrida < 60 do -- 60 studs = 20 metros aprox
            -- Forzamos la posición: Altura fija + Movimiento en la dirección capturada
            local nuevaPos = root.Position + (lookVector * 1.5)
            root.CFrame = CFrame.new(nuevaPos.X, targetY, nuevaPos.Z)
            
            distanciaRecorrida = (root.Position - Vector3.new(startPos.X, targetY, startPos.Z)).Magnitude
            task.wait(0.02)
        end
        
        -- SUBIR A LA SUPERFICIE
        root.CFrame = CFrame.new(root.Position.X, targetY + 5, root.Position.Z)
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
