class DataTable
  def initialize(data)
    unless data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
      raise ArgumentError, 'Data must be a two-dimensional array'
    end

    self.data = data.freeze
  end

  def get_element(row, col)
    validate_indices(row, col)
    self.data[row][col]
  end

  # Получить количество строк
  def rows_count
    self.data.size
  end

  def columns_count
    self.data.first.size
  end

  private

  attr_accessor :data

  def validate_indices(row, col)
    if row < 0 || row >= rows_count || col < 0 || col >= columns_count
      raise IndexError, 'Index out of bounds'
    end
  end
end
