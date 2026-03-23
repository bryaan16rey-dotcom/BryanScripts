-- RESET: Borramos cualquier rastro previo para que no choque
local old = game:GetService("CoreGui"):FindFirstChild("BryanFinal")
if old then old:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BryanFinal"
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 200, 0, 120)
Main.Position = UDim2.new(0.5, -100, 0.2, 0)
Main.BackgroundColor3 = Color3.new(0,0,0)
Main.BorderSizePixel = 3
Main.Parent = ScreenGui

-- BOTÓN 1: RECOJO E (Auto-activado)
local btnE = Instance.new("TextButton")
btnE.Size = UDim2.new(1, -10, 0, 45)
btnE.Position = UDim2.new(0, 5, 0, 5)
btnE.Text = "AUTO-E: ACTIVO"
btnE.BackgroundColor3 = Color3.new(0, 0.6, 0)
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

-- BOTÓN 2: VIAJE ABISMAL (-150m)
local btnViaje = Instance.new("TextButton")
btnViaje.Size = UDim2.new(1, -10, 0, 45)
btnViaje.Position = UDim2.new(0, 5, 0, 60)
btnViaje.Text = "INVISIBILIDAD (-150m)"
btnViaje.BackgroundColor3 = Color3.new(0, 0.3, 0.8)
btnViaje.TextColor3 = Color3.new(1,1,1)
btnViaje.Parent = Main

btnViaje.MouseButton1Click:Connect(function()
    btnViaje.Text = "VOLANDO..."
    btnViaje.Interactable = false
    
    local char = game.Players.LocalPlayer.Character
    local root = char:WaitForChild("HumanoidRootPart")
    
    -- BLOQUEO DE DIRECCIÓN Y PROFUNDIDAD EXTREMA
    local dir = root.CFrame.LookVector
    local targetY = root.Position.Y - 150 -- AQUÍ YA NO LLEGA NADA
    root.Anchored = true 
    
    task.spawn(function()
        for i = 1, 100 do -- Viaje de prueba largo
            root.CFrame = CFrame.new(root.Position.X + (dir.X * 2), targetY, root.Position.Z + (dir.Z * 2)) * CFrame.lookAt(Vector3.new(0,0,0), dir).Rotation
            task.wait(0.01)
