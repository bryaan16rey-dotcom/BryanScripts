local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN GOD-SYSTEM V13",
   LoadingTitle = "Activando Protocolos...",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   Keybind = "LeftControl" 
})

-- SECCIÓN 1: INTERACCIÓN
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

-- SECCIÓN 2: SUPERVIVENCIA (INMORTAL)
local Tab2 = Window:CreateTab("Supervivencia", 4483362458)
local godMode = false

Tab2:CreateToggle({
   Name = "MODO DIOS (Inmune a Olas)",
   CurrentValue = false,
   Callback = function(Value)
      godMode = Value
      task.spawn(function()
          while godMode do
              pcall(function()
                  local char = game.Players.LocalPlayer.Character
                  if char and char:FindFirstChild("Humanoid") then
                      -- Si la vida baja de 100, la subimos al toque
                      if char.Humanoid.Health < 100 then
                          char.Humanoid.Health = 100
                      end
                  end
              end)
              task.wait() -- Muy rápido para que la ola no tenga tiempo de matarte
          end
      end)
   end,
})

-- BOTÓN DE CIERRE
local Tab3 = Window:CreateTab("Ajustes", 4483362458)
Tab3:CreateButton({
   Name = "Quitar Script",
   Callback = function()
       godMode = false
       instantActivo = false
       if _G.Conexion then _G.Conexion:Disconnect() end
       Rayfield:Destroy()
   end,
})
