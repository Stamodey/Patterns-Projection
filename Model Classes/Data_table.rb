class DataTable

  attr_accessor :data

  def initialize(data)
    # Инициализация данных через конструктор
    self.data = data
  end


  # Получить элемент по номеру строки и столбца
  def get_element(row, col)
    data[row][col]
  end

  # Получить количество столбцов
  def num_columns
    data.first.length
  end

  # Получить количество строк
  def num_rows
    data.length
  end
end
