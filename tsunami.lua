local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN BLINDADO V19",
   LoadingTitle = "Calculando Ruta Fija...",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   Keybind = "LeftControl" 
})

-- PESTAÑA 1: INTERACCIÓN (Carga 0)
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

-- PESTAÑA 2: MISIONES (Túnel Recto Fijo)
local Tab2 = Window:CreateTab("Misiones", 4483362458)
local viajando = false
local profundidadSafe = -2 -- AJUSTE PERFECTO: Solo para estar por debajo del suelo sin morir

Tab2:CreateToggle({
   Name = "VIAJE SUBTERRÁNEO RECTO A LA TORRE",
   CurrentValue = false,
   Callback = function(Value)
      viajando = Value
      if viajando then
          task.spawn(function()
              local player = game.Players.LocalPlayer
              local root = player.Character:WaitForChild("HumanoidRootPart")
              local humanoid = player.Character:WaitForChild("Humanoid")
              
              -- 1. BAJAR AL RAS (Flotación segura y rápida)
              root.CFrame = root.CFrame * CFrame.new(0, profundidadSafe, 0)
              task.wait(0.2)
              
              -- 2. BLOQUEO DE DIRECCIÓN FIJA HACIA LA TORRE
              -- Calculamos la dirección del fondo basándonos en tu posición inicial
              local final_target = root.CFrame * CFrame.new(0, 0, -5000) -- Apuntamos lejos al fondo
              local look_at_target = CFrame.lookAt(root.Position, Vector3.new(final_target.X, root.Position.Y, final_target.Z))
              root.CFrame = look_at_target -- Giramos el personaje hacia la torre una sola vez
              
              -- 3. VIAJE AUTOMÁTICO EN LÍNEA RECTA
              while viajando do
                  -- Usamos LinearVelocity para un movimiento recto y sin lag
                  root.Velocity = root.CFrame.LookVector * 150 -- Velocidad de viaje
                  
                  -- CONDICIÓN DE PARADA: Distancia de la Torre (Aumentando poco a poco)
                  -- Si ves que se frena antes de la zona oscura, avísame para subir el 1900
                  if math.abs(root.Position.Z) > 1900 then 
                      break 
                  end
                  task.wait(0.01)
              end
              
              -- 4. DETENERSE Y SUBIR
              if viajando then
                  root.Velocity = Vector3.new(0,0,0) -- Detenemos el personaje
                  root.CFrame = root.CFrame * CFrame.new(0, -profundidadSafe + 2, 0) -- Subimos a la superficie
                  Rayfield:Notify({Title = "¡Misión Cumplida!", Content = "Posicionado en el centro de la Torre.", Duration = 5})
              end
          end)
      else
          -- Si apagas el toggle, detenemos el personaje
          local char = game.Players.LocalPlayer.Character
          if char and char:FindFirstChild("HumanoidRootPart") then
              char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
          end
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
