local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN FAST-E",
   LoadingTitle = "Optimizando Recolección...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   KeySystem = false,
   Keybind = "LeftControl" 
})

local Tab = Window:CreateTab("Interacción", 4483362458)

-- FUNCIÓN MAESTRA DE RECOJO 0 SEGUNDOS
local fastEEnabled = false

Tab:CreateToggle({
   Name = "RECOJO INSTANTÁNEO (Carga 0)",
   CurrentValue = false,
   Callback = function(Value)
      fastEEnabled = Value
      task.spawn(function()
          while fastEEnabled do
              -- Buscamos todos los prompts de "E" en el juego
              for _, prompt in pairs(game:GetService("Workspace"):GetDescendants()) do
                  if prompt:IsA("ProximityPrompt") then
                      prompt.HoldDuration = 0 -- Tiempo de carga a cero
                      -- Opcional: Esto hace que se active a más distancia
                      -- prompt.MaxActivationDistance = 20 
                  end
              end
              task.wait(0.5) -- Escanea el mapa cada medio segundo por nuevos objetos
          end
      end)
   end,
})

-- BOTÓN DE CIERRE
Tab:CreateButton({
   Name = "Quitar Script",
   Callback = function()
       fastEEnabled = false
       Rayfield:Destroy()
   end
})
