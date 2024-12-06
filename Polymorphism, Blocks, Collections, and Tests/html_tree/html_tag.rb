class HTMLTag
  attr_reader :name, :attributes, :children, :content

  def initialize(name, attributes = {}, children = [], content = nil)
    @name = name
    @attributes = attributes
    @children = children
    @content = content
  end

  # Представление тега в виде строки
  def to_s
    if @name == :text
      content_string
    elsif children.empty? && content.nil?
      "<#{@name}#{attributes_string} />"
    else
      "<#{@name}#{attributes_string}>#{content_string}#{children_string}</#{@name}>"
    end
  end

  # Возвращает строку аттрибутов
  def attributes_string
    return "" if @attributes.empty?
    " " + @attributes.map { |k, v| "#{k}='#{v}'" }.join(" ")
  end

  # Возвращает строку содержимого
  def content_string
    return "" if @content.nil?
    @content
  end

  # Возвращает строку всех дочерних тегов
  def children_string
    @children.map(&:to_s).join
  end
end
