local addonName, addon = ...

addon.frame = CreateFrame("Frame")

function addon:Initialize()
  self.settings:Init()
end

function addon:Log(...)
  print("|cff00ffff" .. addonName .. "|r:", ...)
end
