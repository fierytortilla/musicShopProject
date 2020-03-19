require_relative("../db/sql_runner")

class User

  attr_reader :id, :user_name, :email_address

  def initialize(options)
    @id= options['id'].to_i if options['id']
    @user_name= options['user_name']
    @email_address= options['email_address']
  end

  def save()
    sql= "INSERT INTO users
          (user_name, email_address, active_flag)
          VALUES ($1, $2, $3)
          RETURNING id"
    values=[@user_name, @email_address, @active_flag]
    @id= SqlRunner.run(sql, values)[0]['id'].to_i()
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

  def self.map_out(sql_results)
    return sql_results.map{|result| User.new(result)}
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

  def get_users_items_for_sale()
    sql= "SELECT * FROM inventory_items WHERE seller_user_id=$1"
    values=[@id]
    items_for_sale= SqlRunner.run(sql, values)
    return Inventory.map_out(items_for_sale)
  end

  def get_users_purchased_items()
    sql= "SELECT * FROM purchased_items WHERE buyer_user_id=$1"
    values=[@id]
    purchased_items= SqlRunner.run(sql, values)
    return Purchase.map_out(purchased_items)
  end

end
