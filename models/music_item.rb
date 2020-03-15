

class MusicItem

  def initialize(options)
    @id= options['id'].to_i() if options['id']
    @item_name= options['item_name']
    @buying_cost= options['buying_cost'].to_f()
    @selling_price= options['selling_price'].to_f()
    @category_id= options['category_id']
  end

  def save()

  end

  def update()

  end

  def delete()

  end

  def self.all()

  end

  def self.find_by_id(id)

  end

  def self.delete_all()

  end


end
