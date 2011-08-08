class RestartButler::Steps::God < RestartButler::Steps::Base
  def initialize(butler, opts)
    @god_path = opts[:god_path]
  end

  def execute
    raise Exception.new("No :god_path given") unless @god_path
    run "bin/god terminate"
    sleep 2
    butler.run_command("./bin/god -c #{@god_path]}")
  end

  def should_trigger?
    butler.changed_file?(@god_path) or butler.changed_dir?("app") or
      butler.changed_dir?("config") or butler.changed_dir?("lib") or
      butler.changed_dir?("vendor")
  end
end
