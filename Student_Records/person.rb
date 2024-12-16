class Person
  attr_reader :student_id, :git

  def initialize(git:, student_id: nil)
    self.student_id = student_id
    self.git = git
  end

  # Validators for setters
  def self.valid_git?(git)
    git.match?(/\Ahttps?:\/\/(www\.)?github\.com\/[a-zA-Z0-9_-]+\/[a-zA-Z0-9_-]+(\/|\z)/) ||
      git.match?(/\Agit@github\.com:[a-zA-Z0-9_-]+\/[a-zA-Z0-9_-]+\.git\z/)
  end

  def self.valid_student_id?(student_id)
    student_id.nil? || student_id.strip.empty? || student_id.match?(/^\d+$/)
  end

  def student_id=(student_id)
    raise ArgumentError, "Invalid Student ID format" unless self.class.valid_student_id?(student_id)

    @student_id = student_id
  end

  def validate?
    contact_available? && git_available?
  end

  def contact_available?
    raise NotImplementedError, "Person must implement method contact_available"
  end

  def git_available?
    !git.nil?
  end

  protected

  def git=(git)
    raise ArgumentError, "Invalid Git format" unless self.class.valid_git?(git)

    @git = git
  end
end
