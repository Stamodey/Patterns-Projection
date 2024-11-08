# Метод для построения списка, состоящего из элементов, которые встречаются только в одном из двух списков
def build_unique_list(l1, l2)
  (l1 - l2) + (l2 - l1)
end

# Метод для получения списка с клавиатуры
def get_list_from_keyboard
  puts "Введите элементы списка, разделяя их пробелами:"
  input = gets.chomp
  input.split.map(&:to_i)
end

# Метод для получения списка из файла
def get_list_from_file
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
    get_list_from_keyboard
  when 2
    get_list_from_file
  else
    puts "Неверный выбор. Попробуйте снова."
    []
  end
end

# Основной код программы
puts "Для первого списка:"
l1 = choose_input_method

puts "Для второго списка:"
l2 = choose_input_method

unless l1.empty? || l2.empty?
  result = build_unique_list(l1, l2)
  puts "Новый список, состоящий из элементов, встречающихся только в одном из списков: #{result}"
end
