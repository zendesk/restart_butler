class RestartButler::Steps::Base
  attr_reader :butler, :opts

  def initialize(butler, opts)
    @butler = butler
    @opts = opts
    raise Exception.new("Options needed: %p" % option_keys) unless (option_keys - opts.keys).empty?
  end

  def should_trigger?
    true
  end

  def triggers
    []
  end

  private
  def option_keys
    []
  end
end
