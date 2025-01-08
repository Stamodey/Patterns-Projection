require_relative 'student'
require_relative 'students_list'
require_relative 'student_short'
require 'yaml'

class Student_list_YAML < Data_storage_strategy

  def from(file)
      text = file.read
      students = YAML.safe_load(text, permitted_classes: [Data, Symbol]).map{|data| Student.new(**data)}
      return students
  end

  def to(list_students, file)
      data = list_students.map{|x| x.to_h}
      file.write(data.to_yaml)
  end
end
