class RestartButler::Steps::Migrate < RestartButler::Steps::Base
  def execute
    butler.run_command("./bin/rake db:migrate")
  end

  def should_trigger?
    butler.changed_dir?('db/migrate')
  end

  def triggers
    [RestartButler::Steps::God]
  end
end
