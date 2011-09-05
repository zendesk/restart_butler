class RestartButler::Steps::Thin < RestartButler::Steps::Base
  def execute
    butler.run_command("./bin/thin stop     -c #{butler.root_dir} -P #{butler.root_dir}/tmp/pids/thin.#{opts[:port]}.pid -p #{opts[:port]} -e #{butler.opts["RAILS_ENV"]}")
    butler.run_command("./bin/thin start -d -c #{butler.root_dir} -P #{butler.root_dir}/tmp/pids/thin.#{opts[:port]}.pid -p #{opts[:port]} -e #{butler.opts["RAILS_ENV"]}")
  end

  def should_trigger?
    butler.changed_dir?("app") or butler.changed_dir?("config") or
      butler.changed_dir?("lib") or butler.changed_dir?("vendor")
  end

  def option_keys
    [:port]
  end
end
