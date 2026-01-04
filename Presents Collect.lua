local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local Folder = Workspace:WaitForChild("Presents", 10)
if not Folder then return end

local OFFSET = Vector3.new(0, 3, 0)
local Enabled = false
local HRP = nil

local function CacheCharacter(char)
    HRP = char:WaitForChild("HumanoidRootPart", 5)
end

if LocalPlayer.Character then
    CacheCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(CacheCharacter)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoTP_GUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Button = Instance.new("TextButton")
Button.Name = "ToggleBtn"
Button.Parent = ScreenGui
Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Button.Position = UDim2.new(0, 10, 0.5, 0)
Button.Size = UDim2.new(0, 160, 0, 50)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 18
Button.Text = "TP: OFF"
Button.TextColor3 = Color3.new(1, 1, 1)

Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

Button.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    Button.BackgroundColor3 = Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 0, 0)
    Button.Text = Enabled and "TP: ON" or "TP: OFF"
end)

Folder.ChildAdded:Connect(function(child)
    if not Enabled or not HRP then return end
    HRP.CFrame = child:GetPivot() + OFFSET
end)
