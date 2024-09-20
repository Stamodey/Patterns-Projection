class Student
  attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git
  
  def initialize(id, last_name, first_name, middle_name, phone = nil, telegram = nil, email = nil, git = nil)
    self.id = id
      self.last_name = last_name
      self.first_name = first_name
      self.middle_name = middle_name
      self.phone = phone
      self.telegram = telegram
      self.email = email
      self.git = git
  end
end