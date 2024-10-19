# main.rb
require_relative 'student'
require_relative 'file_operations'
require_relative 'student_short'


begin
  student_str = '1, Иванов, Иван, Иванович, +79001234567, , ivanov@example.com, https://github.com/ivanov'  
  student = Student.from_string(student_str)
  puts "Создан объект:\n#{student.get_info}"

  puts "\nЧтение данных из файла 'students.txt':"
  students_from_file = read_from_txt('students.txt')
  students_from_file.each { |student| puts student.get_info }

  puts "\nДобавляем нового студента в список:"
  new_student_str = ', Петров, Петр, Петрович, +79007654321, @petrov, petrov@example.com, https://github.com/petrov'
  new_student = Student.from_string(new_student_str)
  students_from_file << new_student
  write_to_txt('students.txt', students_from_file)
  puts "Обновленный список студентов записан в 'students.txt'."
rescue => e
  puts e.message
end
