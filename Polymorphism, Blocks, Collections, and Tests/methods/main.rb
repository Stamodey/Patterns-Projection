require 'test/unit'
require_relative 'array_processor'

class TestArrayProcessor < Test::Unit::TestCase
  def setup
    @processor = ArrayProcessor.new([1, 2, 3, 4, 5])
  end

  def test_find
    assert_equal(4, @processor.find { |x| x > 3 })
    assert_nil(@processor.find { |x| x > 5 })
  end

  def test_min_by
    assert_equal(5, @processor.min_by { |x| -x })
  end

  def test_inject
    assert_equal(15, @processor.inject(0) { |sum, x| sum + x })
  end

  def test_one?
    assert_true(@processor.one? { |x| x == 3 })
    assert_false(@processor.one? { |x| x > 3 })
  end

  def test_flat_map
    assert_equal([1, 2, 2, 4, 3, 6, 4, 8, 5, 10], @processor.flat_map { |x| [x, x * 2] })
  end

  def test_all?
    assert_true(@processor.all? { |x| x < 6 })
    assert_false(@processor.all? { |x| x < 5 })
  end
  
end
