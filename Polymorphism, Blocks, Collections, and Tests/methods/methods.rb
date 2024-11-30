class ArrayProcessor
  def initialize(array)
    @array = array.freeze
  end

  # Реализация all? с помощью цикла
  def all?(&block)
    @array.each do |element|
      return false unless block.call(element)
    end
    true
  end
  
  # Реализация find с помощью цикла
  def find(&block)
    @array.each do |element|
      return element if block.call(element)
    end
    nil
  end

    # Реализация flat_map с помощью цикла
  def flat_map(&block)
    result = []
    @array.each do |element|
      result += block.call(element)
    end
    result
  end

    # Реализация inject с помощью цикла
  def inject(initial = nil, &block)
    accumulator = initial
    @array.each do |element|
      accumulator = accumulator.nil? ? element : block.call(accumulator, element)
    end
    accumulator
  end

  # Реализация min_by с помощью цикла
  def min_by(&block)
    min_value = nil
    min_element = nil
    @array.each do |element|
      value = block.call(element)
      if min_value.nil? || value < min_value
        min_value = value
        min_element = element
      end
    end
    min_element
  end

  def one?(&block)
    count = 0
    @array.each do |element|
      count += 1 if block.call(element)
      return false if count > 1
    end
    count == 1
  end
end
