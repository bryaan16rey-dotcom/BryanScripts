local Lucid = loadstring(game:HttpGet("https://raw.githubusercontent.com/Deaded-7/LucidLib/main/lucid.lua"))()

-- Crear la ventana principal
local Window = Lucid:CreateWindow({
    Name = "BRYAN SYSTEM V7",
    Keybind = Enum.KeyCode.LeftControl -- AQUÍ FORZAMOS EL CONTROL IZQUIERDO
})

-- Crear una pestaña
local MainTab = Window:CreateTab("Principal")

MainTab:CreateLabel("Presiona CONTROL IZQUIERDO para ocultar/mostrar")

-- Botón de prueba para ver que todo cargue bien
MainTab:CreateButton({
    Name = "Quitar Script",
    Callback = function()
        Window:Destroy()
    end
})

-- Notificación de inicio
print("Script de Bryan cargado. Usa LeftControl.")
