class StudentShort < Person
  attr_reader :initials, :contacts

  # Конструктор объекта класса StudentShort, принимает объект Student
  def initialize(student)
    raise ArgumentError, 'Argument must be a Student' unless student.is_a?(Student)
    
    # Инициализация только необходимых полей
    @id = student.id
    @initials = "#{student.last_name} #{student.first_name[0]}. #{student.middle_name[0]}."
    @git = student.git
    @contacts = []

    # Добавляем все контакты из объекта Student
    student.contacts.each { |type, value| add_contact(value, type.capitalize) }
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

  # Приватный метод для добавления контакта в список контактов
  def add_contact(value, type)
    @contacts << "#{type}: #{value}" if value
  end
end
