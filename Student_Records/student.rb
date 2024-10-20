require_relative 'person'

class Student < Person
  attr_reader :contacts

  # Конструктор объекта класса Student
  def initialize(last_name:, first_name:, middle_name:, id: nil, git: nil, **contacts)
    super(last_name: last_name, first_name: first_name, middle_name: middle_name, id: id, git: git)
    set_contacts(contacts)
  end

  # Метод для установки контактов
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
      else
        raise 'Некорректный тип контакта'
      end
    end
  end

  # Сеттеры для контактов
  def phone=(phone)
    self.class.validate_phone(phone)
    @contacts[:phone] = phone if phone
  end

  def email=(email)
    self.class.validate_email(email)
    @contacts[:email] = email if email
  end

  def telegram=(telegram)
    return if telegram.nil? || telegram.empty?
    self.class.validate_telegram(telegram)
    @contacts[:telegram] = telegram if telegram
  end

  # Методы класса для валидации контактов
  def self.validate_phone(phone)
    raise 'Некорректный номер телефона' unless phone.nil? || phone.match?(/\A(\+7|8)?\d{10,12}\z/)
  end

  def self.validate_telegram(telegram)
    raise 'Некорректный Telegram' unless telegram.nil? || telegram.match?(/\A@\w+\z/)
  end

  def self.validate_email(email)
    raise 'Некорректный email' unless email.nil? || email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end


  # Метод класса для создания объекта из строки
  def self.from_string(str)
    data = str.split(', ')
    raise 'Invalid format' if data.size < 4 || data.size > 8

    id = data[0].empty? ? nil : data[0].to_i
    last_name = data[1]
    first_name = data[2]
    middle_name = data[3]
    contacts = {}
    contacts[:phone] = data[4] if data.size > 4
    contacts[:telegram] = data[5] if data.size > 5
    contacts[:email] = data[6] if data.size > 6
    git = data[7] if data.size > 7

    new(last_name: last_name, first_name: first_name, middle_name: middle_name, id: id, git: git, **contacts)
  end

  # Метод для получения информации о студенте
  def get_info
    initials = "#{last_name} #{first_name[0]}. #{middle_name[0]}."
    contact_info = contacts.map { |type, value| "#{type.capitalize}: #{value}" }.join("; ")
    contact_info_output = contact_info.empty? ? "Нет контактной информации" : contact_info
    "Фамилия: #{last_name}; Инициалы: #{initials}; Git: #{git}; #{contact_info_output}"
  end
end
