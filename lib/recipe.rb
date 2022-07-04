class Recipe
  attr_reader :name, :description, :rating, :is_done

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @rating = args[:rating]
    @is_done = false
  end
end
