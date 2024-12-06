require_relative 'file_parser'
require_relative 'html_tree'

if __FILE__ == $0
  puts "Enter the path to the file (HTML):"
  file_path = gets.chomp
  begin
    structure = FileParser.parse(file_path)
    raise "File structure is empty" if structure.nil? || structure.empty?

    root = HTMLTree.build_from_structure(structure.first)  # Начинаем с первого элемента структуры
    tree = HTMLTree.new(root)
    
    puts "Depth-first traversal:"
    tree.each { |tag| puts tag }

    puts "---"
    
    puts "Breadth-first traversal:"
    tree.each_breadth_first { |tag| puts tag }
  rescue => e
    puts "Error: #{e.message}"
  end
end
