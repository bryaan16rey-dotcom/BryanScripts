local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "CONTROL TEST | BRYAN",
   LoadingTitle = "Probando Tecla Control...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BryanControlFix" -- Nombre nuevo para resetear la memoria
   },
   KeySystem = false,
   Keybind = "LeftControl" -- ESTA ES LA TECLA OBJETIVO
})

local Tab = Window:CreateTab("Inicio", 4483362458)

Tab:CreateLabel("Si ves esto, presiona el CONTROL IZQUIERDO para cerrar/abrir")

Tab:CreateButton({
   Name = "Cerrar Script por completo",
   Callback = function()
       Rayfield:Destroy()
   end,
})
