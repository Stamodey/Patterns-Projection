class StudentShort < Person
  attr_reader :initials, :contacts

  # Конструктор объекта класса StudentShort, принимает объект Student
  def initialize(student)
    raise ArgumentError, 'Argument must be a Student' unless student.is_a?(Student)
    
    initialize_attributes
    initialize_from_student(student)
  end

  # Метод для отображения информации о StudentShort
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
  def add_contact(value, type)
    @contacts << "#{type}: #{value}" if value
  end
end
