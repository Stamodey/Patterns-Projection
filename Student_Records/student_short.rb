class StudentShort < Person
  attr_reader :initials, :contact

  def self.create_from_student(student)
    raise ArgumentError, nil unless student.is_a?(Student)
    data = self.prepare_student_data(student)
    new(*data)
  end

  def self.create_from_string(info_str)
    data = self.prepare_string_data(info_str)
    new(*data)
  end

  def to_s
    "ID: #{@id}; Initials: #{@initials}; GitHub: #{normalize_value(@git)}; Contact: #{@contact || 'нет'}"
  end

  private_class_method :new

  def self.prepare_student_data(student)
    [student.id, self.generate_initials(student.last_name, student.first_name, student.middle_name), student.git, self.select_contact(student.contacts)]
  end

  def self.prepare_string_data(info_str)
    parts = self.parse_info_string(info_str)
    [parts[0], self.generate_initials(parts[1], parts[2], parts[3]), parts[7], self.select_contact(phone: parts[4], telegram: parts[5], email: parts[6])]
  end

  def initialize(id, initials, git, contact)
    @id, @initials, @git, @contact = id, initials, git, contact
  end

  def self.generate_initials(last_name, first_name, middle_name)
    "#{last_name} #{first_name[0]}." + (middle_name.to_s[0] ? " #{middle_name[0]}." : "")
  end

  def self.select_contact(contacts)
    contacts.values.find { |v| v && !v.empty? } || nil
  end

  def normalize_value(value)
    value.nil? || value.empty? ? nil : value
  end

  def self.parse_info_string(info_str)
    parts = info_str.split(', ').map(&:strip)
    raise ArgumentError, 'Invalid info format' if parts.size < 7
    parts
  end
  
end
