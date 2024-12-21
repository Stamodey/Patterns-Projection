require_relative 'StudentShort'

students = [
  StudentShort.new(1, "Alice", 20),
  StudentShort.new(2, "Bob", 22),
  StudentShort.new(3, "Charlie", 24)
]

students.each do |student|
  puts "Student: #{student.name}, Age: #{student.age}"
end
