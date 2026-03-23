local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN V21 | ESTABLE",
   LoadingTitle = "Cargando Interfaz...",
   ConfigurationSaving = {Enabled = false}, -- Desactivado temporalmente para evitar conflictos de archivos viejos
   Keybind = "LeftControl" 
})

-- PESTAÑA: PRINCIPAL
local Tab = Window:CreateTab("Funciones", 4483362458)

-- 1. RECOJO INSTANTÁNEO
local instantE = false
Tab:CreateToggle({
   Name = "RECOJO INSTANTÁNEO (E)",
   CurrentValue = true,
   Callback = function(Value)
      instantE = Value
      task.spawn(function()
          while instantE do
              for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                  if v:IsA("ProximityPrompt") then
                      v.HoldDuration = 0
                  end
              end
              task.wait(2) -- Escaneo lento para evitar LAG
          end
      end)
   end,
})

-- 2. VIAJE A LA TORRE (AL RAS)
local viajando = false
Tab:CreateToggle({
   Name = "AUTO-VIAJE A LA TORRE",
   CurrentValue = false,
   Callback = function(Value)
      viajando = Value
      if viajando then
          task.spawn(function()
              local p = game.Players.LocalPlayer
              local root = p.Character:WaitForChild("HumanoidRootPart")
              
              -- BAJAR UN POQUITO (Solo 2 studs para no morir)
              root.CFrame = root.CFrame * CFrame.new(0, -2.5, 0)
              task.wait(0.2)
              
              -- BUCLE DE MOVIMIENTO
              while viajando do
                  -- Movimiento constante hacia adelante
                  root.CFrame = root.CFrame * CFrame.new(0, 0, -3)
                  
                  -- Verificación de parada (Distancia a la torre)
                  if math.abs(root.Position.Z) > 2200 then break end
                  
                  task.wait(0.01)
              end
              
              -- SUBIR AL LLEGAR
              if viajando then
                  root.CFrame = root.CFrame * CFrame.new(0, 4, 0)
                  Rayfield:Notify({Title = "Llegamos", Content = "Ya estás en la torre.", Duration = 5})
              end
          end)
      end
   end,
})

-- BOTÓN DE CIERRE SEGURO
Tab:CreateButton({
   Name = "Quitar Script",
   Callback = function()
       viajando = false
       instantE = false
       Rayfield:Destroy()
   end,
})
