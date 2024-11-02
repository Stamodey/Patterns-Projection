require_relative 'person'

class StudentShort < Person
  attr_reader :initials, :contacts

  # Конструктор объекта класса StudentShort, принимает только объект Student
  def initialize(student)
    raise ArgumentError, 'Argument must be a Student' unless student.is_a?(Student)
    
    initialize_attributes
    initialize_from_student(student)
  end

  # Метод для создания объекта StudentShort из строки
  def self.from_string(string)
    data = string.split(', ')
    student_short = new(Student.new(
      last_name: data[1], 
      first_name: data[2], 
      middle_name: data[3], 
      id: data[0].to_i, 
      git: data[4]
    ))

    student_short.add_contact(data[5], 'Contact') if data.size > 5
    student_short
  end

  # Метод для отображения информации
  def to_s
    info = []
    info << "ID: #{@id}" if @id
    info << "Initials: #{@initials}"
    info << "GitHub: #{@git}" if @git
    info << "Contact: #{@contacts.first}" if @contacts.any?
    info.compact.join("; ")
  end

  private

  # Приватный метод для инициализации атрибутов
  def initialize_attributes
    @id = nil
    @initials = ''
    @git = nil
    @contacts = []
  end

  # Приватные методы инициализации
  def initialize_from_student(student)
    @id = student.id
    @initials = "#{student.last_name} #{student.first_name[0]}. #{student.middle_name[0]}."
    @git = student.git
    student.contacts.each { |type, value| add_contact(value, type.capitalize) }
  end

  # Метод для добавления контакта
  def add_contact(value, type)
    @contacts << "#{type}: #{value}" if value
  end
end
