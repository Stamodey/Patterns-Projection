# Выводим строку "Привет, мир!" на экран
puts("Hello World!")

# Проверяем, передан ли аргумент программе (ожидается имя пользователя)
if ARGV.length == 0
	puts("Пожалуйста, укажите ваше имя")
	# Завершаем программу, если аргумент не был передан
	exit
end

# Получаем имя пользователя как аргумент программы
user_name = ARGV[0]
puts("Привет, #{user_name}")

print("---------------------")

# Спрашиваем у пользователя, какой его любимый язык программирования
print("\nКакой ваш любимый язык программирования: ")
favorite_language = STDIN.gets.chomp.downcase 

# Проверяем, является ли любимым языком пользователя Ruby
if favorite_language == "ruby"
	puts "Ахах, #{user_name}, ты подлиза!"

else
	puts "Скоро будет Ruby, #{user_name}!"
	
	# Обрабатываем разные варианты выбора языка программирования
	case favorite_language
	when "python"
		puts "Python - это хорошо, но Ruby лучше!"
	when "java"
		puts "Java - это скучно, Ruby гораздо интереснее!"
	when "javascript"
    	puts "JavaScript - это хороший язык, но Ruby более мощный!"
	else
		# Если язык не входит в список, выводим общее сообщение
		puts "Я не знаю, что сказать о #{favorite_language}..."		
	end
end

print("---------------------")

# Просим пользователя ввести команду на языке Ruby
print "\nВведите команду на языке Ruby: "
print "Например: puts 'Привет, мир!', 5 + 3, Time.now: "
ruby_command = STDIN.gets.chomp

# Выполняем команду Ruby
puts "Результат выполнения команды Ruby:"
begin
  eval(ruby_command)  # Выполняем введённую команду
rescue StandardError => e
  puts "Ошибка в команде Ruby: #{e.message}"  # Если есть ошибка, выводим её
end

print("---------------------")

print "\nВведите команду операционной системы: "
os_command = STDIN.gets.chomp

puts "Результат выполнения команды OC:"
system(os_command)