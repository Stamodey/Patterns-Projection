require_relative 'student'
require_relative 'data_list_student_short'

class StudentsList
  attr_reader :students, :file_path

  def initialize(file_path)
    @file_path = file_path
    @students = []
    read_file
  end

  def read_file
    raw_data = File.read(@file_path)
    parse_data(raw_data)
  end

  def write_file
    File.write(@file_path, serialize_data)
  end

  def get_student_by_id(student_id)
    @students.find { |student| student.student_id == student_id }
  end

  def add_student(student)
    student.student_id = generate_new_id
    @students << student
    write_file
  end

  def update_student(student_id, new_student)
    index = @students.index { |student| student.student_id == student_id }
    return unless index

    @students[index] = new_student
    write_file
  end

  def delete_student(student_id)
    @students.reject! { |student| student.student_id == student_id }
    write_file
  end

  def get_k_n_student_short_list(k, n, existing_data_list = nil)
    students_slice = @students.each_slice(n).to_a[k - 1]
    short_students = students_slice.map { |student| StudentShort.create_from_student(student) }
    if existing_data_list
      existing_data_list.replace_data(short_students)
      existing_data_list
    else
      Data_list_student_short.new(short_students)
    end
  end

  def sort_by_last_name_initials
    @students.sort_by! { |student| [student.last_name, student.first_name[0], student.middle_name[0]] }
  end

  def student_count
    @students.size
  end

  private

  def generate_new_id
    max_id = @students.map(&:student_id).max || 0
    max_id = max_id.to_i
    max_id + 1
  end

  # Методы для реализации в подклассах
  def parse_data(_raw_data)
    raise NotImplementedError, 'Метод parse_data должен быть реализован в подклассе'
  end

  def serialize_data
    raise NotImplementedError, 'Метод serialize_data должен быть реализован в подклассе'
  end
end
