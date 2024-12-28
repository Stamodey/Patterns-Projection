require_relative 'student_list'
require_relative 'yaml_strategy'

class Students_list_YAML < StudentList
  def initialize(file_path)
    super(file_path, YAMLStrategy.new)
  end
end
