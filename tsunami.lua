-- LIMPIEZA
if game:GetService("CoreGui"):FindFirstChild("BryanMenu") then
    game:GetService("CoreGui").BryanMenu:Destroy()
end

-- INTERFAZ
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BryanMenu"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 160)
Frame.Position = UDim2.new(0.5, -110, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true 
Frame.Parent = ScreenGui

-- TÍTULO
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "TEST SUBTERRÁNEO V25"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Parent = Frame

-- BOTÓN E
local btnE = Instance.new("TextButton")
btnE.Size = UDim2.new(1, -20, 0, 35)
btnE.Position = UDim2.new(0, 10, 0, 40)
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

-- BOTÓN TEST VIAJE (CORTO)
local btnViaje = Instance.new("TextButton")
btnViaje.Size = UDim2.new(1, -20, 0, 35)
btnViaje.Position = UDim2.new(0, 10, 0, 80)
btnViaje.Text = "TEST VIAJE (20m)"
btnViaje.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
btnViaje.TextColor3 = Color3.new(1,1,1)
btnViaje.Parent = Frame

btnViaje.MouseButton1Click:Connect(function()
    btnViaje.Text = "VIAJANDO..."
    btnViaje.Interactable = false
    
    task.spawn(function()
        local char = game.Players.LocalPlayer.Character
        local root = char:WaitForChild("HumanoidRootPart")
        
        -- 1. BAJAR SOLO 1 METRO (Casi al ras)
        root.CFrame = root.CFrame * CFrame.new(0, -3.5, 0)
        task.wait(0.2)
        
        -- 2. GUARDAR POSICIÓN INICIAL PARA EL TEST
        local posInicial = root.Position
        
        -- 3. BUCLE DE VIAJE CORTO (20 metros)
        while true do
            root.CFrame = root.CFrame * CFrame.new(0, 0, -2) -- Avanza de 2 en 2
