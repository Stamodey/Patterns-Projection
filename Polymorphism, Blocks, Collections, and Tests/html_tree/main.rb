require_relative 'html_tree'

html_tree = HtmlTree.new('D:/Ruby/html/example.html')

# Перебор элементов в глубину
puts "Traversal in Depth First:"
html_tree.each do |tag|
  puts tag
end

# Перебор элементов в ширину
puts "\nTraversal in Breadth First:"
html_tree.each_breadth_first do |tag|
  puts tag
end

# Пример использования метода select
puts "\nSelecting tags with name 'div':"
selected_tags = html_tree.select { |tag| tag.name == 'div' }
selected_tags.each do |tag|
  puts tag
end
