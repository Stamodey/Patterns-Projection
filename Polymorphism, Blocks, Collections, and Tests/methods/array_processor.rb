class ArrayProcessor
  def initialize(array)
    @array = array.dup.freeze
  end

  def elements
    @array
  end

  def all?
    @array.each do |element|
      return false unless yield(element)
    end
    true
  end

  def find
    @array.each do |element|
      return element if yield(element)
    end
    nil
  end

  def flat_map
    result = []
    @array.each do |element|
      result.concat(yield(element))
    end
    result
  end

  def min_by
    return nil if @array.empty?

    min_element = @array.first
    min_value = yield(min_element)

    @array.each do |element|
      value = yield(element)
      if value < min_value
        min_element = element
        min_value = value
      end
    end

    min_element
  end

  def one?
    found = false
    @array.each do |element|
      if yield(element)
        return false if found
        found = true
      end
    end
    found
  end

  def inject(initial)
    accumulator = initial
    @array.each do |element|
      accumulator = yield(accumulator, element)
    end
    accumulator
  end
end
