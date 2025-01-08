require_relative 'student_short'
require_relative 'student'
require_relative 'data_list_student_short'

class StudentList
  def initialize(file, data_storage_strategy)
    @file = file
    self.data_storage_strategy = data_storage_strategy
    @array = read()
  end

  def data_storage_strategy= (data_storage_strategy)
    @data_storage_strategy = data_storage_strategy
  end

  def read()
    begin
      file = File.open(@file,"r")
    rescue => e
      puts e
    end
    array = from(file)
    file.close()
    return array
  end
  
  def write(list_students)
    begin
      file = File.open(@file,"w")
    rescue => e
      puts e
    end
    to(list_students, file)
    file.close()
  end  

  def search_on_id(number)
    return @array.select(){|x| x.id == number}
  end
    

  def get_k_n_student_short_list(k, n, data_list = nil)
    raise "Нет такого количества объктов n" if n > @array.size()
    qty = (@array.size()/n).to_i
    raise "Нет такого количества страниц" if k > qty

    students_short = []

    for index in 0...n
      item = @array[(k-1)*n + index]
      if (item != nil) 
        std = StudentShort.new(item) 
      else 
        next
      end
      std.id = index
      students_short << std
    end
    return Data_list_student_short.new(StudentShort)
  end

  def sort_by_lastname_and_initals()
    @array.sort_by{|x| x.last_name_and_initials}
  end

  def add_student(Student)

    duplicate = @array.include?(student) 
    raise "Студент с такими данными уже существует" if duplicate

    max_id = @array.max_by{|x| x.id}
    id = 0
    id = max_id 1 if !max_id
    student.id = id
    @array << student
  end

  def replace_student_by_id(id, student)
    @array.select{|x| x.id == id}.map{|x| x = student} 
  end

  def delete_student_by_id(id)
    @array.delete_if{|x| x.id == id}
  end

  def get_student_short_count()
    @array.size()
  end

  private 

  def from(file)
    @data_storage_strategy.from(file)
  end

  def to(list_students, file)
    @data_storage_strategy.to(list_students, file)
  end

end
