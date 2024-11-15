class Person
  attr_reader :last_name, :first_name, :middle_name, :git, :id

  def initialize(last_name:, first_name:, middle_name:, id: nil, git: nil)
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    self.git = git
  end

  private

  def last_name=(last_name)
    if self.class.valid_name?(last_name)
      @last_name = last_name
    else
      false
    end
  end

  def first_name=(first_name)
    if self.class.valid_name?(first_name)
      @first_name = first_name
    else
      false
    end
  end

  def middle_name=(middle_name)
    if self.class.valid_name?(middle_name)
      @middle_name = middle_name
    else
      false
    end
  end

  def git=(git)
    if git.nil? || self.class.valid_git?(git)
      @git = git
    else
      false
    end
  end

  def id=(id)
    @id = id
  end

  # Сделаем проверки доступными для классов-наследников
  protected

  def self.valid_git?(git)
    git.match?(/\Ahttps:\/\/github\.com\/[a-zA-Z0-9._-]+\z/)
  end

  def self.valid_name?(name)
    name.match?(/\A[а-яА-Яa-zA-Z]+\z/)
  end
end
