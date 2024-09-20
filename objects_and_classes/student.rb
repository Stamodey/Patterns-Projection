class Student
  # Делаем атрибуты доступными через методы getter и setter
  attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  # Инициализируем новый объект Student с заданными атрибутами
  def initialize(attributes = {})
    self.id = attributes[:id]                   # Устанавливаем ID
    self.last_name = attributes[:last_name]     # Устанавливаем Фамилию
    self.first_name = attributes[:first_name]   # Устанавливаем Имя
    self.middle_name = attributes[:middle_name] # Устанавливаем Отчество
    set_optional_attributes(attributes)         # Устанавливаем необязательные атрибуты
  end

  private

  # Метод для установки необязательных атрибутов
  def set_optional_attributes(attributes = {})
    self.phone = attributes[:phone] if attributes[:phone]             # Устанавливаем Телефон, если он есть
    self.telegram = attributes[:telegram] if attributes[:telegram]     # Устанавливаем Telegram, если он есть
    self.email = attributes[:email] if attributes[:email]               # Устанавливаем Email, если он есть
    self.git = attributes[:git] if attributes[:git]                     # Устанавливаем Git, если он есть
  end

  # Возвращаем строковое представление объекта Student
  def to_s
    "ID: #{id}, Фамилия: #{last_name}, Имя: #{first_name}, Отчество: #{middle_name}, Телефон: #{phone}, Telegram: #{telegram}, Email: #{email}, Git: #{git}"
  end
end
