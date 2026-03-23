local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRYAN FPS-BOOST",
   LoadingTitle = "Modo Rendimiento Activo",
   ConfigurationSaving = {Enabled = true, FolderName = "BryanScripts"},
   Keybind = "LeftControl" 
})

local Tab = Window:CreateTab("Interacción", 4483362458)

local instantActivo = false

-- Función optimizada: Solo cambia el objeto si es necesario
local function optimizarPrompt(prompt)
    if prompt:IsA("ProximityPrompt") and prompt.HoldDuration > 0 then
        prompt.HoldDuration = 0
    end
end

Tab:CreateToggle({
   Name = "RECOJO INSTANTÁNEO (SIN LAG)",
   CurrentValue = false,
   Callback = function(Value)
      instantActivo = Value
      
      if instantActivo then
          -- REGLA 1: Corregir los que ya existen en el mapa una sola vez
          for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
              optimizarPrompt(v)
          end
          
          -- REGLA 2: Escuchar cuando aparezcan nuevos (Sin bucles infinitos)
          _G.Conexion = game:GetService("Workspace").DescendantAdded:Connect(function(descendant)
              if instantActivo then
                  optimizarPrompt(descendant)
              end
          end)
      else
          -- Si se apaga, desconectamos el evento para liberar memoria
          if _G.Conexion then
              _G.Conexion:Disconnect()
          end
      end
   end,
})

Tab:CreateButton({
   Name = "Cerrar y Limpiar Script",
   Callback = function()
       instantActivo = false
       if _G.Conexion then _G.Conexion:Disconnect() end
       Rayfield:Destroy()
   end,
})
