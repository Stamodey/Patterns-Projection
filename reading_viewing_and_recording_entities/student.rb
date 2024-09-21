class Student
  attr_reader :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  # Основной конструктор с параметрами
  def initialize(id, last_name, first_name, middle_name, phone = nil, telegram = nil, email = nil, git = nil)
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    self.phone = phone
    self.telegram = telegram
    self.email = email
    self.git = git
  end
  
  # Метод get_info, возвращает краткую информацию
  def get_info
    "#{last_name} #{first_name[0]}.#{middle_name[0]}; Git: #{git}; Связь: #{contact_info}"
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

  # Конструктор, принимающий строку
  def self.from_string(str)
    data = str.split(', ')
    raise 'Invalid format' if data.size < 4 || data.size > 8

    # Разделение обязательных и необязательных данных
    id = data[0].to_i
    last_name = data[1]
    first_name = data[2]
    middle_name = data[3]
    phone = data[4] if data.size > 4
    telegram = data[5] if data.size > 5
    email = data[6] if data.size > 6
    git = data[7] if data.size > 7

    # Вызов стандартного конструктора
    new(id, last_name, first_name, middle_name, phone, telegram, email, git)
  rescue => e
    raise "Error parsing string: #{e.message}"
  end
end
# Пример тестирования класса
begin
  student_str = '1, Snake, Solid, David, 1234567897, @solidsnake, solid.snake@game.com, solidsnake'
  
  # Создание объекта через строку
  student = Student.from_string(student_str)
  puts student.get_info
rescue => e
  puts "Ошибка: #{e.message}"
end

