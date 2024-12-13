require_relative 'person'

class Student < Person
  attr_reader :contacts

  def initialize(last_name:, first_name:, middle_name:, id: nil, git: nil, **contacts)
    super(last_name: last_name, first_name: first_name, middle_name: middle_name, id: id, git: git)
    set_contacts(contacts)
  end

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

  def self.from_string(str)
    data = str.split(', ')
    raise ArgumentError, "Invalid input format: #{str}" if data.size < 4 || data.size > 8

    id = data[0].empty? ? nil : data[0].to_i
    last_name = data[1]
    first_name = data[2]
    middle_name = data[3]
    contacts = {}
    contacts[:phone] = data[4] if data.size > 4 && validate_phone(data[4])
    contacts[:telegram] = data[5] if data.size > 5 && validate_telegram(data[5])
    contacts[:email] = data[6] if data.size > 6 && validate_email(data[6])
    git = data[7] if data.size > 7

    new(last_name: last_name, first_name: first_name, middle_name: middle_name, id: id, git: git, **contacts)
  end

  def to_s
    "ID: #{@id}, Фамилия: #{@last_name}, Имя: #{@first_name}, Отчество: #{@middle_name}, " \
    "Телефон: #{@contacts[:phone]}, Телеграм: #{@contacts[:telegram]}, Почта: #{@contacts[:email]}, Гит: #{@git}"
  end

  def get_info 
    "ID: #{@id}, ФИО: #{@last_name} #{@first_name[0]}.#{@middle_name ? " #{@middle_name[0]}." : ''}, " \
    "Git: #{@git || 'нет'}, " \
    "Контакт: #{@contacts[:phone] || @contacts[:telegram] || @contacts[:email] || 'нет контактов'}"
  end
  
  protected

  def phone=(phone)
    @contacts[:phone] = phone if self.class.validate_phone(phone)
  end

  def email=(email)
    @contacts[:email] = email if self.class.validate_email(email)
  end

  def telegram=(telegram)
    @contacts[:telegram] = telegram if self.class.validate_telegram(telegram)
  end

  def self.validate_phone(phone)
    phone.match?(/\A(\+7|8)?\d{10,12}\z/)
  end

  def self.validate_telegram(telegram)
    telegram.match?(/\A@\w+\z/)
  end

  def self.validate_email(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end
end
