class Student
  attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  def initialize(id, last_name, first_name, middle_name = nil, phone = nil, telegram = nil, email = nil, git = nil)
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    self.phone = phone
    self.telegram = telegram
    self.email = email
    self.git = git
  end

  def to_s
    "ID: #{id}, Фамилия: #{last_name}, Имя: #{first_name}, Отчество: #{middle_name}, Телефон: #{phone}, Telegram: #{telegram}, Email: #{email}, Git: #{git}"
  end

  def validate!
    raise ArgumentError, 'Git не может быть пустым' if git.nil? || git.empty?
    raise ArgumentError, 'Необходимо указать хотя бы один контакт' if phone.nil? && telegram.nil? && email.nil?
  end
end
