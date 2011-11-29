class RestartButler::Steps::Unicorn < RestartButler::Steps::Base
  def execute
    if File.exists?("#{butler.root_dir}/log/unicorn.pid")
      butler.run_command("rvm use 1.9.3-p0 && kill -USR2 `cat #{butler.root_dir}log/unicorn.pid`")
    else
      butler.run_command("rvm use 1.9.3-p0 && ./bin/unicorn -c #{butler.root_dir}/config/unicorn.rb -E #{butler.opts[:env]["RAILS_ENV"]} -D -p #{opts[:port]}")
    end
  end

  def should_trigger?
    butler.changed_dir?("app") or butler.changed_dir?("config") or
      butler.changed_dir?("lib") or butler.changed_dir?("vendor")
  end

  def option_keys
    [:port]
  end
end
