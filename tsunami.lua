local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN ULTRA-INSTANT",
   LoadingTitle = "Forzando Interacción...",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   Keybind = "LeftControl" 
})

local Tab = Window:CreateTab("Interacción", 4483362458)

local forceEnabled = false

Tab:CreateToggle({
   Name = "FORZAR RECOJO (INSTANTÁNEO)",
   CurrentValue = false,
   Callback = function(Value)
      forceEnabled = Value
      task.spawn(function()
          while forceEnabled do
              pcall(function()
                  local player = game.Players.LocalPlayer
                  local character = player.Character
                  if character and character:FindFirstChild("HumanoidRootPart") then
                      -- Buscamos todos los prompts de interacción
                      for _, prompt in pairs(game:GetService("Workspace"):GetDescendants()) do
                          if prompt:IsA("ProximityPrompt") then
                              -- 1. Quitamos la duración visualmente
                              prompt.HoldDuration = 0
                              
                              -- 2. SI ESTÁS CERCA, FORZAMOS LA ACTIVACIÓN (Simula la E al instante)
                              local distance = (character.HumanoidRootPart.Position - prompt.Parent.Position).Magnitude
                              if distance <= prompt.MaxActivationDistance then
                                  fireproximityprompt(prompt) -- Esta es la línea mágica
                              end
                          end
                      end
                  end
              end)
              task.wait(0.1) -- Escaneo súper rápido
          end
      end)
   end,
})

Tab:CreateButton({
   Name = "Cerrar Script",
   Callback = function()
       forceEnabled = false
       Rayfield:Destroy()
   end,
})
