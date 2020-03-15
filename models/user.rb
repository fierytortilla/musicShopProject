

class User

  def initialize(options)
    @id= options['id'].to_i if options['id']
    @name= options['name']
    @email_address= options['email_address']
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
