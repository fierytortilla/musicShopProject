require_relative("user")
require_relative("music_item")
require("pry-byebug")

class Purchase

  attr_reader :id
  attr_accessor :bought_item_id, :buyer_user_id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @bought_item_id= options['bought_item_id'].to_i()
    @buyer_user_id= options['buyer_user_id'].to_i()
  end

  def save()
    sql= "INSERT INTO purchased_items
          (bought_item_id, buyer_user_id)
          VALUES ($1, $2)
          RETURNING id"
    values=[@bought_item_id, @buyer_user_id]
    binding.pry()
    @id= SqlRunner.run(sql, values)[0]['id']
  end

  def update()
    sql= "UPDATE purchased_items SET
          (bought_item_id, buyer_user_id)
          = ($1, $2) WHERE id=$3"
    values= [@bought_flag, @bought_item_id, @buyer_user_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql= "DELETE FROM purchased_items WHERE id=$1"
    values= [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql= "DELETE FROM purchased_items"
    SqlRunner.run(sql)
  end

  def self.all()
    sql= "SELECT * FROM purchased_items"
    results= SqlRunner.run(sql)
    return Purchase.map_out(results)
  end

  def self.map_out(sql_results)
    return sql_results.map{|result| Purchase.new(result)}
  end

  def self.find_by_id(id)
    sql= "SELECT * FROM purchased_items WHERE id=$1"
    values= [id]
    result= SqlRunner.run(sql, values)
    return Purchase.new(result[0])
  end

end
