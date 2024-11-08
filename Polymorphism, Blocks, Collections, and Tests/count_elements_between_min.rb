def find_min_indices(array)
  min_value = array.min
  first_min_index = nil
  last_min_index = nil

  array.each_with_index do |value, index|
    if value == min_value
      first_min_index ||= index  # Первый минимальный элемент
      last_min_index = index    # Последний минимальный элемент (обновляется каждый раз)
    end
  end

  [first_min_index, last_min_index]
end

# Метод для нахождения количества элементов между первым и последним минимальным
def count_elements_between_min(array)
  first_min_index, last_min_index = find_min_indices(array)

  if first_min_index && last_min_index && first_min_index != last_min_index
    array[first_min_index + 1...last_min_index].size
  else
    0
  end
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
  count = count_elements_between_min(array)
  puts "Количество элементов между первым и последним минимальным: #{count}"
end
