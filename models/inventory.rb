require_relative("user")
require_relative("music_item")
require_relative("purchase")
require("pry-byebug")

class Inventory

  attr_reader :id
  attr_accessor :bought_flag, :selling_item_id, :seller_user_id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @bought_flag= options['bought_flag']
    @selling_item_id= options['selling_item_id'].to_i()
    @seller_user_id= options['seller_user_id'].to_i()
  end

  def save()
    sql= "INSERT INTO inventory_items
          (bought_flag, selling_item_id, seller_user_id)
          VALUES ($1, $2, $3)
          RETURNING id"
    values=[@bought_flag, @selling_item_id, @seller_user_id]
    @id= SqlRunner.run(sql, values)[0]['id']
  end

  def update()
    sql= "UPDATE inventory_items SET
          (bought_flag, selling_item_id, seller_user_id)
          = ($1, $2, $3) WHERE id=$4"
    values= [@bought_flag, @selling_item_id, @seller_user_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql= "DELETE FROM inventory_items WHERE id=$1"
    values= [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql= "DELETE FROM inventory_items"
    SqlRunner.run(sql)
  end

  def self.all()
    sql= "SELECT * FROM inventory_items"
    results= SqlRunner.run(sql)
    return Inventory.map_out(results)
  end

  def self.map_out(sql_results)
    return sql_results.map{|result| Inventory.new(result)}
  end

  def self.find_by_id(id)
    sql= "SELECT * FROM inventory_items WHERE id=$1"
    values= [id]
    result= SqlRunner.run(sql, values)
    return Inventory.new(result[0])
  end

  def self.item_gets_purchased(selling_user, buying_user, music_item)
    sql= "UPDATE inventory_items
          SET bought_flag = $1
          WHERE selling_item_id=$2 AND seller_user_id=$3"
    values= [true, music_item.id, selling_user.id]
    SqlRunner.run(sql, values)
    return Purchase.new({'bought_item_id'=>music_item.id, 'buyer_user_id'=>buying_user.id})
  end

end
