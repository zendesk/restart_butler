class RestartButler::Steps::Bundle < RestartButler::Steps::Base
  def execute
    butler.run_command("bundle install --without test:development --binstubs")
  end

  def should_trigger?
    butler.changed_file?("Gemfile") || butler.changed_file?("Gemfile.lock")
  end

  def triggers
    [RestartButler::Steps::God]
  end
end
