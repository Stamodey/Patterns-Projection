class Student < Person
  def initialize(last_name:, first_name:, middle_name:, id: nil, git: nil, **contacts)
    super(last_name: last_name, first_name: first_name, middle_name: middle_name, id: id, git: git, **contacts)
    valid_keys = [:phone, :telegram, :email]
    invalid_keys = contacts.keys - valid_keys
    raise ArgumentError, "Invalid contact keys: #{invalid_keys}" unless invalid_keys.empty?
  end

  def primary_contact
    contact
  end

  def to_s
    "ID: #{@id}, Фамилия: #{@last_name}, Имя: #{@first_name}, Отчество: #{@middle_name || 'нет'}, " \
    "Телефон: #{@contacts[:phone] || 'нет'}, Телеграм: #{@contacts[:telegram] || 'нет'}, " \
    "Почта: #{@contacts[:email] || 'нет'}, Гит: #{@git || 'нет'}"
  end

  def get_info
    "ID: #{@id}, ФИО: #{@last_name} #{@first_name[0]}." +
      (@middle_name ? " #{@middle_name[0]}." : "") +
      ", Git: #{@git || 'нет'}, " +
      "Контакт: #{primary_contact || 'нет контактов'}"
  end

  def self.from_string(str)
    data = str.split(', ').map(&:strip)
    raise ArgumentError, "Invalid input format: #{str}" if data.size < 7

    id = data[0].empty? ? nil : data[0].to_i
    last_name = data[1]
    first_name = data[2]
    middle_name = data[3]

    contacts = {}
    contacts[:phone] = data[4] if data.size > 4 && validate_phone(data[4])
    contacts[:telegram] = data[5] if data.size > 5 && validate_telegram(data[5])
    contacts[:email] = data[6] if data.size > 6 && validate_email(data[6])
    git = data[7] if data.size > 7 && valid_git?(data[7])

    new(last_name: last_name, first_name: first_name, middle_name: middle_name, id: id, git: git, **contacts)
  end

  def self.validate_phone(phone)
    phone.match?(/\A(\+7|8)?[-\s]?\d{3}[-\s]?\d{7}\z/)
  end

  def self.validate_telegram(telegram)
    telegram.match?(/\A@\w{3,32}\z/)
  end

  def self.validate_email(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end

  def self.valid_git?(git)
    git.match?(/\Ahttps:\/\/github\.com\/[a-zA-Z0-9._-]+\z/)
  end
end
