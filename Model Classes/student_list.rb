class StudentList
  def initialize(file_path, strategy)
    @file_path = file_path
    @strategy = strategy
    @students = read_from_file
  end

  def read_from_file
    @strategy.read(@file_path)
  end

  def write_to_file
    @strategy.write(@file_path, @students)
  end

  def get_student_by_id(id)
    @students.find { |student| student.id == id }
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    start_index = (k - 1) * n
    student_short_list = @students[start_index, n].map { |student| StudentShort.new(student) }
    data_list ? data_list.update(student_short_list) : DataList.new(student_short_list)
  end

  def sort_by_last_name_and_initials
    @students.sort_by! { |student| [student.last_name, student.initials] }
  end

  def add_student(student)
    student.id = (@students.map(&:id).max || 0) + 1
    @students << student
    write_to_file
  end

  def replace_student_by_id(id, new_student)
    index = @students.find_index { |student| student.id == id }
    @students[index] = new_student if index
    write_to_file
  end

  def delete_student_by_id(id)
    @students.reject! { |student| student.id == id }
    write_to_file
  end

  def get_student_short_count
    @students.size
  end
end
