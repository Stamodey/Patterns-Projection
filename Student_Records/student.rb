require_relative 'person'

# Класс Student наследует Person, добавляет специфическую информацию о студенте
class Student < Person
  attr_accessor :phone, :telegram, :email

  def initialize(last_name, first_name, middle_name, phone = nil, telegram = nil, email = nil, git = nil, id = nil)
    super(last_name, first_name, middle_name, id, git)
    self.phone = phone
    self.telegram = telegram
    self.email = email
  end

  def contact_info
    # Если указан Telegram и он валиден, он будет приоритетным
    if telegram && !telegram.strip.empty?
      validate_telegram(telegram)
      return "Telegram: #{telegram}"
    end
  
    # Если Telegram не указан, проверяем наличие телефона
    if phone && !phone.strip.empty?
      validate_phone(phone)
      return "Телефон: #{phone}"
    end
  
    # Если нет Telegram и телефона, проверяем наличие email
    if email && !email.strip.empty?
      validate_email(email)
      return "Email: #{email}"
    end
  
    # Если все поля пусты, возвращаем nil
    nil
  end
  
  def self.from_string(str)
    data = str.split(', ')
    raise 'Invalid format' if data.size < 4 || data.size > 8

    id = data[0].empty? ? nil : data[0].to_i
    last_name = data[1]
    first_name = data[2]
    middle_name = data[3]
    phone = data[4] if data.size > 4
    telegram = data[5] if data.size > 5
    email = data[6] if data.size > 6
    git = data[7] if data.size > 7

    new(last_name, first_name, middle_name, phone, telegram, email, git, id)
  end

  def validate_phone(phone)
    raise 'Некорректный номер телефона' unless phone.nil? || phone.match?(/\A(\+7|8)?\d{10,12}\z/)
  end

  def validate_telegram(telegram)
    raise 'Некорректный Telegram' unless telegram.nil? || telegram.match?(/\A@\w+\z/)
  end

  def validate_email(email)
    raise 'Некорректный email' unless email.nil? || email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end
end
