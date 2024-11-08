def find_min_index(array)
  min_index = nil
  min_value = nil

  array.each_with_index do |value, index|
    if min_value.nil? || value < min_value
      min_value = value
      min_index = index
    end
  end

  min_index
end

def get_array_from_keyboard
  puts "Введите элементы массива, разделяя их пробелами:"
  input = gets.chomp
  puts "Введено: #{input}"
  input.split.map(&:to_i)
end

def get_array_from_file
  puts "Введите путь к файлу:"
  file_path = gets.chomp
  puts "Путь к файлу: #{file_path}"  

  if File.exist?(file_path)
    file_content = File.read(file_path)
    puts "Содержимое файла: #{file_content}"  
    file_content.split.map(&:to_i)
  else
    puts "Файл не найден!"
    []
  end
end

def choose_input_method
  puts "Выберите метод ввода данных: 1 - с клавиатуры, 2 - из файла"
  choice = gets.chomp.to_i
  puts "Выбор: #{choice}" 

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
puts "Массив: #{array}"  
unless array.empty?
  puts "Индекс минимального элемента: #{find_min_index(array)}"
end
