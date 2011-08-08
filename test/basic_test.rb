require "test/test_helper"

class RestartButler::Steps::First < RestartButler::Steps::Base
  def execute
  end

  def triggers
    [:second]
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

class RestartButler::Steps::Options < RestartButler::Steps::Base
  def execute
  end

  def option_keys
    [:lolwut]
  end
end

class BasicTest < Test::Unit::TestCase
  def test_options_for_step
  end

  def test_forced_trigger
    butler = RestartButler::Base.new(".", nil, nil)
    butler.steps << :options
    exception = assert_raises(Exception) do
      butler.restart!
    end
    assert_equal "Options needed: :lolwut", exception.message
  end
end
