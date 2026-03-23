local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN SYSTEM V16",
   LoadingTitle = "Iniciando Túnel Seguro...",
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

-- PESTAÑA 2: NAVEGACIÓN (Túnel Automático)
local Tab2 = Window:CreateTab("Misiones", 4483362458)
local viajando = false

Tab2:CreateToggle({
   Name = "VIAJE SUBTERRÁNEO A LA TORRE",
   CurrentValue = false,
   Callback = function(Value)
      viajando = Value
      if viajando then
          task.spawn(function()
              local player = game.Players.LocalPlayer
              local root = player.Character:WaitForChild("HumanoidRootPart")
              
              -- 1. BAJAR AL SÓTANO (Profundidad segura)
              root.CFrame = root.CFrame * CFrame.new(0, -15, 0)
              task.wait(0.5)
              
              -- 2. BUSCAR LA TORRE (Final del mapa)
              -- Buscamos un objeto que se llame 'Tower', 'Finish' o el más lejano
              local meta = game:GetService("Workspace"):FindFirstChild("Tower") or game:GetService("Workspace"):FindFirstChild("Finish")
              
              if meta then
                  -- VIAJAR POR DEBAJO (Interpolación suave para evitar lag)
                  while viajando and (root.Position - meta.Position).Magnitude > 10 do
                      local direccion = (meta.Position - root.Position).Unit
                      root.CFrame = CFrame.new(root.Position + (direccion * 2)) * CFrame.Angles(0,0,0)
                      task.wait(0.01)
                  end
                  
                  -- 3. SUBIR A LA SUPERFICIE AL LLEGAR
                  if viajando then
                      root.CFrame = meta.CFrame + Vector3.new(0, 5, 0)
                      Rayfield:Notify({Title = "¡Llegamos!", Content = "Ya estás en la torre a salvo.", Duration = 5})
                  end
              else
                  Rayfield:Notify({Title = "Error", Content = "No encontré la Torre. Muévete manualmente bajo tierra.", Duration = 5})
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
