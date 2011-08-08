class RestartButler::Steps::Base
  attr_reader :butler

  def initialize(butler, opts = {})
    @butler = butler
    @opts = opts
  end

  def should_trigger?
    true
  end

  def triggers
    []
  end
end
