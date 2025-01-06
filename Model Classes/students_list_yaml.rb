require 'yaml'
require_relative 'students_list'

class StudentsListYAML < StudentsList
  private

  def parse_data(raw_data)
    yaml_data = YAML.safe_load(raw_data, symbolize_names: true)
    @students = yaml_data.map { |student_data| Student.new(**student_data) }
  end

  def serialize_data
    @students.map(&:to_h).to_yaml
  end
end
