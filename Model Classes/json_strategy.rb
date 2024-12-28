require 'json'
require_relative 'student'

class JSONStrategy
  def read(file_path)
    file = File.read(file_path)
    JSON.parse(file, symbolize_names: true).map { |student_data| Student.new(student_data) }
  rescue Errno::ENOENT
    []
  end

  def write(file_path, students)
    File.write(file_path, JSON.pretty_generate(students.map(&:to_h)))
  end
end
