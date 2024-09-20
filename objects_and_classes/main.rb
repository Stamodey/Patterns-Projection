require_relative 'student'

# Создание объектов класса Student
students = [
  Student.new(1, 'Иванов', 'Иван', 'Иванович'),
  Student.new(2, 'Петров', 'Пётр', 'Петрович', '8-800-123-45-67'),
  Student.new(3, 'Сидоров', 'Сергей', 'Сидорович', '8-800-901-23-45', '@test1'),
  Student.new(4, 'Кузнецов', 'Алексей', 'Кузнецович', '8-800-111-22-33', '@test2', 'test2@mail.com'),
  Student.new(5, 'Попов', 'Дмитрий', 'Попович', '8-800-444-55-66', '@test3', 'test@mail.com', 'http://github.com/test3')
]

# Вывод информации о студентах
students.each do |student|
  puts student.to_s
  puts
end
