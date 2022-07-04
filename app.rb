require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'lib/recipe'
require_relative 'lib/cookbook'

cookbook = Cookbook.new("./lib/recipes.csv")


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get "/" do
  @cookbook = cookbook
  erb :index
end

get "/about" do
  erb :about
end

get "/team/:username" do
  "The username is #{params[:username]}"
end

get "/new" do
  erb :new
end

get "/recipes" do
  cookbook.add_recipe(Recipe.new(params))
  redirect to('/')
end

get "/delete" do
  recipe_index = params[:index].to_i
  cookbook.remove_recipe(recipe_index)
  redirect to('/')
end
