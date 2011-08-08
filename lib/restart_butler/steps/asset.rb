class RestartButler::Steps::Asset < RestartButler::Steps::Base
  def execute
    butler.run_command("./script/assets")
  end

  def should_trigger?
    butler.changed_dir?('public') or butler.changed_file?('Assetfile')
  end
end
