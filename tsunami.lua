-- LIMPIEZA DE INTERFAZ
if game:GetService("CoreGui"):FindFirstChild("BryanMenu") then
    game:GetService("CoreGui").BryanMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BryanMenu"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 160)
Frame.Position = UDim2.new(0.5, -110, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true 
Frame.Parent = ScreenGui

-- BOTÓN E (LO QUE YA FUNCIONA PERFECTO)
local btnE = Instance.new("TextButton")
btnE.Size = UDim2.new(1, -20, 0, 40)
btnE.Position = UDim2.new(0, 10, 0, 10)
btnE.Text = "RECOJO E: OFF"
btnE.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
btnE.TextColor3 = Color3.new(1,1,1)
btnE.Parent = Frame

local instantE = false
btnE.MouseButton1Click:Connect(function()
    instantE = not instantE
    btnE.Text = instantE and "RECOJO E: ON" or "RECOJO E: OFF"
    btnE.BackgroundColor3 = instantE and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(80, 0, 0)
    task.spawn(function()
        while instantE do
            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
            end
            task.wait(1.5)
        end
    end)
end)

-- BOTÓN VIAJE ABISAL V30 (-35 STUDS)
local btnViaje = Instance.new("TextButton")
btnViaje.Size = UDim2.new(1, -20, 0, 40)
btnViaje.Position = UDim2.new(0, 10, 0, 60)
btnViaje.Text = "VIAJE ABISAL (-35m)"
btnViaje.BackgroundColor3 = Color3.fromRGB(0, 30, 100)
btnViaje.TextColor3 = Color3.new(1,1,1)
btnViaje.Parent = Frame

btnViaje.MouseButton1Click:Connect(function()
    btnViaje.Interactable = false
    btnViaje.Text = "EN EL ABISMO..."
    
    task.spawn(function()
        local char = game.Players.LocalPlayer.Character
        local root = char:WaitForChild("HumanoidRootPart")
        
        -- CAPTURAMOS DIRECCIÓN Y PROFUNDIDAD ABISAL
        local lookVector = root.CFrame.LookVector
        local startPos = root.Position
        local targetY = root.Position.Y - 35 -- BAJAMOS MUCHO MÁS
        
        -- ANCLA TOTAL PARA EVITAR DAÑO
        root.Anchored = true 
        
        -- VIAJE RECTO (100 STUDS - PARA TESTEAR BIEN)
        local distanciaRecorrida = 0
        while distanciaRecorrida < 100 do 
            local nuevaPos = root.Position + (lookVector * 1.5)
            root.CFrame = CFrame.new(nuevaPos.X, targetY, nuevaPos.Z) * CFrame.lookAt(Vector3.new(0,0,0), lookVector).Rotation
            
            distanciaRecorrida = (Vector3.new(root.Position.X, 0, root.Position.Z) - Vector3.new(startPos.X, 0, startPos.Z)).Magnitude
            task.wait(0.01)
        end
        
        -- REGRESO A LA SUPERFICIE (Si no has muerto por el void)
        root.CFrame = CFrame.new(root.Position.X, targetY + 36, root.Position.Z)
        root.Anchored = false
        
        btnViaje.Text = "VIAJE ABISAL (-35m)"
        btnViaje.Interactable = true
    end)
end)

local btnClose = Instance.new("TextButton")
btnClose.Size = UDim2.new(1, -20, 0, 30)
btnClose.Position = UDim2.new(0, 10, 0, 110)
btnClose.Text = "CERRAR"
btnClose.Parent = Frame
btnClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
