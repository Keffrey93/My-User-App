require 'sqlite3'

class User
    attr_accessor :id, :firstname, :lastname, :age, :password, :email

    def initialize(id = 0, firstname, lastname, age, password, email)
        @id = id
        @firstname = firstname
        @lastname = lastname
        @age = age
        @email = email
        @password = password
    end

    def self.connectDb()
        begin
            @db = SQLite3::Database.open 'db.sql'
            @db = SQLite3::Database.new 'db.sql' if !@db
            @db.results_as_hash = true
            @db.execute <<-SQL
                CREATE TABLE IF NOT EXISTS users (
                    id INTEGER PRIMARY KEY,
                    firstname STRING,
                    lastname STRING,
                    age INTEGER,
                    email STRING,
                    password STRING
                );
            SQL
            return @db
        rescue SQLite3::Exception => e
            puts "Error occurred: #{e}"
        end
    end

    def self.create(user_info)
        @db = self.connectDb
        @db.execute "INSERT INTO users (firstname, lastname, age, email, password) VALUES (?, ?, ?, ?, ?)", user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:email], user_info[:password]
        user = User.new(user_info[:firstname], user_info[:lastname], user_info[:age], '', user_info[:email])
        user.id = @db.last_insert_row_id
        @db.close
        return user
    end

    def self.all()
        @db = self.connectDb()
        user = @db.execute "SELECT * FROM users"
        @db.close
        return user
    end

    def self.find(user_id)
        @db = self.connectDb
        user = @db.execute "SELECT * FROM users WHERE id = ?", user_id
        user_info = User.new(user[0]["firstname"], user[0]["lastname"], user[0]["age"], user[0]["password"], user[0]["email"])
        @db.close
        return user_info
    end

    def self.update(user_id, attribute, value)
        @db = self.connectDb
        @db.execute "UPDATE users SET #{attribute} = ? WHERE id = ? ", value, user_id
        user = @db.execute "SELECT * FROM users where id = ? ", user_id
        @db.close
        return user
    end

    def self.authenticate(password, email)
        @db = self.connectDb
        user = @db.execute "SELECT * FROM users WHERE email = ? AND password = ?", email, password
        @db.close
        return user
    end

    def self.destroy(user_id)
        @db = self.connectDb()
        @db.execute "DELETE FROM users WHERE id = ?", user_id
        @db.close
        return true
    end
end
