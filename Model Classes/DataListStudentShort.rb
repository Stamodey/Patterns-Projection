class DataListStudentShort < DataList
  private

  def extract_attributes
    %w[initials contact]
  end

  def format_data
    elements.each_with_index.map do |element, index|
      [index + 1] + extract_attributes.map { |attr| element.public_send(attr) }
    end
  end

  public

  def get_names
    ["№"] + extract_attributes
  end

  def get_data
    DataTable.new(format_data)
  end
end
