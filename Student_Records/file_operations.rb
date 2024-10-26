require_relative 'student'

def read_from_txt(file_path)
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

def write_to_txt(file_path, students)
  File.open(file_path, 'w') do |file|
    students.each do |student|
      contact_info = student.contacts.map { |type, value| "#{type.capitalize}: #{value}" }.join(', ')
      file.puts "#{student.id}, #{student.last_name}, #{student.first_name}, #{student.middle_name}, #{contact_info}, #{student.git}"
    end
  end
  
end
