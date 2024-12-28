require 'yaml'
require_relative 'student'

class YAMLStrategy
  def read(file_path)
    file = File.read(file_path)
    YAML.safe_load(file, symbolize_names: true).map { |student_data| Student.new(student_data) }
  rescue Errno::ENOENT
    []
  end

  def write(file_path, students)
    File.write(file_path, YAML.dump(students.map(&:to_h)))
  end
end
