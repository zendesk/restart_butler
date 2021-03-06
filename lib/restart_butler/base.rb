class RestartButler::Base
  attr_reader :from_revision, :to_revision, :root_dir, :git_dir, :changes, :opts
  attr_accessor :steps, :env

  BUMPFILE_PATH = "Bumpfile"

  def initialize(root_dir, from_revision, to_revision, opts = {})
    @root_dir = root_dir
    @from_revision = from_revision
    @to_revision = to_revision
    @git_dir = File.join(@root_dir, ".git")
    @forced_steps = []
    @steps = []
    @opts = opts
  end

  def run_command(command)
    env = (@opts[:env] || {}).map { |key, value| "#{key}=#{value}" }.join(" ")
    cmd = "umask 002 && bash -l -c 'cd #{@root_dir} && env #{env} #{command}'"
    log("Running command: #{cmd}")
    system(cmd)
  end

  def log(message, severity = :info)
    @logger ||= (@opts[:logger] || ::Logger.new(STDOUT))
    @logger.send(severity, "[FS:RB] " + message)
  end

  def changed_file?(file)
    self.changes.include?(file)
  end

  def changed_dir?(dir)
    dir += "/" if dir[-1, 1] == "/"
    self.changes.any? { |file| file.index(dir) == 0 }
  end

  def changed_bumpfile?
    changed_file?(BUMPFILE_PATH)
  end

  def always_execute_step?
    changed_file?(BUMPFILE_PATH) || changed_file?("script/restart")
  end

  def changes
    return @changes if @changes
    changes = `cd #{self.root_dir} && git --git-dir=#{self.git_dir} diff #{self.from_revision} #{self.to_revision} --diff-filter=ACDMR --name-status`.split("\n")
    changes_hash = changes.inject(Hash.new { |h, k| h[k] = [] }) do |hash, line|
      modifier, filename = line.split("\t", 2)
      hash[modifier] << filename
      hash
    end

    # create an array of files added, copied, modified or renamed
    modified_files = %w(A C M R).inject([]) { |files, bit| files.concat changes_hash[bit] }
    added_files = changes_hash['A'] # added
    deleted_files = changes_hash['D'] # deleted
    @changes = modified_files + deleted_files # all
  end

  def restart!
    steps.each do |step_entry|
      if step_entry.is_a?(Array)
        step_class, opts = step_entry
      else
        step_class = step_entry
        opts = {}
      end
      step = step_class.new(self, opts)
      if trigger?(step)
        log("Running step '#{step_class}'")
        step.execute
        @forced_steps |= step.triggers
      else
        log("Step skipped '#{step_class}'")
      end
    end
  end

  def trigger?(step)
    always_execute_step? or step.should_trigger? or @forced_steps.include?(step.class)
  end
end
