class RestartButler::Steps::Delayed < RestartButler::Steps::Base
  def execute
    butler.run_command("./script/delayed_job restart")
  end
end
