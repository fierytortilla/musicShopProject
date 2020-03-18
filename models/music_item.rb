require_relative("../db/sql_runner")
require_relative("inventory")
require_relative("purchase")

class MusicItem

  attr_reader :id
  attr_accessor :item_name, :buying_cost, :category_id, :selling_price

  def initialize(options)
    @id= options['id'].to_i() if options['id']
    @item_name= options['item_name']
    @buying_cost= options['buying_cost'].to_f()
    @selling_price= options['selling_price'].to_f()
    @category_id= options['category_id']
  end

  def save()
    sql= "INSERT INTO music_items
          (item_name, buying_cost, selling_price, category_id)
          VALUES ($1, $2, $3, $4)
          RETURNING id"
    values=[@item_name, @buying_cost, @selling_price, @category_id]
    @id= SqlRunner.run(sql, values)[0]['id']
  end

  def update()
    sql= "UPDATE music_items SET
          (item_name, buying_cost, selling_price, category_id)
          = ($1, $2, $3, $4) WHERE id=$5"
    values= [@item_name, @buying_cost, @selling_price, @category_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql= "DELETE FROM music_items WHERE id=$1"
    values= [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql= "SELECT * FROM categories"
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
    sql= "SELECT * FROM inventory_items WHERE selling_item_id= $1"
    values= [@id]
    result= Inventory.new(SqlRunner.run(sql, values)[0])
    if result.bought_flag==false
      return result
    else
      sql= "SELECT * FROM purchased_items WHERE bought_item_id= $1"
      values= [@id]
      return Purchase.new(SqlRunner.run(sql, values)[0])
    end
  end

  def still_on_sale()
    sql= "SELECT * FROM inventory_items WHERE selling_item_id= $1"
    values= [@id]
    result= Inventory.new(SqlRunner.run(sql, values)[0])
    if result.bought_flag == false
      return true
    else
      return false
    end
  end


end
