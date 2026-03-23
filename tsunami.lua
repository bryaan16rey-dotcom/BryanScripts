local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN ELITE V14",
   LoadingTitle = "Protocolo Inmortal...",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   Keybind = "LeftControl" 
})

-- PESTAÑA 1: INTERACCIÓN (La que ya te funciona bien)
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

-- PESTAÑA 2: SUPERVIVENCIA (GOD MODE REAL)
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
                  if char then
                      -- TRUCO MAESTRO: Desactivamos la capacidad de morir
                      if char:FindFirstChild("Humanoid") then
                          char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                          if char.Humanoid.Health < 1 then
                              char.Humanoid.Health = 100
                          end
                      end
                      -- Quitamos el toque de las olas si aparecen
                      for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                          if v:IsA("BasePart") and (v.Name:lower():find("water") or v.Name:lower():find("wave")) then
                              v.CanTouch = false
                          end
                      end
                  end
              end)
              task.wait(1)
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
       local char = game.Players.LocalPlayer.Character
       if char and char:FindFirstChild("Humanoid") then
           char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
       end
       Rayfield:Destroy()
   end,
})
