require 'json'
require_relative 'students_list'

class StudentsListJSON < StudentsList
  private

  def parse_data(raw_data)
    json_data = JSON.parse(raw_data, symbolize_names: true)
    @students = json_data.map { |student_data| Student.new(**student_data) }
  end

  def serialize_data
    @students.map(&:to_h).to_json
  end
end
