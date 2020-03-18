require_relative("../db/sql_runner")

class Category

  attr_reader :id, :name

  def initialize(options)
    @id= options['id'].to_i if options['id']
    @name= options['category_name']
  end

  def save()
    sql= "INSERT INTO categories
          (category_name)
          VALUES ($1)
          RETURNING id"
    values=[@name]
    @id= SqlRunner.run(sql, values)[0]['id']
  end

  def self.delete_all()
    sql= "DELETE FROM categories"
    SqlRunner.run(sql)
  end

  def update()
    sql= "UPDATE categories SET
          (category_name)
          = ($1) WHERE id=$2"
    values= [@category_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql= "DELETE FROM categories WHERE id=$1"
    values= [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql= "SELECT * FROM categories"
    results= SqlRunner.run(sql)
    return Category.map_out(results)
  end

  def self.map_out(sql_results)
    return sql_results.map{|result| Category.new(result)}
  end

  def self.find_by_id(id)
    sql= "SELECT * FROM categories WHERE id=$1"
    values= [id]
    result= SqlRunner.run(sql, values)
    return Category.new(result[0])
  end

end
