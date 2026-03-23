local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN 'AL RAS' V18",
   LoadingTitle = "Calculando Ruta Segura...",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   Keybind = "LeftControl" 
})

-- PESTAÑA 1: INTERACCIÓN
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

-- PESTAÑA 2: NAVEGACIÓN A LA TORRE
local Tab2 = Window:CreateTab("Navegación", 4483362458)
local viajando = false
local profundidadRas = -5 -- AJUSTE CRÍTICO: Profundidad mínima para no morir

Tab2:CreateToggle({
   Name = "AUTO-VIAJE 'AL RAS' A LA TORRE",
   CurrentValue = false,
   Callback = function(Value)
      viajando = Value
      if viajando then
          task.spawn(function()
              local player = game.Players.LocalPlayer
              local root = player.Character:WaitForChild("HumanoidRootPart")
              
              -- 1. BAJAR AL RAS (Flotación segura)
              root.CFrame = root.CFrame * CFrame.new(0, profundidadRas, 0)
              task.wait(0.3)
              
              -- 2. AVANCE AUTOMÁTICO HACIA EL FINAL
              while viajando do
                  -- Bloqueamos la física para que no se caiga ni suba solo
                  root.Velocity = Vector3.new(0, 0, 0) 
                  root.CFrame = root.CFrame * CFrame.new(0, 0, -3) -- Avanza un poco más rápido
                  
                  -- CONDICIÓN DE PARADA (Llegada a la zona oscura)
                  -- Si ves que se frena antes, sube este número
                  if math.abs(root.Position.Z) > 1700 then 
                      break 
                  end
                  task.wait(0.01)
              end
              
              -- 3. SUBIR AL MEDIO DE LA TORRE
              if viajando then
                  -- Subimos justo a la superficie
                  root.CFrame = root.CFrame * CFrame.new(0, -profundidadRas + 2, 0)
                  Rayfield:Notify({Title = "¡Llegamos!", Content = "Posicionado en el centro de la Torre.", Duration = 5})
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
       viajando = false
       instantActivo = false
       if _G.Conexion then _G.Conexion:Disconnect() end
       Rayfield:Destroy()
   end,
})
