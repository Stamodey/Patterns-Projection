
require_relative 'person'

class StudentShort < Person
  attr_reader :initials, :contacts

  # Конструктор объекта класса StudentShort, принимает объект Student
  # Проверка, что аргумент является объектом класса Student
  def initialize(student)
    raise ArgumentError, 'Argument must be a Student' unless student.is_a?(Student)
    
    initialize_attributes
    initialize_from_student(student)
  end

  # Метод для создания объекта StudentShort из строки
  # Разбирает строку и создает объект StudentShort с использованием данных
  def self.from_string(string)
    data = string.split(', ')
    
    # Создаем объект StudentShort, передавая необходимые параметры
    student_short = new(Student.new(
      last_name: data[1], 
      first_name: data[2], 
      middle_name: data[3], 
      id: data[0].to_i, 
      git: data[4]
    ))

    # Если контакт есть, добавляем его в объект
    student_short.add_contact(data[5], 'Contact') if data.size > 5
    student_short
  end

  # Метод для отображения информации о StudentShort
  # Формирует строку с информацией об объекте
  def to_s
    info = []
    info << "ID: #{@id}" if @id
    info << "Initials: #{@initials}"
    info << "GitHub: #{@git}" if @git
    info << "Contact: #{@contacts.first}" if @contacts.any?
    info.compact.join("; ")
  end

  private

  # Приватный метод для инициализации атрибутов объекта
  # Устанавливает начальные значения атрибутов
  def initialize_attributes
    @id = nil
    @initials = ''
    @git = nil
    @contacts = []
  end

  # Приватный метод для инициализации объекта на основе данных из Student
  def initialize_from_student(student)
    @id = student.id
    @initials = "#{student.last_name} #{student.first_name[0]}. #{student.middle_name[0]}."
    @git = student.git
    # Добавляем все контакты из объекта Student
    student.contacts.each { |type, value| add_contact(value, type.capitalize) }
  end

  # Метод для добавления контакта в список контактов
  # Если контакт существует, добавляем его
  def add_contact(value, type)
    @contacts << "#{type}: #{value}" if value
  end
end
