require "logger"

module RestartButler
  autoload "Base",  "restart_butler/base"

  module Steps
    autoload "Base", "restart_butler/steps/base"
    autoload "Asset", "restart_butler/steps/asset"
    autoload "Bundle", "restart_butler/steps/bundle"
    autoload "Cron", "restart_butler/steps/cron"
    autoload "Delayed", "restart_butler/steps/delayed"
    autoload "God", "restart_butler/steps/god"
    autoload "Migrate", "restart_butler/steps/migrate"
    autoload "Thin", "restart_butler/steps/thin"
  end
end
