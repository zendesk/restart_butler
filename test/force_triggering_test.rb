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

class ForceTriggeringTest < Test::Unit::TestCase
  def test_forced_trigger
    butler = RestartButler::Base.new(".", nil, nil)
    butler.steps << :first
    butler.steps << :second
    exception = assert_raises(RuntimeError) do
      butler.restart!
    end
    assert_equal "Second", exception.message
  end
end
