require_relative 'person'

class StudentShort < Person
  attr_reader :initials

  # Конструктор объекта класса StudentShort
  def initialize(data_or_id)
    case data_or_id
    when Student
      initialize_from_student(data_or_id)
    when String
      initialize_from_string(data_or_id)
    else
      raise ArgumentError, 'Invalid argument type. Must be Student or String.'
    end
  end

  # Метод для отображения информации
  def to_s
    info = []
    info.push("ID: #{@id}") if @id
    info.push("Initials: #{@initials}")
    info.push("GitHub: #{@git}") if @git
    info.compact.join("; ")
  end

  private

  # Приватные методы инициализации
  def initialize_from_student(student)
    @id = student.id
    @initials = "#{student.last_name} #{student.first_name[0]}. #{student.middle_name[0]}."
    @git = student.git
  end

  def initialize_from_string(string)
    data = string.split(', ')
    @id = data[0]
    @git = data[3]
  end
end
