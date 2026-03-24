-- V108: CLON PROFESIONAL CARRIL 2 (BRYAN MAESTRO)
-- Optimizado para TikTok Live - Villa El Salvador

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StartBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local AutoEBtn = Instance.new("TextButton")

-- 1. CONFIGURACIÓN VISUAL
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "BryanMaestro_V108"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- Para moverlo en el Live

local Corner = Instance.new("UICorner", MainFrame)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "BRYAN SCRIPTS V108"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundTransparency = 1
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

-- 2. BOTÓN: IR A LA META (CARRIL 2)
StartBtn.Parent = MainFrame
StartBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
StartBtn.Size = UDim2.new(0.8, 0, 0.22, 0)
StartBtn.Text = "INICIAR CARRIL 2"
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", StartBtn)

-- 3. BOTÓN: AUTO-E (PARA PREMIOS)
AutoEBtn.Parent = MainFrame
AutoEBtn.Position = UDim2.new(0.1, 0, 0.52, 0)
AutoEBtn.Size = UDim2.new(0.8, 0, 0.22, 0)
AutoEBtn.Text = "AUTO-E (ACTIVO)"
AutoEBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
AutoEBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoEBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", AutoEBtn)

-- 4. BOTÓN: CERRAR UI
CloseBtn.Parent = MainFrame
CloseBtn.Position = UDim2.new(0.1, 0, 0.8, 0)
CloseBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
CloseBtn.Text = "ELIMINAR VENTANA"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CloseBtn)

-- LÓGICA DE MOVIMIENTO (CARRIL 2 FIJO)
StartBtn.MouseButton1Click:Connect(function()
    local p = game.Players.LocalPlayer
    local r = p.Character.HumanoidRootPart
    local h = p.Character.Humanoid
    
    -- BLOQUEO DE PUNTO A Y CARRIL 2
    local Carril2_Z = r.Position.Z -- Guarda el medio exacto donde estés parado
    local Inicio_X = r.Position.X
    
    r.Anchored = true
    
    task.spawn(function()
        -- 900 PASOS PARA LLEGAR AL FINAL (PUNTO B)
        for i = 1, 900 do
            -- AVANCE RECTO: X aumenta, Z se bloquea en Carril 2, Altura -150 (Galaxy)
            r.CFrame = CFrame.new(Inicio_X + (i * 5.2), -150, Carril2_Z)
            
            r.Velocity = Vector3.zero
            h:ChangeState(11) 
            task.wait(0.01)
        end
        
        -- SUBIDA FINAL EN LA TORRE
        r.CFrame = r.CFrame * CFrame.new(0, 165, 0)
        task.wait(0.2)
        r.Anchored = false
        h:ChangeState(12)
    end)
end)

AutoEBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        while task.wait(0.5) do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
            end
        end
    end)
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
