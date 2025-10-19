local WindUI
-- // KHỞI TẠO THƯ VIỆN WINDUI // --
do
    local success, result = pcall(function()
        -- Tải thư viện WindUI từ GitHub
        return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    end)

    if success then
        WindUI = result
    else
        warn("Lỗi khi tải WindUI:", result)
        return
    end
end

----------------------------------------------------------------------------------------------------

-- // TẠO CỬA SỔ CHÍNH (CREATEWINDOW) // --
local Window = WindUI:CreateWindow({
    Title = "AuroraX 🌌| [🌸]Build An Island!🏝️",
    Author = "By Ayypwm | VERSION 1.1.2 BETA",
    Folder = "Ayypwm_Hub_Configs", 
    NewElements = true, 
    HideSearchBar = false, 
    
    OpenButton = {
        Title = "Open AuroraX 🌌", 
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true, 
        OnlyMobile = true, 
        Color = ColorSequence.new( 
            Color3.fromHex("#305dff"), 
            Color3.fromHex("#a2ff30")  
        )
    }
})

----------------------------------------------------------------------------------------------------

-- // THÊM ẢNH NỀN CHO CỬA SỔ CHÍNH //
local MainFrame = Window.Main

if MainFrame and MainFrame:IsA("Frame") then
    local backgroundImage = Instance.new("ImageLabel")
    backgroundImage.Image = BACKGROUND_IMAGE_ID -- ID ảnh nền
    backgroundImage.BackgroundTransparency = 1 
    backgroundImage.Size = UDim2.new(1, 0, 1, 0) 
    backgroundImage.ZIndex = 1 
    backgroundImage.Parent = MainFrame 
    backgroundImage:SendToBack()
end

----------------------------------------------------------------------------------------------------

-- // 1. TAB INFO (ABOUT) // --
do
    local InfoTab = Window:Tab({ 
        Title = "Info", 
        Icon = "info"
    })
    
InfoTab:Section({
    Title = "Chào mọi người! Sau vài tháng thì bây giờ mình mới cập nhật lại script này.",
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Medium,
})

InfoTab:Section({
    Title = "",
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Medium,
})

InfoTab:Section({
    Title = "nó vẫn là beta thôi vì mình chưa mở full đảo nên vài tính năng chưa có, nhưng sẽ sớm có thôi nhữn tính năng mới mọi người từ từ trái nghiệm đi nhé.",
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Medium,
})


InfoTab:Section({
    Title = "",
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Medium,
})

InfoTab:Section({
    Title = "Hi everyone! After a few months, I just updated this script..",
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Medium,
})


InfoTab:Section({
    Title = "",
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Medium,
})

InfoTab:Section({
    Title = "It's still beta because I haven't opened the full island yet so some features aren't available yet, but they will be available soon. Everyone, please try out the new features slowly.",
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Medium,
})

    
    InfoTab:Button({
        Title = "Destroy Windui",
        Color = Color3.fromHex("#ff4830"),
        Callback = function()
            Window:Destroy()
        end
    })
end

    
----------------------------------------------------------------------------------------------------
-- // 2. TAB MAIN // --
local MainTab = Window:Tab({
    Title = "Main",
    Icon = "house",
})

----------------------------------------------------------------------------------------------------

-- // 3. TAB FARM // --
local FarmTab = Window:Tab({
    Title = "Farm",
    Icon = "shovel", -- Biểu tượng cái xẻng
})

-- Section ngăn bằng văn bản: FARM RESOURCES
FarmTab:Section({
    Title = "FARM RESOURCES",       -- Văn bản in hoa
    TextSize = 20,                  -- Kích thước chữ lớn hơn
    TextTransparency = 0,           -- Chữ rõ nét
    FontWeight = Enum.FontWeight.Bold,  -- Chữ đậm
})

-- Biến trạng thái
local AutoFarm = false -- Biến trạng thái Auto Farm My Island
-- Toggle Auto Farm Your Island
FarmTab:Toggle({
    Title = "Auto Farm Your Island",
    CurrentValue = false,
    Callback = function(state)
        AutoFarm = state
        if state then
            task.spawn(function()
                local plr = game.Players.LocalPlayer
                local plot = workspace:WaitForChild("Plots"):WaitForChild(plr.Name)
                while AutoFarm do
                    if plot and plot:FindFirstChild("Resources") then
                        for _, res in ipairs(plot.Resources:GetChildren()) do
                            if res:IsA("Model") then
                                task.spawn(function()
                                    local args = {res}
                                    game:GetService("ReplicatedStorage")
                                        :WaitForChild("Communication")
                                        :WaitForChild("HitResource")
                                        :FireServer(unpack(args))
                                end)
                            end
                        end
                    end
                    task.wait(3) -- Delay giữa mỗi lượt farm để tránh spam quá
                end
            end)
        end
    end,
})
-- Section ngăn bằng văn bản: ISLAND PART
MainTab:Section({
    Title = "ISLAND PART",       -- Văn bản in hoa
    TextSize = 18,                  -- Kích thước chữ lớn hơn
    TextTransparency = 0,           -- Chữ rõ nét
    FontWeight = Enum.FontWeight.Bold,  -- Chữ đậm
})

----------------------------------------------------------------------------------------------------
-- Section ngăn bằng văn bản:
FarmTab:Section({
    Title = "Upgrade Island",       -- Văn bản in hoa
    TextSize = 20,                  -- Kích thước chữ lớn hơn
    TextTransparency = 0,           -- Chữ rõ nét
    FontWeight = Enum.FontWeight.Bold,  -- Chữ đậm
})

local AutoUpgradeIsland = false -- biến trạng thái Auto Upgrade Island

--Toggle Auto Upgrade Island
FarmTab:Toggle({
    Title = "Auto Upgrade Island",
    CurrentValue = false,
    Callback = function(Value)
        AutoUpgradeIsland = Value
        if Value then
            task.spawn(function()
                local plr = game:GetService("Players").LocalPlayer
                local plot = workspace:WaitForChild("Plots"):FindFirstChild(plr.Name)
                while AutoUpgradeIsland do
                    if plot and plot:FindFirstChild("Expand") then
                        for _, exp in ipairs(plot.Expand:GetChildren()) do
                            local top = exp:FindFirstChild("Top")
                            if top then
                                local bGui = top:FindFirstChild("BillboardGui")
                                if bGui then
                                    for _, contribute in ipairs(bGui:GetChildren()) do
                                        if contribute:IsA("Frame") and contribute.Name ~= "Example" then
                                            local args = {exp.Name, contribute.Name, 20}
                                            game:GetService("ReplicatedStorage")
                                                :WaitForChild("Communication")
                                                :WaitForChild("ContributeToExpand")
                                                :FireServer(unpack(args))
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.2) -- delay 0.2s giữa mỗi lượt nâng để tránh spam quá
                end
            end)
        end
    end,
})

----------------------------------------------------------------------------------------------------
-- Section ngăn bằng văn bản:
FarmTab:Section({
    Title = "AUTO GOLD MINE",       -- Văn bản in hoa
    TextSize = 20,                  -- Kích thước chữ lớn hơn
    TextTransparency = 0,           -- Chữ rõ nét
    FontWeight = Enum.FontWeight.Bold,  -- Chữ đậm
})


local AutoMine = false -- biến trạng thái Auto mine

FarmTab:Toggle({
    Title = "Auto Send Coal To Mine",
    Default = false,
    Callback = function(state)
        AutoMine = state
        task.spawn(function()
            while AutoMine do
                for _, mine in pairs(game:GetService("Workspace").Land:GetDescendants()) do
                    if mine:IsA("Model") and mine.Name == "GoldMineModel" then
                        local storage = mine:FindFirstChild("Storage")
                        if storage and storage:FindFirstChild("Coal") then
                            local current = storage.Coal.Value
                            local max = storage.Coal.MaxValue or 10 -- giới hạn số lượng
                            if current < max then
                                game:GetService("ReplicatedStorage").Communication.Goldmine:FireServer(mine.Parent.Name, 1)
                                print("[AuroraX] Gửi than vào mỏ:", mine.Parent.Name)
                            else
                                print("[AuroraX] Mỏ đầy nhiên liệu:", mine.Parent.Name)
                            end
                        end
                    end
                end
                task.wait(2)
            end
        end)
    end
})
----------------------------------------------------------------------------------------------------
FarmTab:Section({
    Title = "AUTO FEED PETS",
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoHay1 = false -- biến trạng thái auto hay 1
local autoHay2 = false -- biến trạng thái auto hay 2
local autoHay3 = false -- biến trạng thái auto hay 3

-- toggle Auto Pet Feeder
FarmTab:Toggle({
    Title = "Auto Pet Feeder 1",
    Default = false,
    Callback = function(state)
        autoHay1 = state
        task.spawn(function()
            while autoHay1 do
                game:GetService("ReplicatedStorage").Communication.Animals.AddHay:FireServer("S203")
                print("[AuroraX]  Đã cho kiện rơm vào chuồng 3 (S203)")
                task.wait(120)
            end
        end)
    end
})

-- toggle Auto Pet Feeder
FarmTab:Toggle({
    Title = "Auto Pet Feeder 2",
    Default = false,
    Callback = function(state)
        autoHay2 = state
        task.spawn(function()
            while autoHay2 do
                game:GetService("ReplicatedStorage").Communication.Animals.AddHay:FireServer("S199")
                print("[AuroraX] Đã cho kiện rơm vào chuồng 2 (S199)")
                task.wait(120)
            end
        end)
    end
})

-- toggle Auto Pet Feeder
FarmTab:Toggle({
    Title = "Auto Pet Feeder 3",
    Default = false,
    Callback = function(state)
        autoHay3 = state
        task.spawn(function()
            while autoHay3 do
                game:GetService("ReplicatedStorage").Communication.Animals.AddHay:FireServer("S192")
                print("[AuroraX] Đã cho kiện rơm vào chuồng 1 (S192)")
                task.wait(120)
            end
        end)
    end
})

----------------------------------------------------------------------------------------------------
-- // 4. TAB EVENT // --
local EventTab = Window:Tab({
    Title = "Event",
    Icon = "calendar", -- Icon lịch/sự kiện
})

-- Section ngăn bằng văn bản: WORLD TREE
EventTab:Section({
    Title = "WORLD TREE",       -- Văn bản in hoa
    TextSize = 20,                  -- Kích thước chữ lớn hơn
    TextTransparency = 0,           -- Chữ rõ nét
    FontWeight = Enum.FontWeight.Bold,  -- Chữ đậm
})

-- Biến trạng thái
local AutoChopWorldTree = false -- biến trạng thái Auto Chop WorldTree
local AutoClaimChest = false -- biến trạng thái Auto Claim WorldTree Chest
local AutoCollectEgg = false -- biến trạng thái Auto Collect World TreeEgg

-- Toggle Auto Chop World Tree
EventTab:Toggle({
    Title = "Auto Chop World Tree",
    CurrentValue = false,
    Callback = function(Value)
        AutoHitWorldTree = Value
        task.spawn(function()
            while AutoHitWorldTree do
                local WorldTree = workspace:FindFirstChild("GlobalResources") and workspace.GlobalResources:FindFirstChild("World Tree")
                if WorldTree then
                    game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("HitResource"):FireServer(WorldTree)
                end
                task.wait(0.2)
            end
        end)
    end
})

-- Toggle Auto Claim Chest
EventTab:Toggle({
    Title = "Auto Claim Chest",
    CurrentValue = false,
    Callback = function(Value)
        AutoClaimChest = Value
        task.spawn(function()
            while AutoClaimChest do
                game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("RewardChestClaimRequest"):FireServer(1760520699.747562)
                task.wait(5)
            end
        end)
    end
})

-- Toggle Auto Collect Egg
EventTab:Toggle({
    Title = "Auto Collect Egg",
    CurrentValue = false,
    Callback = function(Value)
        AutoCollectEgg = Value
        task.spawn(function()
            while AutoCollectEgg do
                game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("CollectWorldTree"):FireServer(1760520699.747562)
                task.wait(5)
            end
        end)
    end
})

----------------------------------------------------------------------------------------------------
-- Section ngăn bằng văn bản:
EventTab:Section({
    Title = "RAINBOW EVENT",       -- Văn bản in hoa
    TextSize = 20,                  -- Kích thước chữ lớn hơn
    TextTransparency = 0,           -- Chữ rõ nét
    FontWeight = Enum.FontWeight.Bold,  -- Chữ đậm
})

-- Biến trạng thái
local autoFarmRainbow = false
local autoExchangeChest = false
local autoOpenShamrock = false

-- Toggle Auto Farm cây trên đảo Rainbow Island
EventTab:Toggle({
    Title = "Auto Farm Rainbow Event",
    Default = false,
    Callback = function(state)
        autoFarmRainbow = state
        if autoFarmRainbow then
            task.spawn(function()
                while autoFarmRainbow do
                    for _, tree in ipairs(workspace:WaitForChild("RainbowIsland"):WaitForChild("Resources"):GetChildren()) do
                        if tree:IsA("Model") then
                            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("HitResource"):FireServer(tree)
                            print("[AuroraX] Đã chặt cây:", tree.Name)
                            task.wait(0,1)
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

-- Auto Grab Clover (Rainbow Island)
EventTab:Toggle({
    Title = "Auto Grab Clover",
    Default = false,
    Callback = function(state)
        autoGrabClover = state
        if autoGrabClover then
            task.spawn(function()
                while autoGrabClover do
                    local clover = workspace:FindFirstChild("RainbowIsland") and workspace.RainbowIsland:FindFirstChild("3")
                    if clover then
                        local args = {{
                            id = "grab",
                            instance = clover
                        }}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("RainbowIslandEvent"):FireServer(unpack(args))
                    end
                    task.wait(1) -- delay 1 giây tránh spam
                end
            end)
        end
    end
})

-- Toggle Auto đổi rương Seed
EventTab:Toggle({
    Title = "Auto Redeem Shamrock Crate",
    Default = false,
    Callback = function(state)
        autoExchangeChest = state
        if autoExchangeChest then
            task.spawn(function()
                while autoExchangeChest do
                    game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("RewardChestClaimRequest"):FireServer("RainbowIslandShamrockChest")
                    print("[AuroraX] Đã Đổi Shamrock Chest")
                    task.wait(0,5)
                end
            end)
        end
    end
})

-- Toggle Auto mở rương Seed
local autoOpenShamrock = false
EventTab:Toggle({
    Title = "Auto Open Shamrock Crate",
    Default = false,
    Callback = function(state)
        autoOpenShamrock = state
        if autoOpenShamrock then
            task.spawn(function()
                while autoOpenShamrock do
                    local backpack = game.Players.LocalPlayer:WaitForChild("Backpack")
                    local crate = backpack:FindFirstChild("Shamrock Crate")
                    if crate and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(crate)
                        task.wait(0.1)
                        game:GetService("ReplicatedStorage").Communication.UseCrateRequest:FireServer({"Shamrock Crate"})
                        print("[AuroraX] Đã mở 1 Shamrock Crate")
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

-- Button đổi rương Seed (manual)
EventTab:Button({
    Title = "Redeem Shamrock Crate",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("RewardChestClaimRequest"):FireServer("RainbowIslandShamrockChest")
        print("[AuroraX] Đã Đổi Shamrock Chest")
    end
})

-- Button mở rương Seed (manual)
EventTab:Button({
    Title = "Open 1 Shamrock Crate",
    Callback = function()
        local backpack = game.Players.LocalPlayer:WaitForChild("Backpack")
        local crate = backpack:FindFirstChild("Shamrock Crate")
        if crate and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(crate)
            task.wait(0.1)
            game:GetService("ReplicatedStorage").Communication.UseCrateRequest:FireServer({"Shamrock Crate"})
            print("[AuroraX] Đã mở 1 Shamrock Crate")
        end
    end
})

-- Button Teleport Rainbow Island
EventTab:Button({
    Title = "Teleport Rainbow Island",
    Callback = function()
        local plr = game.Players.LocalPlayer
        plr.Character:SetPrimaryPartCFrame(CFrame.new(41.4246368, 409.674896, -12.6466351))
        print("[AuroraX] Đã Teleport tới Rainbow Island")
    end
})

----------------------------------------------------------------------------------------------------

-- Section Magical Event
EventTab:Section({
    Title = "MAGIC RAIN EVENT",
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold
})

-- Biến trạng thái
local autoRedeem1Token = false
local autoRedeem3Token = false
local autoOpenMagical = false

-- Toggle auto đổi 1 token → 1 crate
EventTab:Toggle({
    Title = "Auto Redeem 1 Token → 1 Crate",
    Default = false,
    Callback = function(state)
        autoRedeem1Token = state
        if autoRedeem1Token then
            task.spawn(function()
                while autoRedeem1Token do
                    local args = {"Magical Crate", "1"}
                    game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("PurchaseCrateRequest"):FireServer(unpack(args))
                    print("[AuroraX] đang Auto đổi 1 token lấy 1 Magical Crate")
                    task.wait(0,5) -- delay giữa mỗi lần đổi, tùy chỉnh nếu muốn nhanh hơn/chậm hơn
                end
            end)
        end
    end
})

-- Toggle auto đổi 3 token → 3 crate
EventTab:Toggle({
    Title = "Auto Redeem 3 Token → 3 Crate",
    Default = false,
    Callback = function(state)
        autoRedeem3Token = state
        if autoRedeem3Token then
            task.spawn(function()
                while autoRedeem3Token do
                    local args = {"Magical Crate", "3"}
                    game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("PurchaseCrateRequest"):FireServer(unpack(args))
                    print("[AuroraX] đang Auto đổi 3 token lấy 3 Magical Crate")
                    task.wait(0,5)
                end
            end)
        end
    end
})

-- Toggle auto mở Magical Crate
EventTab:Toggle({
    Title = "Auto Open Magical Crate",
    Default = false,
    Callback = function(state)
        autoOpenMagical = state
        if autoOpenMagical then
            task.spawn(function()
                while autoOpenMagical do
                    local backpack = game.Players.LocalPlayer:WaitForChild("Backpack")
                    local crate = backpack:FindFirstChild("Magical Crate")
                    if crate and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(crate)
                        task.wait(0.1)
                        game:GetService("ReplicatedStorage").Communication.UseCrateRequest:FireServer({"Magical Crate"})
                        print("[AuroraX] Đã mở 1 Magical Crate")
                    end
                    task.wait(0,5)
                end
            end)
        end
    end
})

-- Button đổi 1 token
EventTab:Button({
    Title = "redeem 1 Token → 1 Crate",
    Callback = function()
        local args = {"Magical Crate", "1"}
        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("PurchaseCrateRequest"):FireServer(unpack(args))
        print("[AuroraX] Đã đổi 1 token lấy 1 Magical Crate")
    end
})

-- Button đổi 3 token
EventTab:Button({
    Title = "redeem 3 Token → 3 Crate",
    Callback = function()
        local args = {"Magical Crate", "3"}
        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("PurchaseCrateRequest"):FireServer(unpack(args))
        print("[AuroraX] Đã đổi 3 token lấy 3 Magical Crate")
    end
})

-- Button mở rương
EventTab:Button({
    Title = "Open 1 Magical Crate",
    Callback = function()
        local backpack = game.Players.LocalPlayer:WaitForChild("Backpack")
        local crate = backpack:FindFirstChild("Magical Crate")
        if crate and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(crate)
            task.wait(0.1)
            game:GetService("ReplicatedStorage").Communication.UseCrateRequest:FireServer({"Magical Crate"})
            print("[AuroraX] Đã mở 1 Magical Crate")
        end
    end
})

----------------------------------------------------------------------------------------------------
-- // 5. TAB CRAFT // --
local CraftTab = Window:Tab({
    Title = "Craft",
    Icon = "hammer", -- Biểu tượng cái búa
})

CraftTab:Section({
    Title = "MATERIAL", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftHay = false

-- Toggle Auto Craft Hay Bales
CraftTab:Toggle({
    Title = "1. Auto Craft Hay Bales",
    Default = false,
    Callback = function(state)
        autoCraftHay = state
        if autoCraftHay then
            task.spawn(function()
                while autoCraftHay do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S178.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
                        print("[AuroraX] đang Craft Hay Bales")
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Hay Bales = Kiện Rơm",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftWood = false

CraftTab:Toggle({
    Title = "2. Auto Craft Wood Planks",
    Default = false,
    Callback = function(state)
        autoCraftWood = state
        if autoCraftWood then
            task.spawn(function()
                while autoCraftWood do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S13.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
                        print("[AuroraX] đang Craft Wood Planks")
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Wood Planks = Ván Gỗ Thường",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftBamboo = false

CraftTab:Toggle({
    Title = "3. Bamboo Planks",
    Default = false,
    Callback = function(state)
        autoCraftBamboo = state
        if autoCraftBamboo then
            task.spawn(function()
                while autoCraftBamboo do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S72.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
                        print("[AuroraX] đang Craft Bamboo Planks")
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Bamboo Planks = Ván Tre",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftBrick = false

CraftTab:Toggle({
    Title = "4. Auto Craft Brick",
    Default = false,
    Callback = function(state)
        autoCraftBrick = state
        if autoCraftBrick then
            task.spawn(function()
                while autoCraftBrick do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S24.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
                        print("[AuroraX] đang Craft Brick")
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Brick = Gạch",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftIron = false

CraftTab:Toggle({
    Title = "5. Auto Craft Iron Bar",
    Default = false,
    Callback = function(state)
        autoCraftIron = state
        if autoCraftIron then
            task.spawn(function()
                while autoCraftIron do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S23.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("DoubleCraft"):FireServer(unpack(args))
                        print("[AuroraX] đang Craft Iron Bar")
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Iron Bar = Thanh Sắt",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftCactus = false

CraftTab:Toggle({
    Title = "6. Auto Craft Cactus Fiber",
    Default = false,
    Callback = function(state)
        autoCraftCactus = state
        if autoCraftCactus then
            task.spawn(function()
                while autoCraftCactus do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S54.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Cactus Fiber = Sợi Xương Rồng",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftCement = false

CraftTab:Toggle({
    Title = "7. Auto Craft Cement",
    Default = false,
    Callback = function(state)
        autoCraftCement = state
        if autoCraftCement then
            task.spawn(function()
                while autoCraftCement do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S281.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("DoubleCraft"):FireServer(unpack(args))
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Cement = Xi Măng",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftMagmite = false

CraftTab:Toggle({
    Title = "8. Auto Craft Magmite",
    Default = false,
    Callback = function(state)
        autoCraftMagmite = state
        if autoCraftMagmite then
            task.spawn(function()
                while autoCraftMagmite do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S106.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("DoubleCraft"):FireServer(unpack(args))
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Magmite = thanh dung nham",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftMagma = false

CraftTab:Toggle({
    Title = "9. Auto Craft Magma Plank",
    Default = false,
    Callback = function(state)
        autoCraftMagma = state
        if autoCraftMagma then
            task.spawn(function()
                while autoCraftMagma do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S108.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Magma Plank = Ván Dung Nham",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftObsidianGlass = false

CraftTab:Toggle({
    Title = "10. Auto Craft Obsidian Glass",
    Default = false,
    Callback = function(state)
        autoCraftObsidianGlass = state
        if autoCraftObsidianGlass then
            task.spawn(function()
                while autoCraftObsidianGlass do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S134.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("DoubleCraft"):FireServer(unpack(args))
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Obsidian Glass = Kính Đá Núi Lửa",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftMushroom = false

CraftTab:Toggle({
    Title = "11. Auto Craft Mushroom Plank",
    Default = false,
    Callback = function(state)
        autoCraftMushroom = state
        if autoCraftMushroom then
            task.spawn(function()
                while autoCraftMushroom do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S164.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(unpack(args))
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Mushroom Plank = Ván Nấm",
    Callback = function() end
})

CraftTab:Section({
    Title = "", 
    TextSize = 20,
    TextTransparency = 0,
    FontWeight = Enum.FontWeight.Bold,
})

local autoCraftSaltBag = false

CraftTab:Toggle({
    Title = "12. Auto Craft Salt Bag",
    Default = false,
    Callback = function(state)
        autoCraftSaltBag = state
        if autoCraftSaltBag then
            task.spawn(function()
                while autoCraftSaltBag do
                    local plr = game.Players.LocalPlayer
                    local crafter = workspace.Plots[plr.Name].Land.S214.Crafter
                    local attachment = crafter:FindFirstChild("Attachment")
                    if attachment then
                        local args = {attachment}
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("DoubleCraft"):FireServer(unpack(args))
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

CraftTab:Button({
    Title = "Salt Bag = Túi Muối",
    Callback = function() end
})

----------------------------------------------------------------------------------------------------
-- // 6. TAB COLLECT // --
local CollectTab = Window:Tab({
    Title = "Collect",
    Icon = "boxes", -- Biểu tượng hộp đựng
})

-- Section ngăn bằng văn bản: COLLECT RESOURCES 
CollectTab:Section({
    Title = "COLLECT RESOURCES",       -- Văn bản in hoa
    TextSize = 20,                  -- Kích thước chữ lớn hơn
    TextTransparency = 0,           -- Chữ rõ nét
    FontWeight = Enum.FontWeight.Bold,  -- Chữ đậm
})

-- Biến trạng thái
local AutoHarvestPlants = false -- biến trạng thái Auto Collect Plants
local Players = game:GetService("Players")
local RepStorage = game:GetService("ReplicatedStorage")
local AutoCollectHoney = false -- biến trạng thái  auto Collect Honey
local AutoCollectGold = false -- Biến trạng thái Auto Gold
local AutoCollectFish = false -- biến Auto Collect Fish

-- Toggle Auto Collect Plants
CollectTab:Toggle({
    Title = "Auto collect Plants",
    CurrentValue = false,
    Callback = function(Value)
        AutoHarvestPlants = Value
        task.spawn(function()
            while AutoHarvestPlants do
                local plrName = Players.LocalPlayer.Name
                local plot = workspace.Plots:FindFirstChild(plrName)
                if plot and plot:FindFirstChild("Plants") then
                    for _, plant in pairs(plot.Plants:GetChildren()) do
                        if plant:IsA("Model") then
                            RepStorage:WaitForChild("Communication"):WaitForChild("Harvest"):FireServer(plant.Name)
                        end
                    end
                end
                task.wait(5) -- delay 5 giây giữa mỗi lần thu hoạch
            end
        end)
    end,
})

-- Toggle Auto Collect Honey
CollectTab:Toggle({
    Title = "Auto Collect Honey",
    CurrentValue = false,
    Callback = function(Value)
        AutoCollectHoney = Value
        task.spawn(function()
            while AutoCollectHoney do
                local plrName = game.Players.LocalPlayer.Name
                local plot = workspace.Plots:FindFirstChild(plrName)
                if plot and plot:FindFirstChild("Land") then
                    for _, spot in ipairs(plot.Land:GetDescendants()) do
                        if spot:IsA("Model") and spot.Name:match("Spot") then
                            game.ReplicatedStorage.Communication.Hive:FireServer(spot.Parent.Name, spot.Name, 2)
                        end
                    end
                end
                task.wait(5) -- delay 5 giây giữa mỗi lần thu hoạch
            end
        end)
    end,
})

-- Toggle Auto Collect Gold
CollectTab:Toggle({
    Title = "Auto Collect Gold",
    CurrentValue = false,
    Callback = function(Value)
        AutoCollectGold = Value
        task.spawn(function()
            while AutoCollectGold do
                local plrPlot = workspace.Plots:FindFirstChild(game.Players.LocalPlayer.Name)
                if plrPlot and plrPlot:FindFirstChild("Land") then
                    local land = plrPlot.Land
                    for _, mine in pairs(land:GetDescendants()) do
                        if mine:IsA("Model") and mine.Name == "GoldMineModel" then
                            -- Gửi lệnh thu hoạch vàng
                            game.ReplicatedStorage.Communication.Goldmine:FireServer(mine.Parent.Name, 2)
                        end
                    end
                end
                task.wait(5) -- delay 5 giây giữa mỗi lần thu hoạch
            end
        end)
    end,
})

local Players = game:GetService("Players")
local RepStorage = game:GetService("ReplicatedStorage")

-- Toggle Auto Collect Fish
CollectTab:Toggle({
    Title = "Auto Collect Fish",
    CurrentValue = false,
    Callback = function(Value)
        AutoCollectFish = Value
        task.spawn(function()
            while AutoCollectFish do
                local plrName = Players.LocalPlayer.Name
                local plot = workspace.Plots:FindFirstChild(plrName)
                if plot then
                    -- Gửi lệnh lấy tất cả cá trong kho
                    RepStorage:WaitForChild("Communication"):WaitForChild("CollectFishCrateContents"):FireServer()
                end
                task.wait(60) -- delay 60 giây
            end
        end)
    end,
})

----------------------------------------------------------------------------------------------------

-- // 7. TAB SHOP // --
local ShopTab = Window:Tab({
    Title = "Shop",
    Icon = "store", -- Biểu tượng cửa hàng
})

-- Section ngăn bằng văn bản: SHOP MERCHANT MIKE
ShopTab:Section({
    Title = "SHOP MERCHANT MIKE",       -- Văn bản in hoa
    TextSize = 20,                  -- Kích thước chữ lớn hơn
    TextTransparency = 0,           -- Chữ rõ nét
    FontWeight = Enum.FontWeight.Bold,  -- Chữ đậm
})

-- // NÚT HIỂN THỊ THỜI GIAN RESET SHOP // --
local timeButton = ShopTab:Button({
    Title = " New items in --:--",
    Callback = function() end -- không làm gì khi nhấn
})

task.spawn(function()
	while task.wait(1) do
		local gui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
		if gui and gui:FindFirstChild("Main") and gui.Main:FindFirstChild("Menus") then
			local merchant = gui.Main.Menus:FindFirstChild("Merchant")
			if merchant and merchant.Inner and merchant.Inner:FindFirstChild("Timer") then
				local timerLabel = merchant.Inner.Timer
				if timerLabel:IsA("TextLabel") then
					timeButton:SetTitle(" " .. timerLabel.Text)
				end
			end
		end
	end
end)

----------------------------------------------------------------------------------------------------
-- danh sách vật phẩm merchant mike
local allItems = {
    "Apple Seeds", "Autochoper Mk 1", "Autochoper Mk 2", "Autominer Mk 1", "Autominer Mk 2",
    "Blueberry Seeds", "Busy Bee Potion", "Cherry Seeds", "Coal Crate", "Coconut Seeds",
    "Corn Seeds", "Dragonfruit Seeds", "Galaxy Potion", "Goji Berry Seeds", "Growth Potion",
    "Honey Bee", "Magic Durian Seeds", "Magma Bee", "Mango Seeds", "Multicast Potion",
    "Peach Seeds", "Pineapple Seeds", "Pumpkin Seeds", "Resource Potion", "Starfruit Seeds",
    "Strawberry Seeds", "Strength Potion", "Tomato Seeds", "Watermelon Seeds"
}

----------------------------------------------------------------------------------------------------
local selectedItems = {} 
local autoBuying = false -- biến trạng thái  AuotoBuying

local itemDropdown = ShopTab:Dropdown({
    Title = "shop Merchant Mike",
    Values = allItems,
    Multi = true,
    Callback = function(selected)
        selectedItems = selected
    end
})

-- toggle auto Buy (Merchant Mike)
ShopTab:Toggle({
    Title = "Auto Buy (Merchant Mike) ",
    Default = false,
    Callback = function(state)
        autoBuying = state
        if autoBuying then
            task.spawn(function()
                while autoBuying do
                    for _, item in ipairs(selectedItems) do
                        local args = {
                            [1] = item,
                            [2] = false
                        }
                        game:GetService("ReplicatedStorage").Communication.BuyFromMerchant:FireServer(unpack(args))
                        print("[AuroraX] Auto buying:", item) -- hiển thị những gì đã mua
                        task.wait(0.25)
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

----------------------------------------------------------------------------------------------------
-- Section ngăn bằng văn bản: SHOP DECOR MERCHANT
ShopTab:Section({
    Title = "SHOP DECOR MERCHANT",  -- Văn bản in hoa
    TextSize = 20, -- Kích thước chữ lớn hơn
    TextTransparency = 0, -- Chữ rõ nét
    FontWeight = Enum.FontWeight.Bold, -- Chữ đậm
})

-- Nút hiển thị thời gian reset Decor Merchant
local decorTimeButton = ShopTab:Button({
    Title = " New decor in --:--",
    Callback = function() end
})

task.spawn(function()
	while task.wait(1) do
		local gui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
		if gui and gui:FindFirstChild("Main") and gui.Main:FindFirstChild("Menus") then
			local decor = gui.Main.Menus:FindFirstChild("DecorMerchant")
			if decor and decor.Inner and decor.Inner:FindFirstChild("Timer") then
				local timerLabel = decor.Inner.Timer
				if timerLabel:IsA("TextLabel") then
					decorTimeButton:SetTitle(" " .. timerLabel.Text)
				end
			end
		end
	end
end)
----------------------------------------------------------------------------------------------------
-- Danh sách vật phẩm Merchant Decor
local allItemsDecor = {
    "Barrel", "Beach Chair", "Big Rock", "Blue Flower", "Box", "Brick Step",
    "Brick Wall", "Bush", "Campfire", "Chair", "Fountain", "Hedge Bush", "Lamp Post",
    "Log Bench", "Mailbox", "Purple Flower", "Sign", "Small Rock", "Small Stone",
    "Stone Column", "Stone Step", "Tree Stump", "Well", "White Flower",
    "Wood Archway", "Wood Bench", "Wood Column", "Wood Fence", "Wood Table",
    "Wood Wall", "Wooden Picnic Table"
}

local selectedDecor = {}
local autoBuyDecor = false -- biến trạng thái autoBuyDecor

local decorDropdown = ShopTab:Dropdown({
    Title = "Shop Decor Merchant",
    Values = allItemsDecor,
    Multi = true,
    Callback = function(selected)
        selectedDecor = selected
    end
})

-- toggle Auto Buy (Merchant Decor)
ShopTab:Toggle({
    Title = "Auto Buy (Merchant Decor)",
    Default = false,
    Callback = function(state)
        autoBuyDecor = state
        if autoBuyDecor then
            task.spawn(function()
                while autoBuyDecor do
                    for _, item in ipairs(selectedDecor) do
                        local args = { item, false }
                        game:GetService("ReplicatedStorage").Communication.BuyFromDecorMerchant:FireServer(unpack(args))
                        print("[AuroraX] Auto buying decor:", item)
                        task.wait(0.25)
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

----------------------------------------------------------------------------------------------------

-- // 8. TAB SELL // --
local SellTab = Window:Tab({
    Title = "Sell",
    Icon = "dollar-sign" -- icon tiền tệ
})


local autoSell = false -- biến trạng thái auto Sell

-- Toggle Auto Sell
SellTab:Toggle({
    Title = "Auto Sell Items",
    Default = false,
    Callback = function(state)
        autoSell = state
        if autoSell then
            task.spawn(function()
                local plr = game.Players.LocalPlayer
                while autoSell do
                    for _, item in pairs(plr.Backpack:GetChildren()) do
                        if item:GetAttribute("Sellable") then
                            local args = {
                                false,
                                { item:GetAttribute("Hash") }
                            }
                            game:GetService("ReplicatedStorage")
                                :WaitForChild("Communication")
                                :WaitForChild("SellToMerchant")
                                :FireServer(unpack(args))
                            print("[AuroraX] Selling:", item.Name)
                        end
                    end
                    task.wait(0,5) -- delay 0,5 giây giữa các lần kiểm tra
                end
            end)
        end
    end
})


----------------------------------------------------------------------------------------------------

-- // 9. TAB VISUAL // --
local VisualTab = Window:Tab({
    Title = "Visual",
    Icon = "eye", -- Biểu tượng con mắt
})
-- Thêm các Section và Element của Tab Visual tại đây

----------------------------------------------------------------------------------------------------

-- // 10. TAB MISC (Miscellaneous - Khác) // --
local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "coins", -- Biểu tượng đồng xu
})
-- Thêm các Section và Element của Tab Misc tại đây

----------------------------------------------------------------------------------------------------

-- // 11. TAB SETTINGS // --
local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "cog", -- Biểu tượng bánh răng
})
-- Thêm các Section và Element của Tab Settings tại đây
