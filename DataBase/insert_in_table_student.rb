require_relative "../Studend"

def insert_into_table_student(conn, student)
  begin
    query = "
      INSERT INTO Student (student_id, last_name, first_name, middle_name, github, phone, email)
      VALUES ($1, $2, $3, $4, $5, $6, $7)
    "

    # Подготовка параметров
    id = student.student_id
    last_name = student.last_name
    first_name = student.first_name
    middle_name = student.middle_name || "null"
    github = student.github || "null"
    phone = student.phone || "null"
    email = student.email || "null"

    # Выполнение запроса
    conn.exec_params(query, [
      student_id,
      last_name,
      first_name,
      middle_name,
      github,
      phone,
      email
    ])
    puts "Студент #{first_name} #{last_name} добавлен в базу данных."
  rescue PG::Error => e
    puts "Ошибка при вставке данных: #{e.message}"
  end
end
