-- ELIMINAR MENÚS ANTERIORES SI EXISTEN
if game:GetService("CoreGui"):FindFirstChild("BryanMenu") then
    game:GetService("CoreGui").BryanMenu:Destroy()
end

-- CREAR INTERFAZ NATIVA
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BryanMenu"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true -- Puedes moverlo con el mouse
Frame.Parent = ScreenGui

-- BOTÓN 1: RECOJO INSTANTÁNEO
local btnE = Instance.new("TextButton")
btnE.Size = UDim2.new(1, -20, 0, 40)
btnE.Position = UDim2.new(0, 10, 0, 10)
btnE.Text = "RECOJO E: OFF"
btnE.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
btnE.Parent = Frame

local instantE = false
btnE.MouseButton1Click:Connect(function()
    instantE = not instantE
    btnE.Text = instantE and "RECOJO E: ON" or "RECOJO E: OFF"
    btnE.BackgroundColor3 = instantE and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    
    task.spawn(function()
        while instantE do
            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
            end
            task.wait(2)
        end
    end)
end)

-- BOTÓN 2: VIAJE A LA TORRE
local btnViaje = Instance.new("TextButton")
btnViaje.Size = UDim2.new(1, -20, 0, 40)
btnViaje.Position = UDim2.new(0, 10, 0, 60)
btnViaje.Text = "VIAJE TORRE: OFF"
btnViaje.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
btnViaje.Parent = Frame

local viajando = false
btnViaje.MouseButton1Click:Connect(function()
    viajando = not viajando
    btnViaje.Text = viajando and "VIAJE TORRE: ON" or "VIAJE TORRE: OFF"
    btnViaje.BackgroundColor3 = viajando and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    
    if viajando then
        task.spawn(function()
            local root = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            -- BAJAR AL RAS (-1.5)
            root.CFrame = root.CFrame * CFrame.new(0, -1.8, 0)
            while viajando do
                root.CFrame = root.CFrame * CFrame.new(0, 0, -3)
                if math.abs(root.Position.Z) > 2500 then break end
                task.wait(0.01)
            end
            if viajando then
                root.CFrame = root.CFrame * CFrame.new(0, 3, 0)
                viajando = false
                btnViaje.Text = "VIAJE TORRE: OFF"
                btnViaje.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            end
        end)
    end
end)

-- BOTÓN CERRAR
local btnClose = Instance.new("TextButton")
btnClose.Size = UDim2.new(1, -20, 0, 30)
btnClose.Position = UDim2.new(0, 10, 0, 110)
btnClose.Text = "CERRAR SCRIPT"
btnClose.Parent = Frame
btnClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
