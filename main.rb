require 'sinatra' 
require 'sinatra/reloader'
require 'pg'

enable :sessions

def db_query(sql, params = [])
  conn = PG.connect(dbname: 'goodfoodhunting')
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

get '/' do 
  erb :index
end

get '/login' do
  erb :login
end

post '/session' do
  email = params['username']
  password = params['password']
  sql = "SELECT * FROM users WHERE username = $1;"
  result = db_query(sql, [username])
  # if nothing, will return a 0
  # If finds content, will return 1
  # Now validate password
  if result.count > 0 && BCrypt::Password.new(result[0]['password_digest']) == password
    session[:user_id] = result[0]['id'] # it's a hash / session for a single user
    # Aim to have session only hold minimal information to avoid duplication (single source of truth) which shows in layout.erb
    redirect '/'
  else
    erb :login
  end
end

delete '/session' do 
  session[:user_id] = nil
  redirect '/login'
end