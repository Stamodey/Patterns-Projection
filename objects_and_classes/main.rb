require_relative 'student'

# Создание студентов с различными комбинациями полей
student1 = Student.new(last_name: "Иванов", first_name: "Иван", middle_name: "Иванович", phone: "+79991234567", git: "https://github.com/ivanov")
student2 = Student.new(last_name: "Петров", first_name: "Петр", middle_name: "Петрович", email: "petrov@mail.com", git: "https://github.com/petrov/repo.git")

# Вывод информации о студентах
puts student1
puts student2

# Пример ошибки: Некорректный номер телефона
begin
  student3 = Student.new(last_name: "Сидоров", first_name: "Сидор", middle_name: "Сидорович", phone: "123", git: "github.com/sidorov")
rescue => e
  puts e.message
end

# Пример использования метода set_contacts
student2.set_contacts(phone: "+79990001122", email: "new_petrov@mail.com")
puts student2
