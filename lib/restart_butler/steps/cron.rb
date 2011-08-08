class RestartButler::Steps::Cron < RestartButler::Steps::Base
  def execute
    butler.run_command("RAILS_ENV=#{RAILS_ENV} ./bin/whenever --update-crontab")
  end

  def should_trigger?
    butler.changed_file?('config/schedule.rb')
  end
end

