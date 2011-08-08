module RestartButler
  autoload "Base",  "restart_butler/base"

  module Steps
    autoload "Base", "restart_butler/steps/base"
    autoload "Bundle", "restart_butler/steps/bundle"
  end
end
