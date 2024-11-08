require_relative 'person'

class Student < Person
  # Чтение контактов
  attr_reader :contacts

  # Конструктор объекта класса Student
  def initialize(last_name:, first_name:, middle_name:, id: nil, git: nil, **contacts)
    super(last_name: last_name, first_name: first_name, middle_name: middle_name, id: id, git: git)
    set_contacts(contacts)
  end

  # Метод для установки контактов
  # Сохраняет контакты в хэш и валидирует их
  def set_contacts(contacts)
    @contacts = {}
    contacts.each do |type, value|
      case type
      when :phone
        self.phone = value unless value.nil? || value.empty?
      when :email
        self.email = value unless value.nil? || value.empty?
      when :telegram
        self.telegram = value unless value.nil? || value.empty?
      end
    end
  end

  # Метод класса для создания объекта из строки
  # Разбирает строку и создает объект Student
  def self.from_string(str)
    data = str.split(', ')
    
    # Проверка формата строки
    raise 'Invalid format' if data.size < 4 || data.size > 8

    id = data[0].empty? ? nil : data[0].to_i
    last_name = data[1]
    first_name = data[2]
    middle_name = data[3]
    
    # Контакты
    contacts = {}
    contacts[:phone] = data[4] if data.size > 4 && validate_phone(data[4])
    contacts[:telegram] = data[5] if data.size > 5 && validate_telegram(data[5])
    contacts[:email] = data[6] if data.size > 6 && validate_email(data[6])
    
    # GitHub
    git = data[7] if data.size > 7

    new(last_name: last_name, first_name: first_name, middle_name: middle_name, id: id, git: git, **contacts)
  end

  # Метод для получения информации о студенте
  def get_info
    initials = "#{@last_name} #{@first_name[0]}. #{@middle_name[0]}."
    # Сформировать строку с контактами
    contact_info = @contacts.map { |type, value| "#{type.capitalize}: #{value}" }.join("; ")
    contact_info_output = contact_info.empty? ? "Нет контактной информации" : contact_info
    # Формирование строки с информацией о студенте
    "Фамилия: #{@last_name}; Инициалы: #{initials}; Git: #{@git}; #{contact_info_output}"
  end

  protected

  # Сеттеры для контактов, защищенные, для валидации значений
  def phone=(phone)
    @contacts[:phone] = phone if self.class.validate_phone(phone)
  end

  def email=(email)
    @contacts[:email] = email if self.class.validate_email(email)
  end

  def telegram=(telegram)
    @contacts[:telegram] = telegram if self.class.validate_telegram(telegram)
  end

  # Методы класса для валидации контактов
  # Валидация телефона (формат с кодом страны +7 или 8)
  def self.validate_phone(phone)
    phone.match?(/\A(\+7|8)?\d{10,12}\z/)
  end

  # Валидация Telegram (@имя)
  def self.validate_telegram(telegram)
    telegram.match?(/\A@\w+\z/)
  end

  # Валидация email
  def self.validate_email(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end
end
