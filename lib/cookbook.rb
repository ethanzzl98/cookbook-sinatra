require_relative 'recipe'
require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(@csv_file_path, headers: :first_row) do |row|
      @recipes << Recipe.new(
        {
          name: row['name'],
          description: row['description'],
          rating: row['rating'].to_i,
          is_done: (row['is_done'] == "true")
        }
      )
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    CSV.open(@csv_file_path, "a") do |csv|
      csv << recipe_to_a(recipe)
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    header = ["name", "description", "rating", "is_done"]
    CSV.open(@csv_file_path, "w") do |csv|
      csv << header
      @recipes.each do |recipe|
        csv << recipe_to_a(recipe)
      end
    end
  end

  def recipe_to_a(recipe)
    [recipe.name, recipe.description, recipe.rating, recipe.is_done]
  end
end
