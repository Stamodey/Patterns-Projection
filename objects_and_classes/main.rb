require_relative 'student'

# Создание студентов с различными комбинациями полей
begin
  student1 = Student.new(
    id: 1,
    last_name: "Иванов", 
    first_name: "Иван", 
    middle_name: "Иванович", 
    phone: "+7(999)123-45-67", 
    git: "https://github.com/ivanov/repo.git"
  )
  puts student1
rescue => e
  puts "Ошибка создания студента 1: #{e.message}"
end

begin
  student2 = Student.new(
    id: 2,
    last_name: "Петров", 
    first_name: "Петр", 
    middle_name: "Петрович", 
    email: "petrov@mail.com", 
    git: "https://github.com/petrov/repo.git"
  )
  puts student2
rescue => e
  puts "Ошибка создания студента 2: #{e.message}"
end

# Пример ошибки: некорректный номер телефона и некорректный Git
begin
  student3 = Student.new(
    id: 3,  
    last_name: "Сидоров", 
    first_name: "Сидор", 
    middle_name: "Сидорович", 
    phone: "123", 
    git: "github.com/sidorov"
  )
rescue => e
  puts "Ошибка создания студента 3: #{e.message}"
end

# Пример использования метода set_contacts для обновления контактов
begin
  student2.set_contacts(phone: "+79990001122", telegram: "@test1", email: "new_petrov@mail.com")
  puts "Обновленные данные студента 2:"
  puts student2
rescue => e
  puts "Ошибка обновления контактов студента 2: #{e.message}"
end
