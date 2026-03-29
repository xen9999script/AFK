    repeat task.wait() until game:IsLoaded()

pcall(function()
    if game.CoreGui:FindFirstChild("xenFinal") then
        game.CoreGui.xenFinal:Destroy()
    end
end)

local VIM = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local purple = Color3.fromRGB(70,0,161)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "xenFinal"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 225, 0, 100)
frame.Position = UDim2.new(0.1,0,0.15,0)
frame.BackgroundColor3 = Color3.fromRGB(12,12,12)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame)

-- MAIN GLOW
local stroke = Instance.new("UIStroke", frame)
stroke.Color = purple
stroke.Thickness = 1.5
stroke.Transparency = 0.4

local glow = Instance.new("ImageLabel", frame)
glow.Size = UDim2.new(1,20,1,20)
glow.Position = UDim2.new(0,-10,0,-10)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://4996891970"
glow.ImageColor3 = purple
glow.ImageTransparency = 0.85
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(24,24,276,276)

-- TITLE
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,20)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Center
title.Text = "Anti Afk By Xen"
title.TextColor3 = purple

-- CLOSE
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,25,0,15)
close.Position = UDim2.new(1,-30,0,2)
close.Text = "X"
close.BackgroundTransparency = 1
close.TextColor3 = purple
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- BAR
local bar = Instance.new("Frame", frame)
bar.Size = UDim2.new(1,-10,0,4)
bar.Position = UDim2.new(0,5,0.23,0)
bar.BackgroundColor3 = purple
Instance.new("UICorner", bar)

-- KICKS
local kicksText = Instance.new("TextLabel", frame)
kicksText.Position = UDim2.new(0.05,0,0.35,0)
kicksText.Size = UDim2.new(0,60,0,20)
kicksText.BackgroundTransparency = 1
kicksText.Text = "Kicks:"
kicksText.TextColor3 = purple

local kicksValue = Instance.new("TextLabel", frame)
kicksValue.Position = UDim2.new(0.25,0,0.35,0)
kicksValue.Size = UDim2.new(0,40,0,20)
kicksValue.BackgroundTransparency = 1
kicksValue.Text = "0"
kicksValue.TextColor3 = purple

-- TIME
local timeText = Instance.new("TextLabel", frame)
timeText.Position = UDim2.new(0.5,0,0.35,0)
timeText.Size = UDim2.new(0,50,0,20)
timeText.BackgroundTransparency = 1
timeText.Text = "Time:"
timeText.TextColor3 = purple

local timer = Instance.new("TextLabel", frame)
timer.Position = UDim2.new(0.7,0,0.35,0)
timer.Size = UDim2.new(0,60,0,20)
timer.BackgroundTransparency = 1
timer.TextColor3 = purple
timer.Text = "0:0:0"

-- STATUS
local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,8,1,-18)
status.Size = UDim2.new(0,140,0,14)
status.BackgroundTransparency = 1
status.Text = "Anti-Afk Enabled"
status.TextColor3 = purple
status.TextXAlignment = Enum.TextXAlignment.Left

-- ARROW
local arrow = Instance.new("TextButton", frame)
arrow.Position = UDim2.new(1,-18,1,-18)
arrow.Size = UDim2.new(0,14,0,14)
arrow.BackgroundTransparency = 1
arrow.Text = "▼"
arrow.TextColor3 = purple

-- DROPDOWN (CENTERED UNDER GUI)
local dropdown = Instance.new("Frame", gui)
dropdown.Size = UDim2.new(0,140,0,0)
dropdown.Position = UDim2.new(
    frame.Position.X.Scale,
    frame.Position.X.Offset + (225/2 - 70),
    frame.Position.Y.Scale,
    frame.Position.Y.Offset + 100 + 5
)
dropdown.BackgroundColor3 = Color3.fromRGB(15,15,15)
dropdown.ClipsDescendants = true
Instance.new("UICorner", dropdown)

-- DROPDOWN GLOW
local dStroke = Instance.new("UIStroke", dropdown)
dStroke.Color = purple
dStroke.Thickness = 1.2
dStroke.Transparency = 0.4

local dGlow = Instance.new("ImageLabel", dropdown)
dGlow.Size = UDim2.new(1,20,1,20)
dGlow.Position = UDim2.new(0,-10,0,-10)
dGlow.BackgroundTransparency = 1
dGlow.Image = "rbxassetid://4996891970"
dGlow.ImageColor3 = purple
dGlow.ImageTransparency = 0.88
dGlow.ScaleType = Enum.ScaleType.Slice
dGlow.SliceCenter = Rect.new(24,24,276,276)

-- TEXT
local dropText = Instance.new("TextLabel", dropdown)
dropText.Size = UDim2.new(1,0,1,0)
dropText.BackgroundTransparency = 1
dropText.TextColor3 = purple
dropText.Text = "Local Time\n00:00:00"

-- ANIMATION
local openTween = TweenService:Create(dropdown, TweenInfo.new(0.25), {Size = UDim2.new(0,140,0,40)})
local closeTween = TweenService:Create(dropdown, TweenInfo.new(0.25), {Size = UDim2.new(0,140,0,0)})

local open = false

arrow.MouseButton1Click:Connect(function()
    open = not open
    if open then
        openTween:Play()
        arrow.Text = "▲"
    else
        closeTween:Play()
        arrow.Text = "▼"
    end
end)

-- TIME UPDATE
task.spawn(function()
    while true do
        dropText.Text = "Local Time\n"..os.date("%X")
        task.wait(1)
    end
end)

-- DRAG (also moves dropdown with it)
local dragging, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)

        dropdown.Position = UDim2.new(
            frame.Position.X.Scale,
            frame.Position.X.Offset + (225/2 - 70),
            frame.Position.Y.Scale,
            frame.Position.Y.Offset + 100 + 5
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- LOGIC
local s,m,h = 0,0,0
local kicks = 0

task.spawn(function()
    while true do
        s+=1
        if s>=60 then s=0 m+=1 end
        if m>=60 then m=0 h+=1 end
        timer.Text = h..":"..m..":"..s
        task.wait(1)
    end
end)

task.spawn(function()
    while true do
        task.wait(1200)
        kicks+=1
        kicksValue.Text = tostring(kicks)
    end
end)

task.spawn(function()
    while true do
        VIM:SendKeyEvent(true, Enum.KeyCode.Comma, false, game)
        VIM:SendKeyEvent(false, Enum.KeyCode.Comma, false, game)
        task.wait(900)
    end
end)

-- TOGGLE GUI WITH M (ANTI-AFK STILL RUNS)
local visible = true

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.M then
        visible = not visible
        
        frame.Visible = visible
        dropdown.Visible = visible -- hides dropdown too
    end
end)