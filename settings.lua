local addonName, addon = ...

addon.settings = {
  defaults = {
    autoCombatLogging = true,
    autoLFGRoleCheckAccept = true,
    autoRepairAllItems = true,
    autoSkipCinematicsInDungeonsAndRaids = true,
    autoInsertMythicPlusKeystone = true,
  }
}

function addon.settings:Init()
  if NyarToolsSettings == nil then
    NyarToolsSettings = {}
  end

  for k, v in pairs(self.defaults) do
    if NyarToolsSettings[k] == nil then
      NyarToolsSettings[k] = v
    end
  end

  self.category = Settings.RegisterVerticalLayoutCategory(addonName)

  do
    local setting = Settings.RegisterAddOnSetting(
      self.category,
      addonName .. "_AutoCombatLogging",
      "autoCombatLogging",
      NyarToolsSettings,
      type(NyarToolsSettings.autoCombatLogging),
      "Auto Combat Logging",
      self.defaults.autoCombatLogging
    )
    Settings.CreateCheckbox(
      self.category,
      setting,
      "Enable combat logging automatically when you enter an instance."
    )
  end

  do
    local setting = Settings.RegisterAddOnSetting(
      self.category,
      addonName .. "_AutoLFGRoleCheckAccept",
      "autoLFGRoleCheckAccept",
      NyarToolsSettings,
      type(NyarToolsSettings.autoLFGRoleCheckAccept),
      "Auto LFG Role Check Accept",
      self.defaults.autoLFGRoleCheckAccept
    )
    Settings.CreateCheckbox(self.category, setting, "Accept LFG role checks automatically.")
  end

  do
    local setting = Settings.RegisterAddOnSetting(
      self.category,
      addonName .. "_AutoRepairAllItems",
      "autoRepairAllItems",
      NyarToolsSettings,
      type(NyarToolsSettings.autoRepairAllItems),
      "Auto Repair all Items",
      self.defaults.autoRepairAllItems
    )
    Settings.CreateCheckbox(
      self.category,
      setting,
      "Repair all items automatically when you interact with a merchant."
    )
  end

  do
    local setting = Settings.RegisterAddOnSetting(
      self.category,
      addonName .. "_AutoSkipCinematicsInDungeonsAndRaids",
      "autoSkipCinematicsInDungeonsAndRaids",
      NyarToolsSettings,
      type(NyarToolsSettings.autoSkipCinematicsInDungeonsAndRaids),
      "Auto Skip Cinematics in Dungeons and Raids",
      self.defaults.autoSkipCinematicsInDungeonsAndRaids
    )
    Settings.CreateCheckbox(
      self.category,
      setting,
      "Skip cinematics automatically in dungeons and raids."
    )
  end

  do
    local setting = Settings.RegisterAddOnSetting(
      self.category,
      addonName .. "_AutoInsertMythicPlusKeystone",
      "autoInsertMythicPlusKeystone",
      NyarToolsSettings,
      type(NyarToolsSettings.autoInsertMythicPlusKeystone),
      "Auto Insert Mythic+ Keystone",
      self.defaults.autoInsertMythicPlusKeystone
    )
    Settings.CreateCheckbox(
      self.category,
      setting,
      "Insert Mythic+ keystone automatically when you interact with a Font of Power."
    )
  end

  Settings.RegisterAddOnCategory(self.category)
end
