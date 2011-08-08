class RestartButler::Steps::Asset < RestartButler::Steps::Base
  def execute
    butler.run_command("./script/assets")
    butler.run_command("rsync -avr public/ #{opts[:destination]}")
  end

  def should_trigger?
    butler.changed_dir?('public') or butler.changed_file?('Assetfile')
  end

  def option_keys
    [:destination]
  end
end
