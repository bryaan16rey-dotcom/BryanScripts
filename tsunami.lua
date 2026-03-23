local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN ELITE V12",
   LoadingTitle = "Activando Escudos...",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   Keybind = "LeftControl" 
})

-- PESTAÑA 1: INTERACCIÓN (Carga 0)
local Tab1 = Window:CreateTab("Interacción", 4483362458)
local instantActivo = false

Tab1:CreateToggle({
   Name = "RECOJO INSTANTÁNEO (Sin Lag)",
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

-- PESTAÑA 2: SUPERVIVENCIA (Anti-Tsunami)
local Tab2 = Window:CreateTab("Supervivencia", 4483362458)
local antiOlas = false

Tab2:CreateToggle({
   Name = "INMUNITAT A LAS OLAS",
   CurrentValue = false,
   Callback = function(Value)
      antiOlas = Value
      task.spawn(function()
          while antiOlas do
              -- Buscamos las partes que hacen daño (usualmente llamadas 'Water' o 'KillPart')
              -- Este código anula la colisión de daño con tu personaje
              pcall(function()
                  local char = game.Players.LocalPlayer.Character
                  if char then
                      for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
                          -- Detectamos si es agua o si tiene scripts de daño por contacto
                          if part:IsA("BasePart") and (part.Name == "Water" or part.Name == "Wave") then
                              part.CanTouch = false -- Aquí está el truco: la ola no te "siente"
                          end
                      end
                  end
              end)
              task.wait(5) -- Lo hace cada 5 segundos para no dar LAG
          end
      end)
   end,
})

-- BOTÓN DE CIERRE
local Tab3 = Window:CreateTab("Ajustes", 4483362458)
Tab3:CreateButton({
   Name = "Cerrar Script",
   Callback = function()
       instantActivo = false
       antiOlas = false
       if _G.Conexion then _G.Conexion:Disconnect() end
       Rayfield:Destroy()
   end,
})
