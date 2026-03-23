local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN SYSTEM V1",
   LoadingTitle = "Cargando Interfaz...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false,
   Keybind = "LeftControl" -- AQUÍ: Ahora es Control Izquierdo
})

local Tab = Window:CreateTab("Habilidades", 4483362458)

-- 1. VELOCIDAD
local speedEnabled = false
Tab:CreateToggle({
   Name = "Activar Súper Velocidad",
   CurrentValue = false,
   Flag = "ToggleSpeed", 
   Callback = function(Value)
      speedEnabled = Value
      if not speedEnabled then
          game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
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

-- 2. SALTO INFINITO
local jumpEnabled = false
Tab:CreateToggle({
   Name = "Activar Salto Infinito",
   CurrentValue = false,
   Flag = "ToggleJump",
   Callback = function(Value)
      jumpEnabled = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if jumpEnabled then
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState("Jumping")
        end
    end
end)

-- 3. SECCIÓN DE CONFIGURACIÓN (PARA CERRAR TODO)
local SettingsTab = Window:CreateTab("Ajustes", 4483362458)

SettingsTab:CreateButton({
   Name = "QUITAR INTERFAZ COMPLETAMENTE",
   Callback = function()
       -- Esto borra la interfaz y detiene las funciones
       speedEnabled = false
       jumpEnabled = false
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
       Rayfield:Destroy()
   end,
})

-- Notificación de Bienvenida
Rayfield:Notify({
   Title = "Sistema Bryan Listo",
   Content = "Usa 'CTRL IZQUIERDO' para ocultar/mostrar.",
   Duration = 5,
   Image = 4483362458,
})
