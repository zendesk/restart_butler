class RestartButler::Steps::God < RestartButler::Steps::Base
  def execute
    butler.run_command("./bin/god terminate")
    sleep 2
    butler.run_command("./bin/god -c #{opts[:god_path]}")
  end

  def should_trigger?
    butler.changed_file?(opts[:god_path]) or butler.changed_dir?("app") or
      butler.changed_dir?("config") or butler.changed_dir?("lib") or
      butler.changed_dir?("vendor")
  end

  def option_keys
    [:god_path]
  end
end
