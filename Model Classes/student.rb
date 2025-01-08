require_relative "person"

class Student < Person
  attr_reader :first_name, :last_name, :middle_name

  def initialize(first_name:, last_name:, middle_name:, student_id: nil, git: nil, phone: nil, email: nil, telegram: nil)
    super(student_id: student_id, git: git)
    self.first_name = first_name
    self.last_name = last_name
    self.middle_name = middle_name
    set_contacts(phone: phone, telegram: telegram, email: email)
  end

  def ==(other)
    return false unless other.is_a?(Student)
    self.git == other.git &&
      self.phone == other.phone &&
      self.email == other.email &&
      self.telegram == other.telegram
  end

  # Создание студента из строки, возвращенной методом to_s
  def self.from_string(data)
    attributes = parse_attributes(data)

    new(
      student_id: attributes["ID"],
      first_name: attributes["Имя"],
      last_name: attributes["Фамилия"],
      middle_name: attributes["Отчество"],
      phone: attributes["Телефон"],
      email: attributes["Почта"],
      telegram: attributes["Телеграм"],
      git: attributes["Гит"]
    )
  end

  # Вывод информации о студенте
  def to_s
    "ID: #{@student_id || ''}, Фамилия: #{@last_name}, Имя: #{@first_name}, Отчество: #{@middle_name}, " \
    "Телефон: #{@phone || ''}, Почта: #{@email || ''}, Телеграм: #{@telegram || ''}, Гит: #{@git || ''}"
  end

  def get_info()
    "ID: #{@student_id}, ФИО: #{@last_name} #{@first_name[0]}.#{@middle_name ? " #{@middle_name[0]}." : ''}, Git: #{@git ? @git : ''}, Тел: #{@phone ? @phone : ''}, Телеграм: #{@telegram ? @telegram : ''}, Почта: #{@email ? @email : ''} " \
  end

  def to_h
    {
      student_id: @student_id,
      first_name: @first_name,
      last_name: @last_name,
      middle_name: @middle_name,
      phone: @phone,
      email: @email,
      telegram: @telegram,
      git: @git
    }
  end
  

  # Метод для получения контактной информации
  def contact_info
    if !@phone.nil?
      return "#{@phone}"
    end
    if !@telegram.nil?
      return "#{@telegram}"
    end
    if !@email.nil?
      return "#{@email}"
    end
    ""
  end

  # Проверка наличия хотя бы одного контакта
  def contact_available?
    [@phone, @telegram, @email].any?
  end

  # Установка контактов
  def set_contacts(phone: nil, telegram: nil, email: nil)
    self.phone = phone
    self.telegram = telegram
    self.email =  email
  end

  # Разбор строки данных в хэш
  def self.parse_attributes(data)
    attributes = {}
    data.split(', ').each do |pair|
      key, value = pair.split(': ', 2)
      # Убираем пробелы и записываем значения в хэш
      attributes[key.strip] = value.strip if key && value
    end
    attributes
  end

  # Валидация для имени, фамилии и отчества
  def self.valid_name?(name)
    name.match?(/^[a-zA-Zа-яА-Я\s]+$/)
  end

  # Валидация телефона
  def self.valid_phone?(phone)
    phone.nil? || phone.empty? || phone.match?(/\A(\+\d{1,3}\s?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\z/)
  end

  # Валидация email
  def self.valid_email?(email)
    email.nil? || email.empty? || email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
  end

  # Валидация Telegram
  def self.valid_telegram?(telegram)
    telegram.nil? || telegram.empty? || telegram.match?(/\A@[a-zA-Z0-9_]+\z/)
  end

  # Сеттеры с валидацией
  def first_name=(value)
    raise ArgumentError, 'Неправильное имя' unless self.class.valid_name?(value)
    @first_name = value
  end

  def last_name=(value)
    raise ArgumentError, 'Неправильная фамилия' unless self.class.valid_name?(value)
    @last_name = value
  end

  def middle_name=(value)
    raise ArgumentError, 'Неправильное отчество' unless self.class.valid_name?(value)
    @middle_name = value
  end

  private
  def phone=(value)
    raise ArgumentError, 'Неправильный номер телефона' if value && !self.class.valid_phone?(value)
    @phone = value.empty? ? nil : value
  end

  def email=(value)
    raise ArgumentError, 'Неправильный email' if value && !self.class.valid_email?(value)
    @email = value.empty? ? nil : value
  end

  def telegram=(value)
    raise ArgumentError, 'Неправильный Telegram' if value && !self.class.valid_telegram?(value)
    @telegram = value.empty? ? nil : value
  end
end
