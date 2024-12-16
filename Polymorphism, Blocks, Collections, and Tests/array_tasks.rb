# Метод для чтения массива
def read_array
  puts "Введите элементы массива через пробел (или укажите путь к файлу):"
  input = gets.chomp
  if File.exist?(input)
    File.read(input).split.map(&:to_i)
  else
    input.split.map(&:to_i)
  end
end

def read_interval
  puts "Введите интервал в формате 'a b':"
  gets.chomp.split.map(&:to_i)
end

# Задача 1: Найти индекс минимального элемента
def find_min_index(array)
  array.each_with_index.min_by(&:first).last
end

# Задача 2: Найти количество элементов в интервале a..b
def count_in_interval(array, interval)
  array.count { |x| interval.cover?(x) }
end

# Задача 3: Найти количество элементов между первым и последним минимальным
def count_between_min(array)
  min_val = array.min
  first_idx, last_idx = array.index(min_val), array.rindex(min_val)
  return 0 if first_idx == last_idx

  (first_idx + 1...last_idx).map { |idx| array[idx] }.count
end

# Задача 4: Найти количество элементов, значение которых принадлежит отрезку a..b
def count_in_segment(array, range)
  array.count { |x| range.include?(x) }
end

# Задача 5: Построить новый список из элементов, встречающихся только в одном из списков
def unique_elements(list1, list2)
  list1.union(list2) - list1.intersection(list2)
end

def menu
  loop do
    puts "\nВыберите задачу:"
    puts "1: Найти индекс минимального элемента"
    puts "2: Найти количество элементов в интервале a..b"
    puts "3: Найти количество элементов между первым и последним минимальным"
    puts "4: Найти количество элементов, значение которых принадлежит отрезку a..b"
    puts "5: Построить новый список из двух списков"
    puts "0: Выйти"

    choice = gets.chomp.to_i
    case choice
    when 1
      array = read_array
      puts "Индекс минимального элемента: #{find_min_index(array)}"
    when 2
      array = read_array
      a, b = read_interval
      puts "Количество элементов в интервале [#{a}, #{b}]: #{count_in_interval(array, a..b)}"
    when 3
      array = read_array
      puts "Количество элементов между первым и последним минимальным: #{count_between_min(array)}"
    when 4
      array = read_array
      a, b = read_interval
      puts "Количество элементов на отрезке [#{a}, #{b}]: #{count_in_segment(array, a..b)}"
    when 5
      puts "Введите элементы первого списка через пробел:"
      list1 = gets.chomp.split.map(&:to_i)
      puts "Введите элементы второго списка через пробел:"
      list2 = gets.chomp.split.map(&:to_i)
      puts "Новый список: #{unique_elements(list1, list2)}"
    when 0
      break
    else
      puts "Неверный выбор. Попробуйте снова."
    end
  end
end

menu
