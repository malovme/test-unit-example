gem "test-unit"
require 'test/unit'
require 'test/unit/runner/junitxml'

class RandomlyFailingTest < Test::Unit::TestCase
  def test_01
    probably_fail
  end

  def test_02
    probably_fail
  end

  def test_03
    probably_fail
  end

  def test_04
    probably_fail
  end

  def test_05
    probably_fail
  end

  def test_06
    probably_fail
  end

  def test_07
    probably_fail
  end

  def test_08
    probably_fail
  end

  def test_09
    probably_fail
  end

  def test_10
    probably_fail
  end

  def probably_fail
    if rand(100) > 80
      flunk 'Test failed'
    else
      assert true
    end
  end
end