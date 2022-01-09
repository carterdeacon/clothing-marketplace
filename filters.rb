require 'sinatra' 
require 'sinatra/reloader'
require 'pg'

require_relative 'models/items.rb'
require_relative 'models/users.rb'

# Items sorted by new 
get '/items/new' do
    items = new_items()
    erb :index, locals: {items: items}
end

# Items filtered by category
get '/items/jackets' do
    jackets = db_query("SELECT * FROM items where category = 'Jackets' ORDER BY id;")
    erb :jackets, locals: {jackets: jackets}
end
get '/items/shirts' do
    shirts = db_query("SELECT * FROM items where category = 'Shirts' ORDER BY id;")
    erb :shirts, locals: {shirts: shirts}
end

get '/items/tees' do
    tees = db_query("SELECT * FROM items where category = 'Tees' ORDER BY id;")
    erb :tees, locals: {tees: tees}
end

get '/items/pants' do
    pants = db_query("SELECT * FROM items where category = 'Pants' ORDER BY id;")
    erb :pants, locals: {pants: pants}
end

get '/items/shorts' do
    shorts = db_query("SELECT * FROM items where category = 'Shorts' ORDER BY id;")
    erb :shorts, locals: {shorts: shorts}
end

get '/items/shoes' do
    shoes = db_query("SELECT * FROM items where category = 'Shoes' ORDER BY id;")
    erb :shoes, locals: {shoes: shoes}
end

get '/items/accessories' do
    accessories = db_query("SELECT * FROM items where category = 'Accessories' ORDER BY id;")
    erb :accessories, locals: {accessories: accessories}
end