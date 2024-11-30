require_relative 'methods'


# Пример использования
processor = ArrayProcessor.new([1, 2, 3, 4, 5])

# all?
puts processor.all? { |x| x > 0 }  # true

# find
puts processor.find { |x| x.even? }  # 2

# flat_map
puts processor.flat_map { |x| [x, x * 2] }.inspect  # [1, 2, 2, 4, 3, 6, 4, 8, 5, 10]

# min_by
puts processor.min_by { |x| x % 3 }  # 3

# one?
puts processor.one? { |x| x.even? }  # false

# inject
puts processor.inject(0) { |sum, x| sum + x }  # 15
