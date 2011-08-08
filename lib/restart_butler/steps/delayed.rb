class RestartButler::Steps::Delayed < RestartButler::Steps::Base
  def execute
    butler.run_command("RAILS_ENV=production ./script/delayed_job restart")
  end
end
