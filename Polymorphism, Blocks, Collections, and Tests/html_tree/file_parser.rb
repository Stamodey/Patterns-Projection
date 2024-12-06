class FileParser
  def self.parse(file_path)
    extension = File.extname(file_path).downcase
    raise "Unsupported file format: #{extension}" unless extension == ".html"

    content = File.read(file_path)
    parse_html(content)
  end

  def self.parse_html(content)
    parse_html_recursive(content)
  end

  def self.parse_html_recursive(content)
    tags = []
    # Регулярное выражение для захвата тега с атрибутами и содержимым
    regex = /<(\w+)([^>]*)>(.*?)<\/\1>/m
    content.scan(regex) do |name, attributes, inner_content|
      tag_attributes = parse_attributes(attributes)
      children = parse_html_recursive(inner_content)

      if children.empty? && !inner_content.strip.empty?
        children << { name: :text, attributes: {}, children: [], content: inner_content.strip }
      end

      tags << { name: name, attributes: tag_attributes, children: children, content: nil }
    end
    tags
  end

  # Парсинг атрибутов тега
  def self.parse_attributes(attributes_string)
    attributes = {}
    attributes_string.scan(/(\w+)="([^"]*)"/) do |name, value|
      attributes[name] = value
    end
    attributes
  end
end
