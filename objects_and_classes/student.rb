class Student
  # Делаем атрибуты доступными через методы getter и setter
  attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  def initialize(attributes = {})
    # Устанавливаем фамилию, имя и отчество (обязательные)
    self.last_name = attributes[:last_name] || raise("Фамилия обязательна")
    self.first_name = attributes[:first_name] || raise("Имя обязательно")
    self.middle_name = attributes[:middle_name] || raise("Отчество обязательно")
    
    # Устанавливаем ID (если задано)
    self.id = attributes[:id]
    
    # Устанавливаем необязательные атрибуты (например, контакты)
    set_optional_attributes(attributes)
    
    # Проверяем валидность всех полей
    validate
  end

  # Метод класса для проверки допустимости номера телефона
  def self.valid_phone?(phone)
    phone.match?(/\A\+?\d{1,4}[-\s]?\(?\d{1,3}\)?[-\s]?\d{1,4}[-\s]?\d{1,4}[-\s]?\d{1,9}\z/)
  end

  # Метод класса для проверки правильности формата email
  def self.valid_email?(email)
    email.match?(/\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
  end

  # Метод класса для проверки правильности формата Telegram
  # Telegram должен начинаться с символа @ и содержать от 5 до 32 символов
  def self.valid_telegram?(telegram)
    telegram.match?(/\A@[a-zA-Z0-9_]{5,32}\z/)
  end

  # Метод класса для проверки правильности формата Git
  # Поддержка GitHub, GitLab, Bitbucket и других платформ
  def self.valid_git?(git)
    git.match?(/\A(https:\/\/(github\.com|gitlab\.com|bitbucket\.org|[a-zA-Z0-9._-]+\.[a-z]{2,})\/[a-zA-Z0-9_-]+\/[a-zA-Z0-9_-]+\.git)\z/)
  end

  # Метод класса для проверки ID (ID должен быть положительным целым числом)
  def self.valid_id?(id)
    id.is_a?(Integer) && id.positive?
  end

  # Метод валидации всех полей
  def validate
    raise "Некорректный номер телефона" if phone && !Student.valid_phone?(phone)
    raise "Некорректный email" if email && !Student.valid_email?(email)
    raise "Некорректный Telegram" if telegram && !Student.valid_telegram?(telegram)
    raise "Некорректный Git" if git && !Student.valid_git?(git)
    raise "ID должен быть положительным числом" if id && !Student.valid_id?(id)
    raise "Должен быть хотя бы один контакт: телефон, Telegram, email" if [phone, telegram, email].all?(&:nil?)
    raise "Git должен быть указан" if git.nil?
  end

  # Метод для установки контактов (телефон, Telegram, email)
  # Метод также проверяет валидность контактов
  def set_contacts(contacts = {})
    # Устанавливаем телефон, если он передан
    self.phone = contacts[:phone] if contacts[:phone]
    
    # Устанавливаем Telegram, если он передан
    self.telegram = contacts[:telegram] if contacts[:telegram]
    
    # Устанавливаем email, если он передан
    self.email = contacts[:email] if contacts[:email]
    
    # Повторная валидация полей после установки контактов
    validate
  end

  private

  # Метод для установки необязательных атрибутов (например, контактов)
  def set_optional_attributes(attributes = {})
    self.phone = attributes[:phone]         # Устанавливаем телефон
    self.telegram = attributes[:telegram]   # Устанавливаем Telegram
    self.email = attributes[:email]         # Устанавливаем email
    self.git = attributes[:git]             # Устанавливаем Git
  end


  # Метод для возврата строкового представления объекта Student
  def to_s
    "ID: #{id || 'не указан'}, Фамилия: #{last_name}, Имя: #{first_name}, Отчество: #{middle_name}, Телефон: #{phone || 'не указан'}, Telegram: #{telegram || 'не указан'}, Email: #{email || 'не указан'}, Git: #{git || 'не указан'}"
  end
end
