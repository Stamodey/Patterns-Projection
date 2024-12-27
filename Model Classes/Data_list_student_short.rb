require_relative 'student_short'
require_relative 'Data_list'

class Data_list_student_short < Data_list

  def initialize(data)
    super(data)
  end

  def get_data
    table = []
    @array.each_with_index do |student_short, index|
      table << [student_short.student_id, student_short.initials, student_short.git, student_short.contact]
    end
    DataTable.new(table)
  end


  private
  def get_names
    return ["id", "initials", "git", "contact"]
  end

  def attributes(student_short)
    return [student_short.student_id, student_short.initials, student_short.git, student_short.contact]
  end

end
