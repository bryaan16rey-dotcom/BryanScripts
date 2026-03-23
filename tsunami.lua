local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN ELITE V9",
   LoadingTitle = "Cargando Sistema Pro...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"}, -- Dejamos esto activo para que guarde tu cambio de tecla
   KeySystem = false,
   Keybind = "LeftControl" 
})

local Tab = Window:CreateTab("Auto-Farm", 4483362458)

local farmActivo = false
local profundidad = 10

Tab:CreateToggle({
   Name = "Farm Subterráneo (Anti-Olas)",
   CurrentValue = false,
   Callback = function(Value)
      farmActivo = Value
      task.spawn(function()
          while farmActivo do
              pcall(function()
                  local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                  local objetivo = nil
                  local dist = math.huge
                  
                  for _, item in pairs(game:GetService("Workspace").Items:GetChildren()) do
                      if item:IsA("BasePart") and item:FindFirstChild("TouchInterest") then
                          local d = (root.Position - item.Position).Magnitude
                          if d < dist then dist = d; objetivo = item end
                      end
                  end
                  
                  if objetivo then
                      local basePos = root.CFrame
                      -- Baja, recoge y vuelve
                      root.CFrame = root.CFrame * CFrame.new(0, -profundidad, 0)
                      task.wait(0.1)
                      root.CFrame = CFrame.new(objetivo.Position.X, objetivo.Position.Y - profundidad, objetivo.Position.Z)
                      task.wait(0.1)
                      root.CFrame = objetivo.CFrame
                      task.wait(0.2)
                      root.CFrame = basePos
                  end
              end)
              task.wait(0.5)
          end
      end)
   end,
})

local Tab2 = Window:CreateTab("Mejoras", 4483362458)

Tab2:CreateToggle({
   Name = "Recojo Instantáneo (E)",
   CurrentValue = true,
   Callback = function(Value)
      _G.FastE = Value
      task.spawn(function()
          while _G.FastE do
              for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                  if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
              end
              task.wait(1)
          end
      end)
   end,
})

Tab2:CreateSlider({
   Name = "Velocidad",
   Range = {16, 150},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end,
})
