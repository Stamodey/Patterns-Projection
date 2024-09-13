# Метод 2 Найти сумму цифр числа, делящихся на 3

# Функция для нахождения суммы цифр числа, которые делятся на 3
def sum_of_digits_divisible_by_3(number)
	sum = 0

	number.to_s.each_char do |char|
		digit = char.to_i # Преобразуем символ обратно в цифру
		sum += digit if digit % 3 == 0 # Добавляем цифру к сумме, если она делится на 3
	end
	sum
end

print "Введите число: "
user_input = gets.to_i

puts "Сумма цифр числа #{user_input}, которые делятся на 3, равна: #{sum_of_digits_divisible_by_3(user_input)}"