require_relative 'tag'

class HtmlTree
  include Enumerable

  attr_reader :root

  def initialize(file_path)
    raise "Unsupported file format" unless HtmlTree.html?(file_path)

    content = File.read(file_path)
    @root = build_tree(content)
    @tree = flatten_tree(@root)
  end

  def self.html?(file_path)
    !!file_path&.match(/\.html$/i)
  end

  def each(&block)
    traverse_depth_first(@root, &block)
  end

  def each_breadth_first(&block)
    traverse_breadth_first(@root, &block)
  end

  def select(&block)
    return nil if @tree.nil? || @tree.empty?

    new_array = []
    @tree.each do |item|
      new_array << item if block.call(item)
    end

    new_array
  end

  private

  def build_tree(content)
    stack = []
    root = nil
    current_parent = nil

    content.scan(/<[^>]+>|[^<]+/).map(&:strip).each do |element|
      if element.start_with?("<") && !element.start_with?("</")
        tag_name, *attr_parts = element.gsub(/[<>\/]/, '').split
        attributes = parse_attributes(attr_parts)

        tag = Tag.new(tag_name, attributes)
        if current_parent
          current_parent.add_child(tag)
        else
          root = tag
        end

        stack.push(tag) unless element.end_with?("/>")
        current_parent = tag unless element.end_with?("/>")
      elsif element.start_with?("</")
        stack.pop
        current_parent = stack.last
      else
        current_parent.content << element if current_parent
      end
    end

    root
  end

  def parse_attributes(attr_parts)
    attributes = {}
    attr_parts.each do |attr|
      key, value = attr.split('=')
      attributes[key] = value ? value.gsub('"', '') : nil
    end
    attributes
  end

  def flatten_tree(node)
    result = [node]
    node.children.each do |child|
      result.concat(flatten_tree(child))
    end
    result
  end

  def traverse_depth_first(node, &block)
    block.call(node)
    node.children.each do |child|
      traverse_depth_first(child, &block)
    end
  end

  def traverse_breadth_first(node, &block)
    queue = [node]
    until queue.empty?
      current = queue.shift
      block.call(current)
      queue.concat(current.children)
    end
  end
end
