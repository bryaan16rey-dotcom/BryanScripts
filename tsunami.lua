local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN SYSTEM V1",
   LoadingTitle = "Cargando Interfaz...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false,
   Keybind = "LeftControl" -- ESTA ES LA TECLA PARA ABRIR/CERRAR (Control Izquierdo)
})

local Tab = Window:CreateTab("Habilidades", 4483362458)

-- 1. SECCIÓN DE VELOCIDAD (Con Toggle de Activar/Desactivar)
local speedEnabled = false
Tab:CreateToggle({
   Name = "Activar Súper Velocidad",
   CurrentValue = false,
   Flag = "ToggleSpeed", 
   Callback = function(Value)
      speedEnabled = Value
      if not speedEnabled then
          game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- Vuelve a lo normal
      end
   end,
})

Tab:CreateSlider({
   Name = "Ajustar Velocidad",
   Range = {16, 250},
   Increment = 1,
   Suffix = "Vel",
   CurrentValue = 50,
   Flag = "SliderSpeed",
   Callback = function(Value)
      if speedEnabled then
          game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- 2. SECCIÓN DE SALTO (Con Toggle de Activar/Desactivar)
local jumpEnabled = false
Tab:CreateToggle({
   Name = "Activar Salto Infinito",
   CurrentValue = false,
   Flag = "ToggleJump",
   Callback = function(Value)
      jumpEnabled = Value
   end,
})

-- Lógica del Salto (se queda corriendo de fondo pero solo funciona si el Toggle está ON)
game:GetService("UserInputService").JumpRequest:Connect(function()
    if jumpEnabled then
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState("Jumping")
        end
    end
end)

-- Notificación de Bienvenida
Rayfield:Notify({
   Title = "Sistema Listo",
   Content = "Presiona 'CTRL' para ocultar el menú",
   Duration = 5,
   Image = 4483362458,
})
