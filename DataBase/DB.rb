require_relative "../obs/Studend"
require "pg"

class DB
  private_class_method :new
  @instance = nil

  def initialize(user, pass, dbname = 'students', host = 'localhost', port = 5432)
    raise 'База данных уже подключена' if @user && @pass

    self.user = user
    self.pass = pass
    @dbname = dbname
    @host = host
    @port = port

    connect()
  end

  attr_accessor :user, :pass

  def self.instance(user = nil, pass = nil, dbname = 'students', host = 'localhost', port = 5432)
    @instance ||= new(user, pass, dbname, host, port)
    @instance
  end

  def connect
    begin
      @conn = PG.connect(
        dbname: @dbname,
        user: @user,
        password: @pass,
        host: @host,
        port: @port
      )
    rescue PG::Error => e
      puts "Ошибка подключения: #{e.message}"
    end
  end

  def disconnect
    @conn.close if @conn
    @user = nil
    @pass = nil
  end

  def select_from_table(student_id: nil, last_name: nil, first_name: nil, middle_name: nil, github: nil, phone: nil, email: nil)
    query = 'SELECT * FROM student'
    conditions = []

    conditions << "student_id = #{id}" if student_id
    conditions << "last_name = '#{last_name}'" if last_name
    conditions << "first_name = '#{first_name}'" if first_name
    conditions << "middle_name = '#{student_id}'" if middle_name
    conditions << "github = '#{github}'" if github
    conditions << "phone = '#{phone}'" if phone
    conditions << "email = '#{email}'" if email

    query += " WHERE #{conditions.join(' AND ')}" unless conditions.empty?

    begin
      result = @conn.exec(query)
      result.each { |row| puts row }
    rescue PG::Error => e
      puts "Ошибка выполнения запроса: #{e.message}"
    end
  end

  def insert_into_table_student(student)
    begin
      query = <<-SQL
        INSERT INTO student (id, last_name, first_name, surname, github, phone, mail)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
      SQL

      @conn.exec_params(query, [
        student.id,
        student.last_name,
        student.first_name,
        student.surname || 'null',
        student.github || 'null',
        student.phone || 'null',
        student.mail || 'null'
      ])
      puts "Студент с ID #{student.id} успешно добавлен."
    rescue PG::Error => e
      puts "Ошибка вставки данных: #{e.message}"
    end
  end

  def create_table
    begin
      query = <<-SQL
        CREATE TABLE IF NOT EXISTS student (
          id SERIAL PRIMARY KEY,
          last_name VARCHAR(100),
          first_name VARCHAR(100),
          surname VARCHAR(100),
          github VARCHAR(100),
          phone VARCHAR(17),
          mail VARCHAR(100)
        );
      SQL

      @conn.exec(query)
      puts "Таблица student успешно создана."
    rescue PG::Error => e
      puts "Ошибка создания таблицы: #{e.message}"
    end
  end

  def drop_table
    begin
      @conn.exec('DROP TABLE IF EXISTS student')
      puts "Таблица student успешно удалена."
    rescue PG::Error => e
      puts "Ошибка удаления таблицы: #{e.message}"
    end
  end
end
