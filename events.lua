local addonName, addon = ...

addon.events = {}

function addon.events.ADDON_LOADED(name)
  if name ~= addonName then
    return
  end

  addon:Initialize()
end

function addon.events.PLAYER_ENTERING_WORLD()
  if not NyarToolsSettings.autoCombatLogging then
    return
  end

  if not LoggingCombat() and IsInInstance() then
    C_Timer.After(3, function()
      SetCVar("advancedCombatLogging", 1)
      LoggingCombat(true)
      addon:Log("Enabled combat logging.")
    end)
  end
  if LoggingCombat() and not IsInInstance() then
    C_Timer.After(3, function()
      LoggingCombat(false)
      addon:Log("Disabled combat logging.")
    end)
  end
end

function addon.events.LFG_ROLE_CHECK_SHOW()
  if not NyarToolsSettings.autoLFGRoleCheckAccept then
    return
  end

  LFDRoleCheckPopupAcceptButton:Click()
  addon:Log("Automatically accepted LFG role check.")
end

addon.frame:SetScript("OnEvent", function(_, name, ...)
  addon.events[name](...)
end)
for name in pairs(addon.events) do
  addon.frame:RegisterEvent(name)
end
