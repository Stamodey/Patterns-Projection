# Реализация класса ArrayProcessor
class ArrayProcessor
  def initialize(array)
    @array = array.dup.freeze
  end

  # Метод для получения элементов массива
  def elements
    @array
  end

  # Реализация метода `all?`
  def all?
    return false unless block_given?
    @array.each { |element| return false unless yield(element) }
    true
  end

  # Реализация метода `find`
  def find
    return nil unless block_given?
    @array.each { |element| return element if yield(element) }
    nil
  end

  # Реализация метода `flat_map`
  def flat_map
    return [] unless block_given?
    result = []
    @array.each { |element| result.concat(yield(element)) }
    result
  end

  # Реализация метода `min_by`
  def min_by
    return nil unless block_given?
    min_element = @array.first
    min_value = yield(min_element)
    @array.each do |element|
      current_value = yield(element)
      if current_value < min_value
        min_element = element
        min_value = current_value
      end
    end
    min_element
  end

  # Реализация метода `one?`
  def one?
    return false unless block_given?
    count = 0
    @array.each do |element|
      count += 1 if yield(element)
      return false if count > 1
    end
    count == 1
  end

  # Реализация метода `inject`
  def inject(initial = nil)
    accumulator = initial
    @array.each do |element|
      accumulator = accumulator.nil? ? element : yield(accumulator, element)
    end
    accumulator
  end
end
