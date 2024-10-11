require_relative 'student'

# Класс Student_short для создания объекта с укороченной информацией о студенте
class Student_short < Person
  # Конструктор для инициализации через объект Student
  def initialize(student)
    # Вызов конструктора суперкласса с нужными полями
    super(student.id, student.last_name, student.first_name, student.middle_name, student.git, student.contact_info)
  end

  # Альтернативный конструктор: принимает ID и строку с информацией
  def self.from_string(id, info_str)
    # Разделение строки по запятым
    data = info_str.split(', ')
    raise 'Invalid format' if data.size < 3

    # Присвоение переменных
    last_name = data[0]
    first_name = data[1]
    middle_name = data[2]
    git = data[3] if data.size > 3
    contact = data[4] if data.size > 4

    # Создаем временный объект Student и изменяем контактную информацию
    student = Student.new(id, last_name, first_name, middle_name, nil, nil, nil, git)
    student.instance_variable_set(:@contact_info, contact)

    # Возвращаем объект Student_short на основе Student
    new(student)
  end
end
