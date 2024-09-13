# Метод для нахождения минимального элемента с использованием цикла for
def find_minimum_with_for(array)
  min = array[0]
  for element in array
    if element < min
      min = element
    end
  end
  min
end

# Метод для нахождения минимального элемента с использованием цикла while
def find_minimum_with_while(array)
  min = array[0]
  index = 0
  while index < array.length
    if array[index] < min
      min = array[index]
    end
    index += 1
  end
  min
end

# Метод для нахождения количества элементов с использованием цикла for
def count_elements_with_for(array)
  count = 0
  for _ in array
    count += 1
  end
  count
end

# Метод для нахождения количества элементов с использованием цикла while
def count_elements_with_while(array)
  count = 0
  index = 0
  while index < array.length
    count += 1
    index += 1
  end
  count
end

# Метод для нахождения номера первого положительного элемента с использованием цикла for
def find_first_positive_index_with_for(array)
  for index in 0...array.length
    if array[index] > 0
      return index
    end
  end
  -1
end

# Метод для нахождения номера первого положительного элемента с использованием цикла while
def find_first_positive_index_with_while(array)
  index = 0
  while index < array.length
    if array[index] > 0
      return index
    end
    index += 1
  end
  -1
end

# Функция для выполнения метода в зависимости от выбора
def execute_method(method_number, array)
  case method_number
  when 1
    puts "Минимальный элемент (for): #{find_minimum_with_for(array)}"
  when 2
    puts "Минимальный элемент (while): #{find_minimum_with_while(array)}"
  when 3
    puts "Количество элементов (for): #{count_elements_with_for(array)}"
  when 4
    puts "Количество элементов (while): #{count_elements_with_while(array)}"
  when 5
    puts "Индекс первого положительного элемента (for): #{find_first_positive_index_with_for(array)}"
  when 6
    puts "Индекс первого положительного элемента (while): #{find_first_positive_index_with_while(array)}"
  else
    puts "Неверный номер метода"
  end
end

# Основная часть программы
if ARGV.length != 2
  puts "Usage: ruby script.rb <method_number> <file_path>"
  exit
end

method_number = ARGV[0].to_i
file_path = ARGV[1]

begin
  array = File.read(file_path).split.map(&:to_i)
  execute_method(method_number, array)
rescue Errno::ENOENT
  puts "Файл не найден"
rescue ArgumentError
  puts "Ошибка чтения данных из файла. Убедитесь, что файл содержит только числа."
end
