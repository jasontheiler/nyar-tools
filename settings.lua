local addonName, addon = ...

addon.settings = {
  defaults = {
    autoCombatLogging = true,
    autoLFGRoleCheckAccept = true,
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
      "Enables combat logging when you enter an instance and disables it when you leave it."
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

  Settings.RegisterAddOnCategory(self.category)
end
