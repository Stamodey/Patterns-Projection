require_relative 'student'
require_relative 'student_short'

# Метод для чтения данных из файла с информацией о студентах
def self.read_from_txt(file_path)
  raise 'Некорректный адрес файла' unless File.exist?(file_path)

  students = []
  File.open(file_path, 'r') do |file|
    file.each_line do |line|
      students << Student.from_string(line.chomp)
    end
  end
  students
rescue => e
  raise "Ошибка при чтении файла: #{e.message}"
end

# Метод для записи данных студентов в файл
def self.write_to_txt(file_path, students)
  File.open(file_path, 'w') do |file|
    students.each do |student|
      file.puts "#{student.id}, #{student.last_name}, #{student.first_name}, #{student.middle_name}, #{student.phone}, #{student.telegram}, #{student.email}, #{student.git}"
    end
  end
end

# Пример использования
begin
  student_str = '1, Snake, Solid, David, , , solid.snake@game.com, solidsnake'
  student = Student.from_string(student_str)
  puts "Создан объект: #{student.get_info}"

  puts "\nЧтение данных из файла 'students.txt':"
  students_from_file = read_from_txt('D:\Ruby\Lab_2_student\students.txt')
  students_from_file.each { |student| puts student.get_info }

  puts "\nДобавляем нового студента в список:"
  new_student_str = ', Fisher, Sam, Michael, 9876543210, @samfisher, sam.fisher@stealth.com, samfisher'
  new_student = Student.from_string(new_student_str)
  students_from_file << new_student
  students_from_file.each { |student| puts student.get_info }

  puts "\nЗапись обновленного списка студентов в файл 'output_students.txt':"
  write_to_txt('output_students.txt', students_from_file)

  puts "Запись завершена успешно."
rescue => e
  puts "Ошибка: #{e.message}"
end
