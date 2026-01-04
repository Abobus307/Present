local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local Folder = Workspace:WaitForChild("Presents", 10)
if not Folder then return end

local Enabled = false
local HRP

local function UpdateChar(char)
    HRP = char:WaitForChild("HumanoidRootPart", 10)
end

if LocalPlayer.Character then UpdateChar(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(UpdateChar)

local Gui = Instance.new("ScreenGui")
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Btn = Instance.new("TextButton")
Btn.Size = UDim2.new(0, 160, 0, 50)
Btn.Position = UDim2.new(0, 10, 0.5, 0)
Btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn.TextSize = 18
Btn.Text = "TP: OFF"
Btn.Parent = Gui
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

Btn.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    Btn.BackgroundColor3 = Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 0, 0)
    Btn.Text = Enabled and "TP: ON" or "TP: OFF"
end)

Folder.ChildAdded:Connect(function(child)
    if not Enabled then return end
    task.wait(0.05)
    
    if HRP and child.Parent then
        HRP.CFrame = child:GetPivot() + Vector3.new(0, 3, 0)
    end
end)
