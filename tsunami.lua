local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN SYSTEM V1 | Tsunami",
   LoadingTitle = "Cargando Interfaz...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BryanScripts"
   },
   KeySystem = false -- Sin sistema de llaves para que entres directo
})

local Tab = Window:CreateTab("Principal", 4483362458) -- Icono de casa

-- SLIDER PARA CONTROLAR LA VELOCIDAD
local Slider = Tab:CreateSlider({
   Name = "Velocidad de Caminado",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Velocidad",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
          game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- BOTÓN PARA SALTO INFINITO
local Button = Tab:CreateButton({
   Name = "Activar Salto Infinito",
   Callback = function()
       _G.InfJump = true
       local UserInputService = game:GetService("UserInputService")
       
       -- Esta función permite saltar en el aire detectando cada vez que pides un salto
       UserInputService.JumpRequest:Connect(function()
           if _G.InfJump then
               local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
               if humanoid then
                   humanoid:ChangeState("Jumping")
               end
           end
       end)

       -- Notificación de éxito
       Rayfield:Notify({
          Title = "Sistema Bryan",
          Content = "Salto Infinito Activado con éxito",
          Duration = 4,
          Image = 4483362458,
       })
   end,
})

-- BOTÓN PARA CERRAR EL MENÚ
local Button2 = Tab:CreateButton({
   Name = "Cerrar Menú",
   Callback = function()
       Rayfield:Destroy()
   end,
})

-- Mensaje de Bienvenida al ejecutar
Rayfield:Notify({
   Title = "Bienvenido Bryan",
   Content = "Script cargado para Escapa del Tsunami",
   Duration = 5,
   Image = 4483362458,
})
