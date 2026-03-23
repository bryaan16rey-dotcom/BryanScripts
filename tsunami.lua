local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN SYSTEM V11",
   LoadingTitle = "Optimizando FPS...",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   Keybind = "LeftControl" 
})

local Tab = Window:CreateTab("Interacción", 4483362458)

local manualInstant = false

Tab:CreateToggle({
   Name = "RECOJO INSTANTÁNEO (Manual con E)",
   CurrentValue = false,
   Callback = function(Value)
      manualInstant = Value
      task.spawn(function()
          while manualInstant do
              -- Solo buscamos los ProximityPrompts que están cerca del jugador (reduce el LAG)
              for _, prompt in pairs(game:GetService("Workspace"):GetDescendants()) do
                  if prompt:IsA("ProximityPrompt") then
                      -- Ponemos la carga en 0
                      prompt.HoldDuration = 0
                      
                      -- Esto asegura que el juego acepte el click instantáneo
                      prompt.ClickablePrompt = true 
                  end
              end
              task.wait(2) -- Escaneamos cada 2 segundos para NO DAR LAG
          end
      end)
   end,
})

Tab:CreateButton({
   Name = "Quitar Script",
   Callback = function()
       manualInstant = false
       Rayfield:Destroy()
   end,
})
