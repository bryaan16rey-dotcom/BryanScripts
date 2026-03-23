-- RESET TOTAL
local ui = game:GetService("CoreGui"):FindFirstChild("BryanFinal")
if ui then ui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BryanFinal"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 180, 0, 100)
Frame.Position = UDim2.new(0.5, -90, 0.3, 0)
Frame.BackgroundColor3 = Color3.new(0,0,0)
Frame.BorderSizePixel = 2
Frame.Parent = ScreenGui

-- TEXTO DE ESTADO
local txt = Instance.new("TextLabel")
txt.Size = UDim2.new(1, 0, 0, 30)
txt.Text = "AUTO-E: ON"
txt.TextColor3 = Color3.new(1,1,1)
txt.BackgroundTransparency = 1
txt.Parent = Frame

-- BUCLE DE RECOJO (E)
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

-- BOTÓN DE VIAJE AL ABISMO (-250m)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.9, 0, 0, 50)
btn.Position = UDim2.new(0.05, 0, 0.4, 0)
btn.Text = "MODO FANTASMA (-250m)"
btn.BackgroundColor3 = Color3.new(0.1, 0.4, 0.8)
btn.TextColor3 = Color3.new(1,1,1)
btn.Parent = Frame

btn.MouseButton1Click:Connect(function()
    btn.Text = "VIAJANDO..."
    btn.Interactable = false
    
    local root = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local dir = root.CFrame.LookVector
    local targetY = root.Position.Y - 250 -- PROFUNDIDAD EXTREMA
    
    root.Anchored = true 
    
    task.spawn(function()
        for i = 1, 150 do -- Viaje largo para cruzar todo el mapa
            root.CFrame = CFrame.new(root.Position.X + (dir.X * 3), targetY, root.Position.Z + (dir.Z * 3))
            task.wait(0.01)
        end
        root.CFrame = CFrame.new(root.Position.X, targetY + 251, root.Position.Z)
        root.Anchored = false
        btn.Text = "MODO FANTASMA (-250m)"
        btn.Interactable = true
    end)
end)
