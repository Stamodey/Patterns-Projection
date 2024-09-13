# Вариант № 2
# Метод 1 Найти количество чисел, взаимно простых с заданным.

# Функция для нахождения наибольшего общего делителя (НОД)
def greatest_common_divisor(a, b)
	while b != 0
		a, b = b, a % b
	end
	a
end

# Функция для нахождения количества чисел, взаимно простых с заданным числом
def count_numbers_coprime_with(n)
  coprime_count = 0
  
  # Проверяем все числа от 1 до n-1
  (1...n).each do |current_number|
    # Если НОД текущего числа и n равен 1, то они взаимно просты
    if greatest_common_divisor(current_number, n) == 1
      coprime_count += 1
    end
  end
  
  coprime_count
end

print "Введите число: "
user_input = gets.to_i # Получаем число от пользователя и переводим его в формат int

puts "Количество чисел, взаимно простых с #{user_input}, равно: #{count_numbers_coprime_with(user_input)}" #вывод результата
