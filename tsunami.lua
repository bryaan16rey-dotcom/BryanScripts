local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN FINAL V3", -- Nuevo nombre para forzar el reset
   LoadingTitle = "Reseteando Teclas...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {
      Enabled = false, -- Desactivamos el guardado para que no use la 'K'
      FolderName = "BryanReset" -- Nombre de carpeta nuevo para ignorar la vieja
   },
   KeySystem = false,
   Keybind = "LeftControl" -- TECLA: Control Izquierdo
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

-- 3. AJUSTES (Autodestrucción)
local SettingsTab = Window:CreateTab("Ajustes", 4483362458)

SettingsTab:CreateButton({
   Name = "QUITAR INTERFAZ COMPLETAMENTE",
   Callback = function()
       speedEnabled = false
       jumpEnabled = false
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
       Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "¡RESETEO EXITOSO!",
   Content = "Usa CTRL IZQUIERDO. La tecla K ha sido eliminada.",
   Duration = 5,
   Image = 4483362458,
})
