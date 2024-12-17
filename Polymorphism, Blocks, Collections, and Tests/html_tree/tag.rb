class Tag
  attr_accessor :name, :attributes, :content, :children, :parent

  def initialize(name, attributes = {}, content = "")
    @name = name
    @attributes = attributes
    @content = content
    @children = []
  end

  def add_child(child)
    child.parent = self
    @children << child
  end

  def to_s
    "Parent: #{parent_name}, Tag: #{name}, Children: #{children_names}"
  end

  def tag_name
    @name
  end

  def attribute_count
    @attributes.size
  end

  def has_children?
    !@children.empty?
  end

  def sample_string_method
    "This is a sample string."
  end

  def sample_number_method
    42
  end

  def sample_boolean_method
    true
  end

  private

  def parent_name
    @parent ? @parent.name : "None"
  end

  def children_names
    @children.map(&:name).join(", ")
  end

  def format_attributes
    return "" if @attributes.empty?
    " " + @attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(" ")
  end
end
