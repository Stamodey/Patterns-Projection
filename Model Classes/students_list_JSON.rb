require_relative 'student'
require_relative 'students_list'
require_relative 'student_short'
require 'json'

class Student_list_JSON < Data_storage_strategy

  def from(file)
      text = file.read
      students = JSON.parse(text, symbolize_names: true).map{|data| Student.new(**data)}
      return students
  end
    
  def to(list_students, file)
      data = list_students.map{|x| x.to_h}
      file.write(JSON.pretty_generate(data))
  end
end
