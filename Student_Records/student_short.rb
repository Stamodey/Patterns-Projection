class StudentShort < Person
  attr_reader :initials, :contact

  def self.create_from_student(student)
    raise ArgumentError, 'Input must be a Student object' unless student.is_a?(Student)
    data = prepare_student_data(student)
    new(*data)
  end

  def self.create_from_string(info_str)
    data = prepare_string_data(info_str)
    new(*data)
  end

  def to_s
    "ID: #{@id}; Initials: #{@initials}; GitHub: #{normalize_value(@git)}; Contact: #{@contact || 'нет'}"
  end


  def normalize_value(value)
    value.nil? || value.empty? ? 'нет' : value
  end

  def self.prepare_student_data(student)
    [
      student.id,
      student.initials,  # Используем метод initials из Person
      student.git,
      student.contact  # Используем метод contact из Student (и, соответственно, из Person)
    ]
  end

  # Подготовка данных из строки
  def self.prepare_string_data(info_str)
    parts = parse_info_string(info_str)
    contacts = { phone: parts[4], telegram: parts[5], email: parts[6] }
    [
      parts[0],
      parts[1],  # Инициалами теперь будет занимать Person (student.initials)
      parts[7],
      select_contact(contacts)
    ]
  end

  # Парсинг строки
  def self.parse_info_string(info_str)
    parts = info_str.split(', ').map(&:strip)
    raise ArgumentError, 'Invalid info format' if parts.size < 7
    parts
  end

  # Выбор контакта (первый ненулевой)
  def self.select_contact(contacts)
    contacts.values.find { |v| v && !v.empty? } || nil
  end

  private_class_method :new

  def initialize(id, initials, git, contact)
    @id, @initials, @git, @contact = id, initials, git, contact
  end
end
