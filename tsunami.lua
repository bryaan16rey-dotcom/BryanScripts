-- LIMPIEZA TOTAL
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "BryanUltra" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BryanUltra"
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 180, 0, 100)
Main.Position = UDim2.new(0.5, -90, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 4
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

-- BOTÓN 1: RECOJO E
local btnE = Instance.new("TextButton")
btnE.Size = UDim2.new(1, -10, 0, 40)
btnE.Position = UDim2.new(0, 5, 0, 5)
btnE.Text = "AUTO-E: ON"
btnE.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
btnE.TextColor3 = Color3.new(1,1,1)
btnE.Parent = Main

task.spawn(function()
    while true do
        pcall(function()
            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
            end
        end)
        task.wait(2)
    end
end)

-- BOTÓN 2: VIAJE ABISMAL (-300)
local btnViaje = Instance.new("TextButton")
btnViaje.Size = UDim2.new(1, -10, 0, 40)
btnViaje.Position = UDim2.new(0, 5, 0, 50)
btnViaje.Text = "TELEPORT TORRE (-300m)"
btnViaje.BackgroundColor3 = Color3.fromRGB(0, 50, 200)
btnViaje.TextColor3 = Color3.new(1,1,1)
btnViaje.Parent = Main

btnViaje.MouseButton1Click:Connect(function()
    btnViaje.Text = "VIAJANDO..."
    btnViaje.Interactable = false
    
    local char = game.Players.LocalPlayer.Character
    local root = char:WaitForChild("HumanoidRootPart")
    local dir = root.CFrame.LookVector
    local targetY = root.Position.Y - 300 -- PROFUNDIDAD MÁXIMA PARA EVITAR DAÑO
    
    root.Anchored = true 
    
    task.spawn(function()
        -- Viaje rápido y profundo
        for i = 1, 150 do 
            root.CFrame = CFrame.new(root.Position.X + (dir.X * 3), targetY, root.Position.Z + (dir.Z * 3))
            task.wait(0.01)
        end
        -- Regreso a la superficie
        root.CFrame = CFrame.new(root.Position.X, targetY + 301, root.Position.Z)
        root.Anchored = false
        btnViaje.Text = "TELEPORT TORRE (-300m)"
        btnViaje.Interactable = true
    end)
end)
