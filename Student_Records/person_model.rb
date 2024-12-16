class Person
  attr_reader :last_name, :first_name, :middle_name, :git, :id, :contacts

  def initialize(last_name:, first_name:, middle_name:, id: nil, git: nil, **contacts)
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    self.git = git
    @contacts = contacts
  end

  def initials
    self.class.generate_initials(@last_name, @first_name, @middle_name)
  end

  def contact
    self.class.select_contact(@contacts)
  end

  def self.valid_git?(git)
    git.match?(/\Ahttps:\/\/github\.com\/[a-zA-Z0-9._-]+\z/)
  end

  def self.valid_name?(name)
    name.match?(/\A[а-яА-Яa-zA-Z]+\z/)
  end

  def self.generate_initials(last_name, first_name, middle_name)
    "#{last_name} #{first_name[0]}." + (middle_name.to_s[0] ? " #{middle_name[0]}." : "")
  end

  def self.select_contact(contacts)
    contacts.values.find { |v| v && !v.empty? } || nil
  end

  private

  def last_name=(last_name)
    @last_name = self.class.valid_name?(last_name) ? last_name : nil
  end

  def first_name=(first_name)
    @first_name = self.class.valid_name?(first_name) ? first_name : nil
  end

  def middle_name=(middle_name)
    @middle_name = self.class.valid_name?(middle_name) ? middle_name : nil
  end

  def git=(git)
    @git = git.nil? || self.class.valid_git?(git) ? git : nil
  end

  def id=(id)
    @id = id
  end
end
