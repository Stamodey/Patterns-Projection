def my_select(array)
  result = []  
  array.each do |value|
    yield(value) ? result.push(value) : nil  
  end
  result 
end

# Метод для нахождения количества элементов в интервале a..b
def count_elements_in_range(array, a, b)
  filtered_elements = my_select(array) do |value|
    value >= a && value <= b
  end
  
  count = 0
  filtered_elements.each do |element|
    count += 1
  end
  
  count
end

# Метод для получения массива с клавиатуры
def get_array_from_keyboard
  puts "Введите элементы массива, разделяя их пробелами:"
  input = gets.chomp
  input.split.map(&:to_i)
end

# Метод для получения массива из файла
def get_array_from_file
  puts "Введите путь к файлу:"
  file_path = gets.chomp

  if File.exist?(file_path)
    file_content = File.read(file_path)
    file_content.split.map(&:to_i)
  else
    puts "Файл не найден!"
    []
  end
end

# Метод для выбора способа ввода данных
def choose_input_method
  puts "Выберите метод ввода данных: 1 - с клавиатуры, 2 - из файла"
  choice = gets.chomp.to_i

  case choice
  when 1
    get_array_from_keyboard
  when 2
    get_array_from_file
  else
    puts "Неверный выбор. Попробуйте снова."
    []
  end
end

array = choose_input_method

unless array.empty?
  puts "Введите интервал a..b (например, 5 10 для интервала от 5 до 10):"
  a, b = gets.chomp.split.map(&:to_i)

  count = count_elements_in_range(array, a, b)
  puts "Количество элементов в интервале #{a}..#{b}: #{count}"
end
