require_relative 'Data_table'

class Data_list
  def initialize(data)
    self.array = data
    @selected = []
  end

  def array=(data)
    @array = data
  end

  def select(number)
    raise "Неверный индекс" if number >= @array.size || number < 0

    if !@selected.include?(number)
      @selected << number
    else
      @selected.delete(number)
    end
  end

  def get_selected
    selected_array_id = []
    @selected.each { |index| selected_array_id << @array[index].id }
    selected_array_id
  end

  def get_names
    raise NotImplementedError, "Метод get_names не реализован"
  end

  def get_data
    table = []
    @array.each_with_index do |item, index|
      table << ([index + 1] + attributes(item))
    end
    DataTable.new(table)
  end

  def attributes(item)
    raise NotImplementedError, "Метод attributes не реализован"
  end
end
