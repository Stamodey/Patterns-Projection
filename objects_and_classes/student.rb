class Student
  # Делаем атрибуты доступными через методы getter и setter
  attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  # Инициализируем новый объект Student с заданными атрибутами
  def initialize(attributes = {})
    self.last_name = attributes[:last_name] || raise("Фамилия обязательна")   # Устанавливаем Фамилию
    self.first_name = attributes[:first_name] || raise("Имя обязательно")     # Устанавливаем Имя
    self.middle_name = attributes[:middle_name] || raise("Отчество обязательно") # Устанавливаем Отчество
    self.id = attributes[:id]                                                 # Устанавливаем ID
    set_optional_attributes(attributes)                                       # Устанавливаем необязательные атрибуты
    validate                                                                  # Проверка валидации
  end

  # Метод класса для проверки, является ли строка допустимым номером телефона
  def self.valid_phone?(phone)
    phone.match?(/\A\+?\d{1,14}\z/)
  end

   # Проверка правильности формата email
  def self.valid_email?(email)
    email.match?(/\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
  end

  # Проверка правильности формата telegram (начинается с @)
  def self.valid_telegram?(telegram)
    telegram.match?(/\A@[a-zA-Z0-9_]{5,32}\z/)
  end

  # Проверка правильности формата git (например, https://github.com/user/repo.git)
  def self.valid_git?(git)
    git.match?(/\Ahttps:\/\/github\.com\/[a-zA-Z0-9_-]+\/[a-zA-Z0-9_-]+\.git\z/)
  end

  # Метод валидации всех полей, включая номер телефона и обязательность контакта
  def validate
    raise "Некорректный номер телефона" if phone && !Student.valid_phone?(phone)
    raise "Некорректный email" if email && !Student.valid_email?(email)
    raise "Некорректный Telegram" if telegram && !Student.valid_telegram?(telegram)
    raise "Некорректный Git" if git && !Student.valid_git?(git)
    raise "Должен быть хотя бы один контакт: телефон, Telegram, email" if [phone, telegram, email].all?(&:nil?)
    raise "Git должен быть указан" if git.nil?
  end

  # Метод для установки контактов (телефон, Telegram, email)
  def set_contacts(contacts = {})
    self.phone = contacts[:phone] if contacts[:phone]
    self.telegram = contacts[:telegram] if contacts[:telegram]
    self.email = contacts[:email] if contacts[:email]
    validate
  end

  private

  # Метод для установки необязательных атрибутов
  def set_optional_attributes(attributes = {})
    self.phone = attributes[:phone]                                           # Устанавливаем Телефон, если он есть
    self.telegram = attributes[:telegram]                                     # Устанавливаем Telegram, если он есть
    self.email = attributes[:email]                                           # Устанавливаем Email, если он есть
    self.git = attributes[:git]                                               # Устанавливаем Git, если он есть
  end

  # Возвращаем строковое представление объекта Student
  def to_s
    "ID: #{id || 'не указан'}, Фамилия: #{last_name}, Имя: #{first_name}, Отчество: #{middle_name}, Телефон: #{phone || 'не указан'}, Telegram: #{telegram || 'не указан'}, Email: #{email || 'не указан'}, Git: #{git || 'не указан'}"
  end
end
