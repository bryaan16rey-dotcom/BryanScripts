-- BRYAN MAESTRO - RESEARCH PROJECT V110
-- FUNCIÓN ÚNICA: GO TO TOWER (CENTRO BLOQUEADO)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local GoButton = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

-- Interfaz minimalista (Esquina superior derecha para que no estorbe el Live)
ScreenGui.Parent = game:GetService("CoreGui")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0.8, 0, 0.1, 0)
Frame.Size = UDim2.new(0, 150, 0, 80)
Instance.new("UICorner", Frame)

Status.Parent = Frame
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Text = "ESTADO: LISTO"
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.GothamBold

GoButton.Parent = Frame
GoButton.Position = UDim2.new(0.1, 0, 0.4, 0)
GoButton.Size = UDim2.new(0.8, 0, 0.4, 0)
GoButton.Text = "GO TO TOWER"
GoButton.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
GoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", GoButton)

-- LÓGICA DE INVESTIGACIÓN (TRAYECTO DIRECTO)
GoButton.MouseButton1Click:Connect(function()
    local p = game.Players.LocalPlayer
    local char = p.Character
    if not char then return end
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    -- BLOQUEO DEL CARRIL CENTRAL (CARRIL 2)
    -- Grabamos la posición actual para usarla de riel
    local CarrilZ = root.Position.Z
    local StartX = root.Position.X
    
    Status.Text = "VIAJANDO..."
    GoButton.BackgroundColor3 = Color3.fromRGB(150, 50, 0)
    root.Anchored = true
    
    task.spawn(function()
        -- Distancia calculada para el mapa "Brainrot" (aprox 950 tramos)
        for i = 1, 950 do
            -- La magia está aquí: X avanza, Y se hunde (-185), Z se congela (Carril 2)
            root.CFrame = CFrame.new(StartX + (i * 5.6), -185, CarrilZ)
            
            -- Asegura que el personaje no sea afectado por físicas del juego
            root.Velocity = Vector3.zero
            hum:ChangeState(11)
            task.wait(0.01)
        end
        
        -- LLEGADA Y ASCENSO (PUNTO B)
        root.CFrame = root.CFrame * CFrame.new(0, 205, 0)
        task.wait(0.2)
        root.Anchored = false
        hum:ChangeState(12)
        Status.Text = "¡META LLEGADA!"
        GoButton.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    end)
end)
