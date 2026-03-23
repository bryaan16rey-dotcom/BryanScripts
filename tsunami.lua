local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN FIX V15",
   LoadingTitle = "Modo Blindado...",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   Keybind = "LeftControl" 
})

-- PESTAÑA 1: INTERACCIÓN (La que te gusta)
local Tab1 = Window:CreateTab("Interacción", 4483362458)
local instantActivo = false

Tab1:CreateToggle({
   Name = "RECOJO INSTANTÁNEO (E)",
   CurrentValue = true,
   Callback = function(Value)
      instantActivo = Value
      if instantActivo then
          for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
              if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
          end
          _G.Conexion = game:GetService("Workspace").DescendantAdded:Connect(function(d)
              if instantActivo and d:IsA("ProximityPrompt") then d.HoldDuration = 0 end
          end)
      elseif _G.Conexion then
          _G.Conexion:Disconnect()
      end
   end,
})

-- PESTAÑA 2: SUPERVIVENCIA (MÉTODO ANTI-LAG)
local Tab2 = Window:CreateTab("Supervivencia", 4483362458)
local godMode = false

Tab2:CreateToggle({
   Name = "MODO INMORTAL (Sin Lag)",
   CurrentValue = false,
   Callback = function(Value)
      godMode = Value
      if godMode then
          task.spawn(function()
              while godMode do
                  local char = game.Players.LocalPlayer.Character
                  if char and char:FindFirstChild("Humanoid") then
                      -- 1. Mantenemos la vida al máximo
                      char.Humanoid.Health = 100
                      -- 2. Bloqueamos el estado de muerte
                      char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                  end
                  task.wait(0.1) -- Tiempo justo para no dar lag y ser rápido
              end
          end)
      end
   end,
})

-- BOTÓN DE CIERRE
local Tab3 = Window:CreateTab("Ajustes", 4483362458)
Tab3:CreateButton({
   Name = "Quitar Script",
   Callback = function()
       godMode = false
       instantActivo = false
       if _G.Conexion then _G.Conexion:Disconnect() end
       Rayfield:Destroy()
   end,
})
