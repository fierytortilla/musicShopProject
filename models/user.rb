require_relative("../db/sql_runner")

class User

  attr_reader :id, :name, :email_address
  attr_accessor :active_flag

  def initialize(options)
    @id= options['id'].to_i if options['id']
    @name= options['name']
    @email_address= options['email_address']
    @active_flag= options['active_flag']
  end

  def save()
    sql= "INSERT INTO users
          (user_name, email_address, active_flag)
          VALUES ($1, $2, $3)
          RETURNING id"
    values=[@name, @email_address, @active_flag]
    @id= SqlRunner.run(sql, values)[0]['id']
  end

  def update()
    sql= "UPDATE users SET
          (user_name, email_address, active_flag)
          = ($1) WHERE id=$2"
    values= [@category_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql= "DELETE FROM users WHERE id=$1"
    values= [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql= "SELECT * FROM users"
    results= SqlRunner.run(sql)
    return User.map_out(results)

  end

  def self.find_by_id(id)
    sql= "SELECT * FROM users WHERE id=$1"
    values= [id]
    result= SqlRunner.run(sql, values)
    return User.new(result[0])
  end

  def self.delete_all()
    sql= "DELETE FROM users"
    SqlRunner.run(sql)
  end

end
