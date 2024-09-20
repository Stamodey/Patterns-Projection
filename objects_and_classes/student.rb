class Student
  # делаем атрибуты доступными через методы getter и setter
  attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  # Инициализировать новый объект Student с заданными атрибутами
  def initialize(id, last_name, first_name, middle_name, phone = nil, telegram = nil, email = nil, git = nil)
    # Установить атрибуты используя предоставленные значения
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    self.phone = phone
    self.telegram = telegram
    self.email = email
    self.git = git
  end

  # возвращаем строковое представление объекта Student
  def to_s
    # Форматировать строку для включения всех атрибутов
    "ID: #{id}, Фамилия: #{last_name}, Имя: #{first_name}, Отчество: #{middle_name}, Телефон: #{phone}, Telegram: #{telegram}, Email: #{email}, Git: #{git}"
  end
end