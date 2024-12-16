require_relative 'task_2'

# Unit tests
class TestArrayProcessor
  def initialize
    @errors = []
  end

  def run
    setup
    test_elements
    test_all?
    test_find
    test_flat_map
    test_min_by
    test_one?
    test_inject
    report
  end

  def setup
    @array = [1, 2, 3, 4, 5]
    @processor = ArrayProcessor.new(@array)
  end

  def assert(condition, message)
    @errors << message unless condition
  end

  def assert_equal(expected, actual, message)
    assert(expected == actual, "#{message}: expected #{expected}, got #{actual}")
  end

  def test_elements
    assert_equal(@array, @processor.elements, "elements method failed")
  end

  def test_all?
    assert(@processor.all? { |x| x > 0 }, "all? method failed for all elements > 0")
    assert(!@processor.all? { |x| x < 3 }, "all? method failed for all elements < 3")
  end

  def test_find
    assert_equal(3, @processor.find { |x| x == 3 }, "find method failed for x == 3")
    assert_equal(nil, @processor.find { |x| x > 10 }, "find method failed for x > 10")
  end

  def test_flat_map
    assert_equal([1, 1, 2, 2, 3, 3, 4, 4, 5, 5], @processor.flat_map { |x| [x, x] }, "flat_map method failed")
  end

  def test_min_by
    assert_equal(1, @processor.min_by { |x| x }, "min_by method failed for x")
    assert_equal(5, @processor.min_by { |x| -x }, "min_by method failed for -x")
  end

  def test_one?
    assert(@processor.one? { |x| x == 3 }, "one? method failed for x == 3")
    assert(!@processor.one? { |x| x > 2 }, "one? method failed for x > 2")
  end

  def test_inject
    assert_equal(15, @processor.inject(0) { |sum, x| sum + x }, "inject method failed for sum")
    assert_equal(120, @processor.inject(1) { |product, x| product * x }, "inject method failed for product")
  end

  def report
    if @errors.empty?
      puts "All tests passed."
    else
      puts "The following tests failed:"
      @errors.each { |error| puts "- #{error}" }
    end
  end
end

# Run the tests
TestArrayProcessor.new.run
