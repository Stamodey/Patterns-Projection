def create_table(conn)
  begin
    conn.exec(
      "
      CREATE TABLE IF NOT EXISTS Student (
        id SERIAL PRIMARY KEY,
        last_name VARCHAR(100),
        first_name VARCHAR(100),
        surname VARCHAR(100),
        github VARCHAR(100),
        phone VARCHAR(17),
        mail VARCHAR(100)
      );
      "
    )
    puts "Таблица Student создана или уже существует."
  rescue PG::Error => e
    puts "Ошибка при создании таблицы: #{e.message}"
  end
end
