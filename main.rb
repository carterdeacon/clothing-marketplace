require 'sinatra' 
require 'sinatra/reloader'
require 'pg'
require 'bcrypt'

enable :sessions

require_relative 'filters.rb'
require_relative 'models/items.rb'
require_relative 'models/users.rb'

# Home page
get '/' do 
  items = all_items()
  erb :index, locals: {items: items}
end

get '/new' do
  erb :new_listing
end

post '/items' do
  redirect '/login' unless logged_in?
  user_id = session[:user_id]
  designer = params['designer']
  image_url = params['image_url']
  category = params['category']
  colour = params['colour']
  price = params['price']
  currency = params['currency']
  create_listing(user_id, designer, image_url, category, colour, price, currency)
  redirect '/profile'
end

# Individual item
get '/items/:id' do
  item_id = params['id']
  item = db_query("SELECT * FROM items WHERE id = $1;", [item_id]).first
  seller = get_username(item['user_id']).first['username']
  erb :view_item, locals: {item: item, seller: seller}
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

# Create profile page
get '/profile/create' do
  erb :create_account
end

# Handle profile creation
post '/profile/create' do
  username_check = validate_username(params['username'])
  email_check = validate_email(params['email'])
  password_check = password_match(params['password'], params['confirm-password'])
  password_digest = BCrypt::Password.create(params['password'])
  if username_check && email_check && password_check
    sql = "INSERT INTO users (username, profile_image_url, email, password_digest) VALUES ('#{params['username']}','#{params['image_url']}', '#{params['email']}', '#{password_digest}');"
    db_query(sql)
    redirect '/login'
  else 
    redirect '/profile/create'
  end
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

get '/cart' do
  "Feature coming soon..."
end

post '/cart' do
  redirect '/cart'
end