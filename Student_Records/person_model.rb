# Суперкласс Person для представления основной информации о человеке
class Person
  # Определяем атрибуты для чтения
  attr_reader :id, :last_name, :first_name, :middle_name, :git, :contact_info

  # Конструктор для инициализации объекта Person
  def initialize(id, last_name, first_name, middle_name, git = nil, contact_info = nil)
    # Проверка обязательных полей (Фамилия, Имя, Отчество)
    raise 'Фамилия не может быть пустой' if last_name.nil? || last_name.strip.empty?
    raise 'Имя не может быть пустым' if first_name.nil? || first_name.strip.empty?
    raise 'Отчество не может быть пустым' if middle_name.nil? || middle_name.strip.empty?
    
    # Используем сеттеры для инициализации атрибутов
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    self.git = git
    self.contact_info = contact_info
  end

  # Метод для получения полного имени (Фамилия И.О.)
  def full_name
    "#{last_name} #{first_name[0]}.#{middle_name[0]}."
  end

  # Метод для получения общей информации о человеке
  def get_info
    "#{full_name}; Git: #{git}; Связь: #{contact_info}"
  end

  # Делаем сеттеры защищенными, чтобы предотвратить изменение полей вне класса и его наследников
  protected

  attr_writer :id, :git, :contact_info

  # Добавляем валидацию на ввод только букв
  def last_name=(last_name)
    raise 'Фамилия должна содержать только буквы' unless valid_name?(last_name)
    @last_name = last_name
  end

  def first_name=(first_name)
    raise 'Имя должно содержать только буквы' unless valid_name?(first_name)
    @first_name = first_name
  end

  def middle_name=(middle_name)
    raise 'Отчество должно содержать только буквы' unless valid_name?(middle_name)
    @middle_name = middle_name
  end

  # Метод для проверки валидности ФИО (разрешены только буквы)
  def valid_name?(name)
    /^[а-яА-Яa-zA-Z]+$/.match?(name)
  end
end
