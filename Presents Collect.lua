local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Vector3new = Vector3.new
local UDim2new = UDim2.new
local UDimnew = UDim.new
local Color3RGB = Color3.fromRGB
local Instancenew = Instance.new

local LocalPlayer = Players.LocalPlayer
local Folder = Workspace:WaitForChild("Presents", 10)
if not Folder then return end

local OFFSET = Vector3new(0, 3, 0)
local COLOR_ON = Color3RGB(0, 200, 0)
local COLOR_OFF = Color3RGB(255, 0, 0)

local Enabled = false
local HRP

local function OnCharacter(char)
    HRP = char:WaitForChild("HumanoidRootPart", 5)
end

if LocalPlayer.Character then
    task.spawn(OnCharacter, LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(OnCharacter)

local Gui = Instancenew("ScreenGui")
Gui.Name = "AutoTP"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer.PlayerGui

local Btn = Instancenew("TextButton")
Btn.Size = UDim2new(0, 160, 0, 50)
Btn.Position = UDim2new(0, 10, 0.5, 0)
Btn.BackgroundColor3 = COLOR_OFF
Btn.TextColor3 = Color3RGB(255, 255, 255)
Btn.Font = Enum.Font.SourceSansBold
Btn.TextSize = 18
Btn.Text = "TP: OFF"
Btn.Parent = Gui

Instancenew("UICorner", Btn).CornerRadius = UDimnew(0, 8)

Btn.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    Btn.BackgroundColor3 = Enabled and COLOR_ON or COLOR_OFF
    Btn.Text = Enabled and "TP: ON" or "TP: OFF"
end)

Folder.ChildAdded:Connect(function(child)
    if Enabled and HRP then
        HRP.CFrame = child:GetPivot() + OFFSET
    end
end)
