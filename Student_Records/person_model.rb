class Person
  attr_reader :last_name, :first_name, :middle_name, :git, :id

  # Конструктор объекта класса Person
  def initialize(last_name:, first_name:, middle_name:, id: nil, git: nil)
    self.id = id
    self.last_name = last_name  # Сеттер для фамилии
    self.first_name = first_name # Сеттер для имени
    self.middle_name = middle_name # Сеттер для отчества
    self.git = git               # Сеттер для Git
  end

  # Сеттеры для атрибутов
  def last_name=(last_name)
    validate_name!(last_name, 'Фамилия должна содержать только буквы')
    @last_name = last_name
  end

  def first_name=(first_name)
    validate_name!(first_name, 'Имя должно содержать только буквы')
    @first_name = first_name
  end

  def middle_name=(middle_name)
    validate_name!(middle_name, 'Отчество должно содержать только буквы')
    @middle_name = middle_name
  end

  def git=(git)
    raise 'Неверный формат Git' unless git.nil? || self.class.valid_git?(git)
    @git = git
  end
  
  def id=(id)
    @id = id
  end

  # Методы класса для валидации
  def self.valid_git?(git)
    git.match?(/\Ahttps:\/\/github\.com\/[a-zA-Z0-9._-]+\z/)
  end

  def self.valid_name?(name)
    name.match?(/\A[а-яА-Яa-zA-Z]+\z/)
  end

  private

  # Приватный метод для валидации имени
  def validate_name!(name, error_message)
    raise error_message unless self.class.valid_name?(name)
  end
end
