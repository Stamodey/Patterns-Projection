require "pg"
require_relative "create_table"
require_relative "insert_in_table_student"

def db_pg_con
  PG.connect(
    dbname: "students", 
    user: "postgres",   
    password: "password",
    host: "localhost",   
    port: 5432       
  )
end


conn = db_pg_con

# Создание таблицы (при необходимости)
create_table(conn)

require_relative '../Student_list_JSON'
require_relative '../Student_list'

json = Student_list_JSON.new()
read = Student_list.new("../students.json", json)
students = read.read()

students.each do |student|
  puts student
  insert_into_table_student(conn, student)
end

conn.close
