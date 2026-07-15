local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Tussi Predatory v1 | Deadshot Edition",
   LoadingTitle = "Cargando Tussi Predatory...",
   LoadingSubtitle = "Por Bryan",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TussiPredatoryConfig",
      FileName = "TussiPredatory"
   },
   Theme = "DarkBlue"
})

-- Pestañas
local PlayerTab = Window:CreateTab("Player        ", 4483362456)
local Mundo1Tab = Window:CreateTab("Mundo 1        ", 4483362456)
local Mundo2Tab = Window:CreateTab("Mundo 2        ", 4483362456)

-- SECCIÓN PLAYER
PlayerTab:CreateSection("Movement")
PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 1000},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end,
})

PlayerTab:CreateSection("Utilidad Aérea")
local flying = false
local speed = 50
local hb = game:GetService("RunService").Heartbeat

PlayerTab:CreateToggle({
   Name = "Fly (Volar)",
   CurrentValue = false,
   Callback = function(Value)
      flying = Value
      local char = game.Players.LocalPlayer.Character
      local root = char and char:FindFirstChild("HumanoidRootPart")
      if flying and root then
         local bv = Instance.new("BodyVelocity", root)
         bv.Name = "FlyVelocity"
         bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
         bv.Velocity = Vector3.new(0, 0, 0)
         local bg = Instance.new("BodyGyro", root)
         bg.Name = "FlyGyro"
         bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
         bg.CFrame = root.CFrame
         spawn(function()
            while flying do
               local moveDir = Vector3.new(0, 0, 0)
               local cam = workspace.CurrentCamera.CFrame.LookVector
               local UIS = game:GetService("UserInputService")
               if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam end
               if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam end
               if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector end
               if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector end
               bv.Velocity = moveDir * speed
               hb:Wait()
            end
         end)
      elseif root then
         if root:FindFirstChild("FlyVelocity") then root.FlyVelocity:Destroy() end
         if root:FindFirstChild("FlyGyro") then root.FlyGyro:Destroy() end
      end
   end,
})

PlayerTab:CreateSlider({
   Name = "Velocidad de Vuelo",
   Range = {10, 200},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(Value) speed = Value end,
})

-- SECCIÓN MUNDO 1
Mundo1Tab:CreateSection("Teleports Mundo 1")
local listaNivelesM1 = {
    {name = "Home", pos = Vector3.new(-19, 5, -255)},
    {name = "Nivel 10", pos = Vector3.new(-22, 5, -3961)},
    {name = "Nivel 9", pos = Vector3.new(-14, 5, -3766)},
    {name = "Nivel 8", pos = Vector3.new(-21, 5, -3226)},
    {name = "Nivel 7", pos = Vector3.new(-22, 5, -2733)},
    {name = "Nivel 6", pos = Vector3.new(-16, 5, -2243)},
    {name = "Nivel 5", pos = Vector3.new(-18, 5, -1969)},
    {name = "Nivel 4", pos = Vector3.new(-19, 5, -1342)},
    {name = "Nivel 3", pos = Vector3.new(-18, 5, -1045)},
    {name = "Nivel 2", pos = Vector3.new(-19, 5, -749)},
    {name = "Nivel 1", pos = Vector3.new(-20, 5, -395)}
}

for _, v in pairs(listaNivelesM1) do
    Mundo1Tab:CreateButton({
        Name = "Ir a " .. v.name,
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(v.pos)
            end
        end,
    })
end

-- SECCIÓN MUNDO 2
Mundo2Tab:CreateSection("Teleports Mundo 2")
local listaNivelesM2 = {
    {name = "Home", pos = Vector3.new(117.26, 4.62, -528.58), rotate = true},
    {name = "Nivel 1", pos = Vector3.new(120.42, 4.62, -928.81)},
    {name = "Nivel 2", pos = Vector3.new(119.21, 4.62, -1334.35)},
    {name = "Nivel 3", pos = Vector3.new(118.94, 4.62, -1749.71)},
    {name = "Nivel 4", pos = Vector3.new(118.08, -3.87, -2309.20)}
}

for _, v in pairs(listaNivelesM2) do
    Mundo2Tab:CreateButton({
        Name = "Ir a " .. v.name,
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local newCFrame = CFrame.new(v.pos)
                if v.rotate then
                    newCFrame = newCFrame * CFrame.Angles(0, math.rad(180), 0)
                end
                char.HumanoidRootPart.CFrame = newCFrame
            end
        end,
    })
end

Mundo2Tab:CreateSection("Utilidad")
Mundo2Tab:CreateButton({
    Name = "Reset Character",
    Callback = function() game.Players.LocalPlayer.Character:BreakJoints() end,
})
