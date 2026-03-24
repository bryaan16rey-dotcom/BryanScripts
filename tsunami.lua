-- V107: CLON TOTAL EJE FIJO (BRYAN MAESTRO)
-- Borra todo lo anterior en tu GitHub y pega esto:

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StartBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- CONFIGURACIÓN DE LA VENTANA (PARA QUE SE VEA PROFESIONAL EN EL LIVE)
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "BryanClonOsaka"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- Puedes moverlo con el mouse

local corner = Instance.new("UICorner", MainFrame)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "BRYAN V107"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextSize = 18

-- BOTÓN DE INICIO (ESTILO OSAKA)
StartBtn.Parent = MainFrame
StartBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
StartBtn.Size = UDim2.new(0.8, 0, 0.25, 0)
StartBtn.Text = "INICIAR CARRIL 2"
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", StartBtn)

-- BOTÓN CERRAR
CloseBtn.Parent = MainFrame
CloseBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
CloseBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
CloseBtn.Text = "ELIMINAR UI"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CloseBtn)

-- LÓGICA DE VIAJE (COPIA EXACTA DE MOVIMIENTO)
StartBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    local hum = character:WaitForChild("Humanoid")
    
    -- ESTO ES LO QUE QUERÍAS: PUNTO A Y CARRIL 2 FIJOS
    -- Tomamos la Z actual (ponte en el 2 antes de darle click)
