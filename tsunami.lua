local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN SYSTEM V10",
   LoadingTitle = "Optimizando Interacción...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BryanScripts"
   },
   KeySystem = false,
   Keybind = "LeftControl" 
})

local Tab = Window:CreateTab("Interacción", 4483362458)

-- FUNCIÓN PARA CARGA 0
local instantEnabled = false

Tab:CreateToggle({
   Name = "RECOJO INSTANTÁNEO (Carga 0)",
   CurrentValue = false,
   Callback = function(Value)
      instantEnabled = Value
      task.spawn(function()
          while instantEnabled do
              -- Buscamos todos los prompts de "E" en el juego y bajamos la carga a 0
              for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                  if v:IsA("ProximityPrompt") then
                      v.HoldDuration = 0
                  end
              end
              task.wait(0.5) -- Escaneo constante para nuevos objetos que aparezcan
          end
      end)
   end,
})

-- BOTÓN PARA CERRAR EL SCRIPT
Tab:CreateButton({
   Name = "Quitar Interfaz",
   Callback = function()
       instantEnabled = false
       Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "Sistema Bryan Listo",
   Content = "Activa el Toggle para carga 0.",
   Duration = 5,
   Image = 4483362458,
})
