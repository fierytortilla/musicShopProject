require_relative("../db/sql_runner")
require_relative("user")
require_relative("category")

class MusicItem

  attr_reader :id
  attr_accessor :item_name, :buying_cost, :category_id, :selling_price, :user_id, :bought_flag

  def initialize(options)
    @id= options['id'].to_i() if options['id']
    @item_name= options['item_name']
    @buying_cost= options['buying_cost'].to_f()
    @selling_price= options['selling_price'].to_f()
    @bought_flag= options['bought_flag']
    @category_id= options['category_id'].to_i()
    @user_id= options['user_id'].to_i()
  end

  def save()
    sql= "INSERT INTO music_items
          (item_name, buying_cost, selling_price, bought_flag, category_id, user_id)
          VALUES ($1, $2, $3, $4, $5, $6)
          RETURNING id"
    values=[@item_name, @buying_cost, @selling_price, @bought_flag, @category_id, @user_id]
    @id= SqlRunner.run(sql, values)[0]['id'].to_i()
  end

  def update()
    sql= "UPDATE music_items SET
          (item_name, buying_cost, selling_price, bought_flag, category_id, user_id)
          = ($1, $2, $3, $4, $5, $6) WHERE id=$7"
    values= [@item_name, @buying_cost, @selling_price, @bought_flag, @category_id, @user_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql= "DELETE FROM music_items WHERE id=$1"
    values= [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql= "SELECT * FROM music_items"
    results= SqlRunner.run(sql)
    return MusicItem.map_out(results)
  end

  def self.find_by_id(id)
    sql= "SELECT * FROM music_items WHERE id=$1"
    values= [id]
    result= SqlRunner.run(sql, values)
    return MusicItem.new(result[0])
  end

  def self.delete_all()
    sql= "DELETE FROM music_items"
    SqlRunner.run(sql)
  end

  def self.map_out(sql_results)
    return sql_results.map{|result| MusicItem.new(result)}
  end

  def self.all_on_sale()
    sql= "SELECT * FROM music_items WHERE bought_flag= $1"
    values= [false]
    results= SqlRunner.run(sql, values)
    return MusicItem.map_out(results)
  end

  def find_owner()
    sql= "SELECT * FROM users WHERE id= $1"
    values= [@user_id]
    return User.new(SqlRunner.run(sql, values)[0])
  end

  def find_category_name()
    sql= "SELECT * FROM categories where id= $1"
    values=[@category_id]
    category= Category.new(SqlRunner.run(sql, values)[0])
    return category.name
  end

end
