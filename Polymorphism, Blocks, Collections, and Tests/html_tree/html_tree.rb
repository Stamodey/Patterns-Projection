require_relative 'html_tag'

class HTMLTree
  include Enumerable

  def initialize(root)
    @root = root
  end

  # Создание дерева из структуры
  def self.build_from_structure(structure)
    children = structure[:children]&.map { |child| build_from_structure(child) } || []
    HTMLTag.new(structure[:name], structure[:attributes] || {}, children, structure[:content])
  end

  # Итерация в глубину (DFS)
  def each(&block)
    traverse_depth_first(@root, &block)
  end

  # Итерация в ширину (BFS)
  def each_breadth_first(&block)
    queue = [@root]
    until queue.empty?
      node = queue.shift
      block.call(node)
      queue.concat(node.children)
    end
  end

  private

  # Глубокий обход дерева (DFS)
  def traverse_depth_first(node, &block)
    block.call(node)
    node.children.each { |child| traverse_depth_first(child, &block) }
  end
end
