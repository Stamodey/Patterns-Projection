#Метод 3 Найти делитель числа, являющийся взаимно простым с наибольшим количеством цифр данного числа.
# Метод для нахождения наибольшего общего делителя (НОД)
def greatest_common_divisor(a, b)
  while b != 0
    a, b = b, a % b
  end
  a
end

# Функция для нахождения всех делителей числа
def find_divisors(number)
  divisors = []
  (1..number).each do |i|
    divisors << i if number % i == 0
  end
  divisors
end

# Функция для нахождения количества цифр числа
def digit_count(number)
  number.to_s.length
end

# Функция для нахождения делителя, который является взаимно простым с количеством цифр числа
def find_divisor_with_max_coprime_digits(number)
  max_digits = digit_count(number)
  best_divisor = nil

  # Получаем все делители числа
  divisors = find_divisors(number)

  divisors.each do |divisor|
    # Проверяем, является ли делитель взаимно простым с количеством цифр
    if greatest_common_divisor(divisor, max_digits) == 1
      if best_divisor.nil? || divisor.to_s.length > best_divisor.to_s.length
        best_divisor = divisor
      end
    end
  end

  best_divisor
end

# Пример использования:
print "Введите число: "
user_input = gets.to_i

result = find_divisor_with_max_coprime_digits(user_input)

if result
  puts "Делитель числа #{user_input}, который является взаимно простым с количеством его цифр: #{result}"
else
  puts "Нет делителей, взаимно простых с количеством цифр числа #{user_input}"
end
