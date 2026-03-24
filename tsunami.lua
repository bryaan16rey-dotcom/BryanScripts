--[[
    BryanScripts - Tsunami Escape Brainrot Edition
    Actualizado con: Puntos A/B, Grietas Inmunes y Sistema de Traslado
]]

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StartButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- CONFIGURACIÓN DE DATOS (Basado en nuestro mapa)
local PUNTO_A = Vector3.new(0, 5, 0)      -- Coordenada de las Casas
local PUNTO_B_Z = 5000                   -- Distancia de la Torre
local NIVEL_GRIETA = -8                  -- Profundidad para ver solo la cabeza
local enTraslado = false

-- PROPIEDADES DE LA INTERFAZ (Siguiendo tu estilo)
ScreenGui.Parent = game.CoreGui -- Para que no se borre al morir
MainFrame.Name = "BryanTraslado"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -75)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "BRYAN SCRIPTS v2"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

StatusLabel.Parent = MainFrame
StatusLabel.Text = "Esperando Inicio..."
StatusLabel.Position = UDim2.new(0, 0, 0.25, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)

-- BOTÓN PARA INICIAR EL TRASLADO
StartButton.Parent = MainFrame
StartButton.Name = "Start"
StartButton.Text = "INICIAR TRASLADO"
StartButton.Position = UDim2.new(0.1, 0, 0.5, 0)
StartButton.Size = UDim2.new(0.8, 0, 0, 40)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- BOTÓN CERRAR
CloseButton.Parent = MainFrame
CloseButton.Text = "CERRAR"
CloseButton.Position = UDim2.new(0.1, 0, 0.8, 0)
CloseButton.Size = UDim2.new(0.8, 0, 0, 25)
CloseButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- LÓGICA DE MOVIMIENTO Y SUPERVIVENCIA
StartButton.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(PUNTO_A) -- Teletransporte a las casas
        enTraslado = true
        StatusLabel.Text = "TRASLADO ACTIVO 🏃"
        print("Traslado iniciado: Punto A -> Punto B")
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- BUCLE DE SEGUIMIENTO (PROGRESO Y GRIETAS)
game:GetService("RunService").RenderStepped:Connect(function()
    if enTraslado then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos = char.HumanoidRootPart.Position
            local progreso = math.clamp((pos.Z / PUNTO_B_Z) * 100, 0, 100)
            
            -- Lógica de la Grieta (Inmunidad visual)
            if pos.Y <= NIVEL_GRIETA then
                StatusLabel.Text = "🛡️ MODO GRIETA: A SALVO"
                StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
            else
                StatusLabel.Text = string.format("PROGRESO: %.1f%%", progreso)
                StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
            
            if progreso >= 100 then
                StatusLabel.Text = "¡LLEGASTE A LA TORRE! 🏰"
                enTraslado = false
            end
        end
    end
end)
