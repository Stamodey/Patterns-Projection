require_relative 'student_list'
require_relative 'json_strategy'

class Students_list_JSON < StudentList
  def initialize(file_path)
    super(file_path, JSONStrategy.new)
  end
end
