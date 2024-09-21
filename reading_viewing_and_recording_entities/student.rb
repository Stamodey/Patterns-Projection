# Суперкласс Person для представления основной информации о человеке
class Person
  # Определяем атрибуты для чтения
  attr_reader :id, :last_name, :first_name, :middle_name, :git, :contact_info

  # Конструктор для инициализации объекта Person
  def initialize(id, last_name, first_name, middle_name, git = nil, contact_info = nil)
    # Используем сеттеры для инициализации атрибутов
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    self.git = git
    self.contact_info = contact_info
  end

  # Метод для получения полного имени (Фамилия И.О.)
  def full_name
    "#{last_name} #{first_name[0]}.#{middle_name[0]}."
  end

  # Метод для получения общей информации о человеке
  def get_info
    "#{full_name}; Git: #{git}; Связь: #{contact_info}"
  end

  # Делаем сеттеры защищенными, чтобы предотвратить изменение полей вне класса и его наследников
  protected

  attr_writer :id, :last_name, :first_name, :middle_name, :git, :contact_info
end

# Класс Student наследует Person, добавляет специфическую информацию о студенте
class Student < Person
  # Добавляем дополнительные атрибуты для контактов
  attr_accessor :phone, :telegram, :email

  # Конструктор для инициализации объекта Student
  def initialize(id, last_name, first_name, middle_name, phone = nil, telegram = nil, email = nil, git = nil)
    # Вызов конструктора суперкласса Person
    super(id, last_name, first_name, middle_name, git)
    # Инициализация дополнительных атрибутов
    self.phone = phone
    self.telegram = telegram
    self.email = email
  end

  # Переопределяем метод для получения информации о контактах
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

  # Статический метод для создания объекта Student из строки
  def self.from_string(str)
    # Разделение строки по запятым
    data = str.split(', ')
    raise 'Invalid format' if data.size < 4 || data.size > 8

    # Присвоение переменных из данных
    id = data[0].to_i
    last_name = data[1]
    first_name = data[2]
    middle_name = data[3]
    phone = data[4] if data.size > 4
    telegram = data[5] if data.size > 5
    email = data[6] if data.size > 6
    git = data[7] if data.size > 7

    # Возвращаем новый объект Student
    new(id, last_name, first_name, middle_name, phone, telegram, email, git)
  end
end

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

# Метод для чтения данных из файла с информацией о студентах
def self.read_from_txt(file_path)
  # Проверка наличия файла
  raise 'Некорректный адрес файла' unless File.exist?(file_path)

  # Инициализация пустого списка студентов
  students = []
  # Открытие файла и построчное чтение
  File.open(file_path, 'r') do |file|
    file.each_line do |line|
      # Добавляем каждого студента в массив
      students << Student.from_string(line.chomp)
    end
  end
  students
rescue => e
  # Обработка возможных ошибок при чтении
  raise "Ошибка при чтении файла: #{e.message}"
end

# Пример тестирования
begin
  # Пример создания объекта Student из строки
  student_str = '1, Snake, Solid, David, 1234567897, @solidsnake, solid.snake@game.com, solidsnake'
  student = Student.from_string(student_str)
  puts student.get_info

  # Пример создания объекта Student_short из строки
  short_student_str = 'Петров, Петр, Сидоров, git_petrov, Телефон: 1234567890'
  student_short = Student_short.from_string(2, short_student_str)
  puts student_short.get_info
rescue => e
  # Обработка ошибок
  puts "Ошибка: #{e.message}"
end

# Пример использования метода read_from_txt
begin
  # Чтение студентов из файла
  students_from_file = read_from_txt('students.txt')
  students_from_file.each { |student| puts student.get_info }
rescue => e
  # Обработка ошибок
  puts "Ошибка: #{e.message}"
end
