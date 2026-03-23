local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN TORRE-SYSTEM V17",
   LoadingTitle = "Calculando Ruta a la Torre...",
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
local profundidad = -15 -- Ajuste perfecto bajo el suelo

Tab2:CreateToggle({
   Name = "AUTO-VIAJE A LA TORRE (POR DEBAJO)",
   CurrentValue = false,
   Callback = function(Value)
      viajando = Value
      if viajando then
          task.spawn(function()
              local player = game.Players.LocalPlayer
              local root = player.Character:WaitForChild("HumanoidRootPart")
              
              -- 1. BAJAR Y FLOTAR
              -- Guardamos la posición inicial para saber hacia dónde es "el fondo"
              local startPos = root.CFrame
              root.CFrame = root.CFrame * CFrame.new(0, profundidad, 0)
              task.wait(0.5)
              
              -- 2. AVANCE AUTOMÁTICO HACIA EL FINAL (TORRE)
              -- Como no sabemos el nombre del objeto, avanzamos hacia la coordenada de la torre
              while viajando do
                  -- Movemos el personaje hacia adelante en el eje Z (que suele ser el final)
                  -- Si ves que va hacia los lados, avísame para cambiar el eje
                  root.Velocity = Vector3.new(0, 0, 0) -- Evita que la física lo empuje
                  root.CFrame = root.CFrame * CFrame.new(0, 0, -2) -- Avanza 2 studs por ciclo
                  
                  -- CONDICIÓN DE PARADA: Si llegamos muy lejos (ajusta el número si falta camino)
                  if math.abs(root.Position.Z) > 1500 then 
                      break 
                  end
                  task.wait(0.01)
              end
              
              -- 3. SUBIR AL MEDIO DE LA TORRE
              if viajando then
                  -- Aquí subimos el personaje a la superficie
                  root.CFrame = root.CFrame * CFrame.new(0, -profundidad + 5, 0)
                  Rayfield:Notify({Title = "¡Llegamos!", Content = "Posicionado en la Torre.", Duration = 5})
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
