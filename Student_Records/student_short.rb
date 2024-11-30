class StudentShort < Person
  attr_reader :initials, :contact

  def self.create_from_student(student)
    raise ArgumentError, nil unless student.is_a?(Student)
    new(student: student)
  end

  def self.create_from_string(info_str)
    new(info_str: info_str)
  end

  def to_s
    "ID: #{@id}; Initials: #{@initials}; GitHub: #{normalize_value(@git)}; Contact: #{@contact || 'нет'}"
  end

  private_class_method :new

  def initialize(student: nil, info_str: nil)
    data = student ? prepare_student_data(student) : prepare_string_data(info_str)
    initialize_attributes(*data)
  end

  def prepare_student_data(student)
    [student.id, generate_initials(student.last_name, student.first_name, student.middle_name), student.git, select_contact(student.contacts)]
  end

  def prepare_string_data(info_str)
    parts = parse_info_string(info_str)
    [parts[0], generate_initials(parts[1], parts[2], parts[3]), parts[7], select_contact(phone: parts[4], telegram: parts[5], email: parts[6])]
  end

  def initialize_attributes(id, initials, git, contact)
    @id, @initials, @git, @contact = id, initials, git, contact
  end

  def generate_initials(last_name, first_name, middle_name)
    "#{last_name} #{first_name[0]}." + (middle_name.to_s[0] ? " #{middle_name[0]}." : "")
  end

  def select_contact(contacts)
    contacts.values.find { |v| v && !v.empty? } || nil
  end

  def normalize_value(value)
    value.nil? || value.empty? ? nil : value
  end

  def parse_info_string(info_str)
    parts = info_str.split(', ').map(&:strip)
    raise ArgumentError, 'Invalid info format' if parts.size < 7
    parts
  end
end
