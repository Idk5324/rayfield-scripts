local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Mobile-friendly configuration
local IsMobile = game:GetService("UserInputService"):GetPlatform() == Enum.Platform.IOS or game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Android

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

-- Settings Storage
local Settings = {
   UILocked = false,
   CurrentTheme = "Default",
   UIScale = 1,
   AutoFarm = false,
   WalkspeedMultiplier = 1,
   JumpPowerMultiplier = 1,
   FOV = 70,
   NotificationDuration = 5,
   NotificationSound = true,
   AutoExecute = false,
   DebugMode = false,
   AutoSaveConfig = true,
   FPSCap = 0,
   RenderDistance = 500
}

-- ==================== HOME TAB ====================
local MainTab = Window:CreateTab("Home", nil)
local UIControlSection = MainTab:CreateSection("UI Controls")

Rayfield:Notify({
   Title = "You executed Atm0 projects",
   Content = "join the discord",
   Duration = 5,
   Image = nil,
})

-- Lock/Unlock Button
local UILockButton = UIControlSection:CreateButton({
   Name = "🔓 Lock UI",
   Callback = function()
      Settings.UILocked = not Settings.UILocked
      if Settings.UILocked then
         UILockButton:Set("🔒 UI Locked")
         Rayfield:Notify({
            Title = "UI Locked",
            Content = "The UI is now locked and cannot be moved",
            Duration = 2,
            Image = nil,
         })
      else
         UILockButton:Set("🔓 Lock UI")
         Rayfield:Notify({
            Title = "UI Unlocked",
            Content = "The UI is now unlocked and can be moved",
            Duration = 2,
            Image = nil,
         })
      end
   end,
})

-- ==================== SETTINGS TAB ====================
local SettingsTab = Window:CreateTab("Settings", nil)

-- UI & VISUAL SETTINGS
local UIVisualSection = SettingsTab:CreateSection("UI & Visual Settings")

-- Theme Changer
local ThemeDropdown = UIVisualSection:CreateDropdown({
   Name = "Theme",
   Options = {"Default", "DarkBlue", "Darker"},
   CurrentOption = "Default",
   MultipleOptions = false,
   Flag = "ThemeDropdown",
   Callback = function(Options)
      Settings.CurrentTheme = Options[1]
      Rayfield:Notify({
         Title = "Theme Changed",
         Content = "Theme changed to: " .. Options[1],
         Duration = 2,
         Image = nil,
      })
   end,
})

-- UI Scale Slider
local UIScaleSlider = UIVisualSection:CreateSlider({
   Name = "UI Scale",
   Range = {0.5, 2},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "UIScaleSlider",
   Callback = function(Value)
      Settings.UIScale = Value
      Rayfield:Notify({
         Title = "UI Scaled",
         Content = "UI Scale set to: " .. tostring(Value) .. "x",
         Duration = 1.5,
         Image = nil,
      })
   end,
})

-- ==================== GAMEPLAY SETTINGS ====================
local GameplaySection = SettingsTab:CreateSection("Gameplay Settings")

-- Auto Farm Toggle
local AutoFarmToggle = GameplaySection:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(Value)
      Settings.AutoFarm = Value
      local status = Value and "Enabled" or "Disabled"
      Rayfield:Notify({
         Title = "Auto Farm " .. status,
         Content = "Auto Farm has been " .. status,
         Duration = 2,
         Image = nil,
      })
   end,
})

-- Walkspeed Multiplier
local WalkspeedSlider = GameplaySection:CreateSlider({
   Name = "Walkspeed Multiplier",
   Range = {1, 3},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "WalkspeedSlider",
   Callback = function(Value)
      Settings.WalkspeedMultiplier = Value
      local player = game.Players.LocalPlayer
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.WalkSpeed = 16 * Value
      end
      Rayfield:Notify({
         Title = "Walkspeed Updated",
         Content = "Walkspeed set to: " .. tostring(Value) .. "x",
         Duration = 1.5,
         Image = nil,
      })
   end,
})

-- Jump Power Multiplier
local JumpPowerSlider = GameplaySection:CreateSlider({
   Name = "Jump Power Multiplier",
   Range = {1, 3},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      Settings.JumpPowerMultiplier = Value
      local player = game.Players.LocalPlayer
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.JumpPower = 50 * Value
      end
      Rayfield:Notify({
         Title = "Jump Power Updated",
         Content = "Jump Power set to: " .. tostring(Value) .. "x",
         Duration = 1.5,
         Image = nil,
      })
   end,
})

-- FOV Adjuster
local FOVSlider = GameplaySection:CreateSlider({
   Name = "Field of View (FOV)",
   Range = {50, 120},
   Increment = 5,
   Suffix = "°",
   CurrentValue = 70,
   Flag = "FOVSlider",
   Callback = function(Value)
      Settings.FOV = Value
      game.Workspace.CurrentCamera.FieldOfView = Value
      Rayfield:Notify({
         Title = "FOV Updated",
         Content = "FOV set to: " .. tostring(Value) .. "°",
         Duration = 1.5,
         Image = nil,
      })
   end,
})

-- ==================== NOTIFICATION SETTINGS ====================
local NotificationSection = SettingsTab:CreateSection("Notification Settings")

-- Notification Duration
local NotifDurationSlider = NotificationSection:CreateSlider({
   Name = "Notification Duration",
   Range = {1, 10},
   Increment = 0.5,
   Suffix = "s",
   CurrentValue = 5,
   Flag = "NotifDurationSlider",
   Callback = function(Value)
      Settings.NotificationDuration = Value
      Rayfield:Notify({
         Title = "Duration Updated",
         Content = "Notifications will now last for " .. tostring(Value) .. " seconds",
         Duration = Value,
         Image = nil,
      })
   end,
})

-- Notification Sound Toggle
local NotificationSoundToggle = NotificationSection:CreateToggle({
   Name = "Notification Sound",
   CurrentValue = true,
   Flag = "NotificationSoundToggle",
   Callback = function(Value)
      Settings.NotificationSound = Value
      local status = Value and "Enabled" or "Disabled"
      Rayfield:Notify({
         Title = "Notification Sound " .. status,
         Content = "Notification sounds have been " .. status,
         Duration = 2,
         Image = nil,
      })
   end,
})

-- ==================== SCRIPT BEHAVIOR SETTINGS ====================
local ScriptBehaviorSection = SettingsTab:CreateSection("Script Behavior")

-- Auto-Execute on Join
local AutoExecuteToggle = ScriptBehaviorSection:CreateToggle({
   Name = "Auto-Execute on Join",
   CurrentValue = false,
   Flag = "AutoExecuteToggle",
   Callback = function(Value)
      Settings.AutoExecute = Value
      local status = Value and "Enabled" or "Disabled"
      Rayfield:Notify({
         Title = "Auto-Execute " .. status,
         Content = "Auto-Execute has been " .. status,
         Duration = 2,
         Image = nil,
      })
   end,
})

-- Debug Mode
local DebugModeToggle = ScriptBehaviorSection:CreateToggle({
   Name = "Debug Mode",
   CurrentValue = false,
   Flag = "DebugModeToggle",
   Callback = function(Value)
      Settings.DebugMode = Value
      local status = Value and "Enabled" or "Disabled"
      print("[Atm0spheric Hub] Debug Mode " .. status)
      Rayfield:Notify({
         Title = "Debug Mode " .. status,
         Content = "Debug mode has been " .. status,
         Duration = 2,
         Image = nil,
      })
   end,
})

-- Config Auto-Save Toggle
local AutoSaveToggle = ScriptBehaviorSection:CreateToggle({
   Name = "Config Auto-Save",
   CurrentValue = true,
   Flag = "AutoSaveToggle",
   Callback = function(Value)
      Settings.AutoSaveConfig = Value
      local status = Value and "Enabled" or "Disabled"
      Rayfield:Notify({
         Title = "Auto-Save " .. status,
         Content = "Configuration auto-save has been " .. status,
         Duration = 2,
         Image = nil,
      })
   end,
})

-- ==================== PERFORMANCE SETTINGS ====================
local PerformanceSection = SettingsTab:CreateSection("Performance Settings")

-- FPS Cap
local FPSCapSlider = PerformanceSection:CreateSlider({
   Name = "FPS Cap (0 = Unlimited)",
   Range = {0, 240},
   Increment = 10,
   Suffix = " FPS",
   CurrentValue = 0,
   Flag = "FPSCapSlider",
   Callback = function(Value)
      Settings.FPSCap = Value
      local status = Value == 0 and "Unlimited" or tostring(Value)
      Rayfield:Notify({
         Title = "FPS Cap Updated",
         Content = "FPS Cap set to: " .. status,
         Duration = 1.5,
         Image = nil,
      })
   end,
})

-- Render Distance
local RenderDistanceSlider = PerformanceSection:CreateSlider({
   Name = "Render Distance",
   Range = {100, 1000},
   Increment = 50,
   Suffix = " studs",
   CurrentValue = 500,
   Flag = "RenderDistanceSlider",
   Callback = function(Value)
      Settings.RenderDistance = Value
      Rayfield:Notify({
         Title = "Render Distance Updated",
         Content = "Render Distance set to: " .. tostring(Value) .. " studs",
         Duration = 1.5,
         Image = nil,
      })
   end,
})

-- ==================== MISC TAB ====================
local MiscTab = Window:CreateTab("Misc", nil)
local MiscSection = MiscTab:CreateSection("Miscellaneous")

-- Reset Settings Button
local ResetButton = MiscSection:CreateButton({
   Name = "Reset All Settings",
   Callback = function()
      Settings = {
         UILocked = false,
         CurrentTheme = "Default",
         UIScale = 1,
         AutoFarm = false,
         WalkspeedMultiplier = 1,
         JumpPowerMultiplier = 1,
         FOV = 70,
         NotificationDuration = 5,
         NotificationSound = true,
         AutoExecute = false,
         DebugMode = false,
         AutoSaveConfig = true,
         FPSCap = 0,
         RenderDistance = 500
      }
      Rayfield:Notify({
         Title = "Settings Reset",
         Content = "All settings have been reset to default",
         Duration = 3,
         Image = nil,
      })
   end,
})

-- About Button
local AboutButton = MiscSection:CreateButton({
   Name = "About This Hub",
   Callback = function()
      Rayfield:Notify({
         Title = "Atm0spheric Hub",
         Content = "Version 2.0 - Loaded with enhanced settings!\nMobile Friendly: " .. (IsMobile and "Yes" or "No"),
         Duration = 5,
         Image = nil,
      })
   end,
})

-- Kill Menu Button
local KillMenuButton = SettingsTab:CreateButton({
   Name = "🔴 Destroy Menu",
   Callback = function()
      Rayfield:Destroy()
   end,
})

-- Debug logging
if Settings.DebugMode then
   print("[Atm0spheric Hub] Script initialized successfully!")
   print("[Atm0spheric Hub] Mobile Mode: " .. (IsMobile and "Enabled" or "Disabled"))
end
