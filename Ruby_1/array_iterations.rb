# Метод для нахождения минимального элемента с использованием цикла for
def find_minimum_with_for(array)
	min = array[0] # Предполагаем, что первый элемент минимальный

	for element in array
		if element < min
			min = element
		end
	end
	min
end

# Метод для нахождения минимального элемента с использованием цикла while
def find_minimum_with_while(array)
	min = array[0] # Предполагаем, что первый элемент минимальный
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
	-1 # Если нет положительных элементов
end

# Метод для нахождения номера первого положительного элемента с использованием цикла while
def find_first_positive_index_with_while(array)
	index = 0
	while index < array.length
		if array[index] > 0
			return index
		end
	end
	-1 # Если нет положительных элементов
end
array = [3, -5, 7, -2, 4, 0]

puts "Минимальный элемент (for): #{find_minimum_with_for(array)}"
puts "Минимальный элемент (while): #{find_minimum_with_while(array)}"

puts "Количество элементов (for): #{count_elements_with_for(array)}"
puts "Количество элементов (while): #{count_elements_with_while(array)}"

puts "Индекс первого положительного элемента (for): #{find_first_positive_index_with_for(array)}"
puts "Индекс первого положительного элемента (while): #{find_first_positive_index_with_while(array)}"