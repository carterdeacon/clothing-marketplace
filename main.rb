require 'sinatra' 
require 'sinatra/reloader'
require 'pg'
require 'bcrypt'

enable :sessions

require_relative 'models/items.rb'

def db_query(sql, params = [])
  conn = PG.connect(dbname: 'marketplace')
  result = conn.exec_params(sql, params)
  conn.close
  return result
end

def logged_in?()
  if session[:user_id]
    return true
  else
    return false
  end
end

def current_user()
  sql = "SELECT * FROM users WHERE id = $1;"
  user = db_query(sql, [session[:user_id]]).first
  return OpenStruct.new(user)
end

# Home page
get '/' do 
  items = all_items()
  erb :index, locals: {items: items}
end

# Items sorted by new 
get '/items/new' do
  items = new_items()
  erb :index, locals: {items: items}
end

# Individual item
get '/items/:id' do
  item_id = params['id']
  item = db_query("SELECT * FROM items WHERE id = $1;", [item_id]).first
  erb :view_item, locals: {item: item}
end

# Handle logins (users will user username rather than email)
get '/login' do
  erb :login
end

post '/session' do
  username = params['username']
  password = params['password']
  sql = "SELECT * FROM users WHERE username = $1;"
  result = db_query(sql, [username])
  if result.count > 0 && BCrypt::Password.new(result[0]['password_digest']) == password
    session[:user_id] = result[0]['id']
    redirect '/profile'
  else
    erb :login
  end
end

delete '/session' do 
  session[:user_id] = nil
  redirect '/login'
end

# User profile with all listings
get '/profile' do
  user_id = session[:user_id]
  listings = db_query("SELECT * FROM items WHERE user_id = '#{user_id}';")
  erb :profile, locals: {listings: listings}
end

# Get item on profile page (user specific)
get '/profile/items/:id' do
  redirect '/login' unless logged_in?
  item_id = params['id']
  item = db_query("SELECT * FROM items WHERE id = $1;", [item_id]).first
  erb :profile_items, locals: {item: item}
end

# Update listing page
get '/profile/items/:id/edit' do 
  item = db_query("SELECT * FROM items WHERE id = #{params['id']}").first
  erb :update_listing, locals: {item: item}
end

# Update listing form handling
put '/profile/items/:id' do
  redirect '/login' unless logged_in?
  id = params['id']
  designer = params['designer']
  image_url = params['image_url']
  category = params['category']
  colour = params['colour']
  price = params['price']
  currency = params['currency']
  update_listing(designer, image_url, category, colour, price, currency, id)
  redirect "/profile/items/#{params['id']}"
end

delete '/profile/items/:id' do
  remove_listing(params['id'])
  redirect '/profile'
end