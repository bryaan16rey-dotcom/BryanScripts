local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN FIX V20",
   LoadingTitle = "Reiniciando Sistemas...",
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

-- PESTAÑA 2: MISIONES (Ruta a la Torre)
local Tab2 = Window:CreateTab("Misiones", 4483362458)
local viajando = false

Tab2:CreateToggle({
   Name = "VIAJE RECTO A LA TORRE",
   CurrentValue = false,
   Callback = function(Value)
      viajando = Value
      if viajando then
          task.spawn(function()
              local p = game.Players.LocalPlayer
              local root = p.Character:WaitForChild("HumanoidRootPart")
              
              -- 1. BAJAR UN POQUITO (Al ras del suelo)
              root.CFrame = root.CFrame * CFrame.new(0, -2.5, 0)
              
              -- 2. FIJAR DIRECCIÓN (Hacia donde miras al activar)
              local direccionFija = root.CFrame
              
              -- 3. BUCLE DE MOVIMIENTO (Sin usar Velocity para evitar lag/crasheos)
              while viajando do
                  -- Movemos el CFrame directamente hacia adelante
                  root.CFrame = root.CFrame * CFrame.new(0, 0, -3)
                  
                  -- CONDICIÓN DE PARADA (Distancia acumulada)
                  -- Aumentamos el límite para llegar bien a la torre
                  if math.abs(root.Position.Z) > 2200 then break end
                  
                  task.wait(0.01)
              end
              
              -- 4. SUBIR AL LLEGAR
              if viajando then
                  root.CFrame = root.CFrame * CFrame.new(0, 4, 0)
                  Rayfield:Notify({Title = "Llegamos", Content = "Estás en la zona de la Torre.", Duration = 5})
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
