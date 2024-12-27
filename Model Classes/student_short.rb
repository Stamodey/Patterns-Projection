class StudentShort < Person
  attr_reader :initials, :contact

  def self.create_from_student(student)
    new(
      student_id: student.student_id,
      git: student.git,
      initials: "#{student.last_name} #{student.first_name[0]}.#{student.middle_name ? " #{student.middle_name[0]}." : ''}",
      contact: student.contact_info
    )
  end

  def self.create_from_string(string)
    attributes = {}

    string.split(', ').each do |pair|
      key, value = pair.split(': ')
      attributes[key] = value
    end

    new(
      student_id: attributes['student_id'],
      git: attributes['git'],
      initials: attributes['surname_initials'],
      contact: attributes['contact']
    )
  end

  def to_s
    "ID: #{@student_id}, ФИО: #{@initials} Git: #{@git.nil? ? 'нет' : @git} Контакт: #{@contact.nil? ? 'нет' : @contact}"
  end

  def contact_available?
    !@contact.nil?
  end

  def initials=(value)
    unless value.match?(/\A[А-ЯЁ][а-яё]+\s[А-ЯЁ]\.\s[А-ЯЁ]\.\z/) || value.match?(/\A[А-ЯЁ][а-яё]+\s[А-ЯЁ]\.\z/)
      raise ArgumentError, "Неправильно введено ФИО"
    end
    @initials = value
  end

  private_class_method :new

  def initialize(student_id:, git:, initials:, contact: nil)
    super(student_id: student_id, git: git)
    self.initials = initials
    @contact = contact
  end
end
