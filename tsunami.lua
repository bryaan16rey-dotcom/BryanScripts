local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN SAFE V22",
   LoadingTitle = "Modo Seguro Activo",
   ConfigurationSaving = {Enabled = false}, -- Esto evita conflictos con archivos viejos
   Keybind = "LeftControl" 
})

local Tab = Window:CreateTab("Principal", 4483362458)

-- 1. RECOJO INSTANTÁNEO
local instantE = false
Tab:CreateToggle({
   Name = "RECOJO INSTANTÁNEO (E)",
   CurrentValue = true,
   Callback = function(Value)
      instantE = Value
      task.spawn(function()
          while instantE do
              pcall(function()
                  for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                      if v:IsA("ProximityPrompt") then
                          v.HoldDuration = 0
                      end
                  end
              end)
              task.wait(2)
          end
      end)
   end,
})

-- 2. VIAJE A LA TORRE (AJUSTADO)
local viajando = false
Tab:CreateToggle({
   Name = "VIAJE RECTO A LA TORRE",
   CurrentValue = false,
   Callback = function(Value)
      viajando = Value
      if viajando then
          task.spawn(function()
              local p = game.Players.LocalPlayer
              local root = p.Character:WaitForChild("HumanoidRootPart")
              
              -- BAJAR AL RAS (-1.5 es casi el suelo, muy seguro)
              root.CFrame = root.CFrame * CFrame.new(0, -1.8, 0)
              
              while viajando do
                  -- Movimiento por CFrame (No da lag)
                  root.CFrame = root.CFrame * CFrame.new(0, 0, -3)
                  
                  -- DISTANCIA: Aumentamos a 2500 para asegurar que llegues al fondo
                  if math.abs(root.Position.Z) > 2500 then break end
                  
                  task.wait(0.01)
              end
              
              if viajando then
                  root.CFrame = root.CFrame * CFrame.new(0, 3.5, 0)
                  Rayfield:Notify({Title = "Llegamos", Content = "En la zona oscura de la Torre", Duration = 5})
              end
          end)
      end
   end,
})

Tab:CreateButton({
   Name = "Cerrar Todo",
   Callback = function()
       viajando = false
       instantE = false
       Rayfield:Destroy()
   end,
})
