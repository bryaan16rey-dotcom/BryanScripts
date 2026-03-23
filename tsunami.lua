local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- GENERAR LA VENTANA
local Window = Rayfield:CreateWindow({
   Name = "BRYAN SYSTEM V8 | FINAL",
   LoadingTitle = "Cargando Sistema...",
   LoadingSubtitle = "by Bryan Rafael",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false,
   Keybind = "None" -- Desactivamos la tecla de la librería para que no moleste
})

local Tab = Window:CreateTab("Inicio", 4483362458)
Tab:CreateLabel("Si el Control no funciona, avisame para cambiar la tecla.")

-- === SISTEMA MANUAL DE ABRIR/CERRAR (FORZADO) ===
local UserInputService = game:GetService("UserInputService")
local visible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- Detecta si presionas CONTROL IZQUIERDO o CONTROL DERECHO
    if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
        visible = not visible
        -- Buscamos la interfaz de Rayfield en el juego para esconderla
        local gui = game:GetService("CoreGui"):FindFirstChild("Rayfield") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Rayfield")
        if gui then
            gui.Enabled = visible
        end
    end
end)

-- Botón para quitar el script
Tab:CreateButton({
   Name = "Quitar Script",
   Callback = function()
       Rayfield:Destroy()
   end
})
