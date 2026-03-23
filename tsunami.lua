local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN SYSTEM V6 | UnderFarm",
   LoadingTitle = "Iniciando Navegación Segura...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false,
   Keybind = "K" 
})

local Tab = Window:CreateTab("Farm Subterráneo", 4483362458)

-- VARIABLES DE CONTROL
local farmActivo = false
local profundidad = 10 -- Distancia exacta bajo el suelo para evitar olas y no caer al vacío
local puntoSeguro = nil

-- 1. INTERRUPTOR DE AUTO-FARM (MODO SUBTERRÁNEO)
Tab:CreateToggle({
   Name = "Activar Farm Bajo Tierra",
   CurrentValue = false,
   Flag = "UnderFarm",
   Callback = function(Value)
      farmActivo = Value
      if farmActivo then
          puntoSeguro = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
          
          task.spawn(function()
              while farmActivo do
                  pcall(function()
                      local character = game.Players.LocalPlayer.Character
                      local root = character:WaitForChild("HumanoidRootPart")
                      
                      -- BUSCAR OBJETIVO
                      local objetivo = nil
                      local distanciaMinima = math.huge
                      
                      for _, item in pairs(game:GetService("Workspace").Items:GetChildren()) do
                          if item:IsA("BasePart") and item:FindFirstChild("TouchInterest") then
                              local distancia = (root.Position - item.Position).Magnitude
                              if distancia < distanciaMinima then
                                  distanciaMinima = distancia
                                  objetivo = item
                              end
                          end
                      end
                      
                      if objetivo then
                          -- FASE 1: BAJAR UN POCO (Para evitar olas)
                          root.CFrame = root.CFrame * CFrame.new(0, -profundidad, 0)
                          task.wait(0.1)
                          
                          -- FASE 2: MOVERSE POR DEBAJO HACIA EL ITEM
                          -- Calculamos la posición del item pero manteniendo nuestra profundidad
                          local posDebajo = CFrame.new(objetivo.Position.X, objetivo.Position.Y - profundidad, objetivo.Position.Z)
                          root.CFrame = posDebajo
                          task.wait(0.2)
                          
                          -- FASE 3: SUBIR, COGER Y VOLVER
                          root.CFrame = objetivo.CFrame -- Sube justo donde está el item
                          task.wait(0.3) -- Tiempo para que el "Recojo Instantáneo" actúe
                          
                          -- FASE 4: REGRESO RÁPIDO A BASE
                          if puntoSeguro then
                              root.CFrame = puntoSeguro
                          end
                      end
                  end)
                  task.wait(1) -- Espera entre cada recolección para no saturar
              end
          end)
      end
   end,
})

-- 2. RECOJO INSTANTÁNEO (E) - INDISPENSABLE PARA ESTE MODO
Tab:CreateToggle({
   Name = "Recojo Instantáneo (E)",
   CurrentValue = true,
   Flag = "InstantE",
   Callback = function(Value)
      _G.InstantE = Value
      task.spawn(function()
          while _G.InstantE do
              for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                  if v:IsA("ProximityPrompt") then
                      v.HoldDuration = 0
                  end
              end
              task.wait(1)
          end
      end)
   end,
})

-- AJUSTES FINALES
local TabSet = Window:CreateTab("Ajustes", 4483362458)

TabSet:CreateSlider({
   Name = "Profundidad Bajo Suelo",
   Range = {5, 20},
   Increment = 1,
   CurrentValue = 10,
   Callback = function(Value)
      profundidad = Value
   end,
})

TabSet:CreateButton({
   Name = "QUITAR TODO EL HACK",
   Callback = function()
      farmActivo = false
      _G.InstantE = false
      Rayfield:Destroy()
   end,
})
