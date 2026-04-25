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

function addon.events.MERCHANT_SHOW()
  if not NyarToolsSettings.autoRepairAllItems then
    return
  end

  if not CanMerchantRepair() then
    return
  end

  local cost = GetRepairAllCost()
  if cost <= 0 then
    return
  end

  RepairAllItems()
  addon:Log("Automatically repaired all items for", GetCoinTextureString(cost))
end

function addon.events.CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN()
  if not NyarToolsSettings.autoInsertMythicPlusKeystone then
    return
  end

  for bag = 0, NUM_BAG_FRAMES do
    for slot = 1, C_Container.GetContainerNumSlots(bag) do
      local itemID = C_Container.GetContainerItemID(bag, slot)
      if itemID then
        local class, subClass = select(12, GetItemInfo(itemID))
        if class == Enum.ItemClass.Reagent and subClass == Enum.ItemReagentSubclass.Keystone then
          C_Container.UseContainerItem(bag, slot)
        end
      end
    end
  end
end

addon.frame:SetScript("OnEvent", function(_, name, ...)
  addon.events[name](...)
end)
for name in pairs(addon.events) do
  addon.frame:RegisterEvent(name)
end

local function isInDungeonOrRaid()
  local _, type = IsInInstance()
  return type == "party" or type == "raid"
end

CinematicFrame:HookScript("OnShow", function()
  if not NyarToolsSettings.autoSkipCinematicsInDungeonsAndRaids or not isInDungeonOrRaid() then
    return
  end

  CinematicFrame_CancelCinematic()
  addon:Log("Automatically skipped cinematic.")
end)

local playMovieOrig = MovieFrame_PlayMovie
MovieFrame_PlayMovie = function(...)
  if not NyarToolsSettings.autoSkipCinematicsInDungeonsAndRaids or not isInDungeonOrRaid() then
    playMovieOrig(...)
    return
  end

  GameMovieFinished()
  addon:Log("Automatically skipped cinematic.")
end
