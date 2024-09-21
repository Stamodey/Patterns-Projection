# Суперкласс Person
class Person
  attr_reader :id, :last_name, :first_name, :middle_name, :git, :contact_info

  # Основной конструктор с параметрами для общего функционала
  def initialize(id, last_name, first_name = nil, middle_name = nil, git = nil, contact_info = nil)
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    self.git = git
    self.contact_info = contact_info
  end

  # Метод для получения Фамилия и Инициалы
  def full_name
    if first_name && middle_name
      "#{last_name} #{first_name[0]}.#{middle_name[0]}."
    else
      last_name
    end
  end

  protected

  attr_writer :id, :last_name, :first_name, :middle_name, :git, :contact_info
end

# Класс Student наследует Person
class Student < Person
  attr_reader :phone, :telegram, :email

  def initialize(id, last_name, first_name, middle_name, phone = nil, telegram = nil, email = nil, git = nil)
    super(id, last_name, first_name, middle_name, git)
    self.phone = phone
    self.telegram = telegram
    self.email = email
  end

  # Метод для получения информации о связи
  def contact_info
    if phone
      "Телефон: #{phone}"
    elsif telegram
      "Telegram: #{telegram}"
    elsif email
      "Email: #{email}"
    else
      "Нет контактной информации"
    end
  end

  # Метод get_info, возвращает краткую информацию о студенте
  def get_info
    "#{full_name}; Git: #{git}; Связь: #{contact_info}"
  end

  # Конструктор, принимающий строку
  def self.from_string(str)
    data = str.split(', ')
    raise 'Invalid format' if data.size < 4 || data.size > 8

    id = data[0].to_i
    last_name = data[1]
    first_name = data[2]
    middle_name = data[3]
    phone = data[4] if data.size > 4
    telegram = data[5] if data.size > 5
    email = data[6] if data.size > 6
    git = data[7] if data.size > 7

    new(id, last_name, first_name, middle_name, phone, telegram, email, git)
  end

  protected

  attr_writer :phone, :telegram, :email
end

# Класс Student_short наследует Person
class Student_short < Person
  def initialize(student)
    super(student.id, student.last_name, student.first_name, student.middle_name, student.git, student.contact_info)
  end

  # Альтернативный конструктор: принимает ID и строку с информацией
  def self.from_string(id, info_str)
    data = info_str.split(', ')
    raise 'Invalid format' if data.size < 2

    last_name = data[0]
    initials = data[1]
    git = data[2] if data.size > 2
    contact = data[3] if data.size > 3

    # Используем суперкласс для создания объекта
    new(Person.new(id, last_name, nil, nil, git, contact))
  end

  # Переопределение метода для краткой информации о студенте
  def get_info
    "#{full_name}; Git: #{git}; Связь: #{contact_info}"
  end
end

# Пример тестирования
begin
  student_str = '1, Snake, Solid, David, 1234567897, @solidsnake, solid.snake@game.com, solidsnake'
  student = Student.from_string(student_str)
  puts student.get_info

  student_short_str = 'Snake, S.D., solidsnake, Телефон: 1234567897'
  student_short = Student_short.from_string(1, student_short_str)
  puts student_short.get_info
rescue => e
  puts "Ошибка: #{e.message}"
end


