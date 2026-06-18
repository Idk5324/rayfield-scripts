local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Atm0spheric✌️Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Atm0 Pr0ductio0n",
   LoadingSubtitle = "by Atm0",
   ShowText = "Atm0spheric", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

   -- ScriptID = "sid_xxxxxxxxxxxx", -- Your Script ID from developer.sirius.menu — enables analytics, managed keys, and script hosting

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "spherecapture", -- Create a custom folder for your hub/game
      FileName = "1config2files3"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "gYkaX5dxJW", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Get Key",
      Subtitle = "Key System",
      Note = "Join our Discord For Key", -- Use this to tell the user how to get a key
      FileName = "kP9#vLx2$mQ8wR!t", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"W#8a4$K5k2#a"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
   }
})

local MainTab = Window:CreateTab("Home", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Settings")

Rayfield:Notify({
   Title = "You executed Atm0 projects",
   Content = "join the discord",
   Duration = 5,
   Image = nil,
})

-- Function to find the closest Temp V and teleport to it
local function TeleportToClosestTempV()
   local player = game.Players.LocalPlayer
   local character = player.Character
   
   if not character or not character:FindFirstChild("HumanoidRootPart") then
      Rayfield:Notify({
         Title = "Error",
         Content = "Character not found!",
         Duration = 3,
         Image = nil,
      })
      return
   end
   
   local playerPos = character.HumanoidRootPart.Position
   local closestTempV = nil
   local closestDistance = math.huge
   
   -- Search for Temp V entities in the workspace
   for _, obj in pairs(workspace:GetDescendants()) do
      if obj.Name:match("Temp V") or obj.Name == "Temp V" then
         if obj:IsA("Model") or obj:IsA("Part") then
            local objPos = obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj.HumanoidRootPart.Position or obj.Position
            local distance = (playerPos - objPos).Magnitude
            
            if distance < closestDistance then
               closestDistance = distance
               closestTempV = obj
            end
         end
      end
   end
   
   if closestTempV then
      local targetPos = closestTempV:IsA("Model") and closestTempV:FindFirstChild("HumanoidRootPart") and closestTempV.HumanoidRootPart.Position or closestTempV.Position
      character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
      
      Rayfield:Notify({
         Title = "Teleported",
         Content = "Teleported to closest Temp V (" .. math.floor(closestDistance) .. " studs away)",
         Duration = 2,
         Image = nil,
      })
   else
      Rayfield:Notify({
         Title = "Not Found",
         Content = "No Temp V found in the workspace!",
         Duration = 3,
         Image = nil,
      })
   end
end

-- Add teleport button to Home tab
local TeleportButton = MainTab:CreateButton({
   Name = "Teleport to Closest Temp V",
   Callback = function()
      TeleportToClosestTempV()
   end,
})

local SettingsTab = Window:CreateTab("Settings", nil) -- Title, Image
local SettingsSection = SettingsTab:CreateSection("Settings")

local Button = SettingsTab:CreateButton({
   Name = "kill menu",
   Callback = function()
   Rayfield:Destroy()-- The function that takes place when the button is pressed
   end,
})
