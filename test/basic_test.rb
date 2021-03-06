require "test/test_helper"

class RestartButler::Steps::First < RestartButler::Steps::Base
  def execute
  end

  def triggers
    [RestartButler::Steps::Second]
  end
end

class RestartButler::Steps::Second < RestartButler::Steps::Base
  def execute
    raise "Second"
  end

  def should_trigger?
    false
  end
end

class RestartButler::Steps::NotRunning < RestartButler::Steps::Base
  def execute
  end
end

class RestartButler::Steps::Options < RestartButler::Steps::Base
  def execute
  end

  def option_keys
    [:lolwut]
  end
end

class BasicTest < Test::Unit::TestCase
  def setup
    @butler = RestartButler::Base.new(".", nil, nil, {:logger => Logger.new("/dev/null")})
  end

  def test_forced_trigger
    @butler.steps << RestartButler::Steps::First
    @butler.steps << RestartButler::Steps::Second
    exception = assert_raises(RuntimeError) do
      @butler.restart!
    end
    assert_equal "Second", exception.message
  end

  def test_options_for_step
    @butler.steps << RestartButler::Steps::Options
    exception = assert_raises(Exception) do
      @butler.restart!
    end
    assert_equal "Options needed: :lolwut", exception.message
  end

  def test_bumpfile_change_triggers_all_steps
    @butler.steps << RestartButler::Steps::NotRunning
    @butler.steps << RestartButler::Steps::NotRunning
    @butler.steps << RestartButler::Steps::NotRunning
    @butler.restart!
  end
end
