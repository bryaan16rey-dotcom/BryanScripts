-- CLON IDENTICO OSAKA GALAXY 6.5 - BRYAN EDITION
-- Basado en: osakaTP2/OsakaTP2/main/Escape%20tsunami
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ButtonFrame = Instance.new("Frame")
local Start = Instance.new("TextButton")
local AutoE = Instance.new("TextButton")
local Exit = Instance.new("TextButton")

-- DISEÑO IDENTICO AL ORIGINAL
ScreenGui.Parent = game:GetService("CoreGui")
Main.Name = "OsakaMain"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Position = UDim2.new(0.5, -110, 0.4, 0)
Main.Size = UDim2.new(0, 220, 0, 190)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = RaycastParams.new().FilterDescendantsInstances and UDim.new(0, 8)

Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "OSAKA GALAXY 6.5 (BRYAN)"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- LÓGICA DE MOVIMIENTO EXACTA (CARRIL 2)
Start.Name = "Start"
Start.Parent = Main
Start.Position = UDim2.new(0.1, 0, 0.28, 0)
Start.Size = UDim2.new(0.8, 0, 0.2, 0)
Start.Text = "IR A LA META (C2)"
Start.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
Start.TextColor3 = Color3.fromRGB(255, 255, 255)
Start.Font = Enum.Font.GothamBold
Instance.new("UICorner", Start)

Start.MouseButton1Click:Connect(function()
    local p = game.Players.LocalPlayer
    local char = p.Character or p.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")

    -- PUNTO A Y CARRIL 2 (ESTO BLOQUEA EL DESVÍO)
    local PosX = root.Position.X
    local Carril2 = root.Position.Z 
    
    root.Anchored = true
    
    task.spawn(function()
        -- 920 PASOS (DISTANCIA GALAXY 6.5)
        for i = 1, 920 do
            -- Eje X positivo (adelante), Altura -180 (profundo), Carril 2 fijo
            root.CFrame = CFrame.new(PosX + (i * 5.5), -180, Carril2)
            
            -- Lógica Anti-Kick de Osaka
            root.Velocity = Vector3.new(0, 0, 0)
            hum:ChangeState(11)
            task.wait(0.01)
        end
        
        -- SUBIDA FINAL EXACTA
        root.CFrame = root.CFrame * CFrame.new(0, 195, 0)
        task.wait(0.2)
        root.Anchored = false
        hum:ChangeState(12)
    end)
end)

-- AUTO-E
AutoE.Parent = Main
AutoE.Position = UDim2.new(0.1, 0, 0.53, 0)
AutoE.Size = UDim2.new(0.8, 0, 0.2, 0)
AutoE.Text = "AUTO-E: ON"
AutoE.BackgroundColor3 = Color3.fromRGB(80, 0, 180)
AutoE.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", AutoE)

AutoE.MouseButton1Click:Connect(function()
    task.spawn(function()
        while task.wait(0.5) do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
            end
        end
    end)
end)

-- ELIMINAR UI
Exit.Parent = Main
Exit.Position = UDim2.new(0.1, 0, 0.78, 0)
Exit.Size = UDim2.new(0.8, 0, 0.15, 0)
Exit.Text = "CERRAR"
Exit.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Exit)

Exit.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
