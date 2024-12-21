class DataList

  attr_accessor :elements, :selected_indices

  def initialize(elements = [])
    self.elements = elements
    self.selected_indices = []
  end

  # Метод для выделения элемента по номеру
  def select(number)
    self.selected_indices << number unless self.selected_indices.include?(number)
  end

  # Метод для получения массива id выделенных элементов
  def get_selected
    self.selected_indices.map { |index| self.elements[index].id }
  end

  # Метод для получения массива наименований атрибутов, кроме ID
  # Должен быть переопределен в наследниках
  def get_names
    raise NotImplementedError, "Этот метод должен быть реализован в наследниках"
  end

  # Метод для получения объекта класса Data_table
  # Должен быть переопределен в наследниках
  def get_data
    raise NotImplementedError, "Этот метод должен быть реализован в наследниках"
  end

  # Очистка массива выделенных индексов
  def clear_selected
    self.selected_indices.clear
  end
end
