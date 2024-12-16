require_relative 'person'
require_relative 'student'
require_relative 'student_short'

def write_students_to_file(file_name, students)
  raise ArgumentError, "Invalid file name: #{file_name}" unless file_name

  students.each do |student|
    raise ArgumentError, "Student is nil" unless student
  end

  File.open("#{file_name}.txt", 'w') do |file|
    students.each do |student|
      file.puts student.to_s
    end
  rescue IOError => e
    puts "IOError: #{e.message}"
  end
end

def read_from_file(file_path)
  raise ArgumentError, "Invalid file path: #{file_path}" unless File.exist?(file_path)

  students = []
  File.foreach(file_path) do |line|
    students << Student.from_string(line.chomp)
  end

  students
end

# Создание объекта Student через конструктор
student = Student.new(
  first_name: "Иван",
  last_name: "Иванов",
  middle_name: "Иванович",
  student_id: "12345",
  git: "https://github.com/ivanov/portfolio",
  phone: "+7 (123) 456-7890",
  email: "ivanov@example.com",
  telegram: "@ivanov"
)

puts "--- Студент из конструктора ---"
puts student.to_s
puts "Контактная информация: #{student.contact_info}"
puts "Краткая информация: #{student.get_info}"
puts "Есть ли контакт: #{student.contact_available? ? 'Да' : 'Нет'}"
puts

# Создание объекта StudentShort через создание из объекта Student
student_short = StudentShort.create_from_student(student)

puts "--- СтудентShort из объекта Student ---"
puts student_short.to_s
puts "Есть ли контакт: #{student_short.contact_available? ? 'Да' : 'Нет'}"
puts

# Создание объекта StudentShort из строки
data = "student_id: 12345, git: https://github.com/ivanov/portfolio, surname_initials: Иванов И. И., contact: +7 (123) 456-7890"
student_short_from_string = StudentShort.create_from_string(data)

puts "--- СтудентShort из строки ---"
puts student_short_from_string.to_s
puts "Есть ли контакт: #{student_short_from_string.contact_available? ? 'Да' : 'Нет'}"




# Создаем несколько студентов
students = [
  Student.from_string('ID: 1, Фамилия: Иванов, Имя: Иван, Отчество: Иванович, Телефон: +79162345678, Телеграм: @ivanov, Почта: ivanov@gmail.com, Гит: https://github.com/ivanov/portfolio'),
  Student.from_string('ID: 2, Фамилия: Петров, Имя: Петя, Отчество: Петрович, Телефон: +98765432101, Телеграм: @petrov, Почта: petrov@gmail.com, Гит: https://github.com/ivanov/portfolio'),
]

write_students_to_file('data', students)

# Чтение студентов из файла и вывод информации о них
read_from_file('data.txt').each do |student|
  puts student.get_info
end

# Создаем экземпляры Student_short
student1_short = StudentShort.create_from_student(students[0])
student2_short = StudentShort.create_from_student(students[1])

# Выводим информацию о студентах
puts student1_short.to_s
puts student2_short.to_s
