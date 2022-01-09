require 'pg'
require 'bcrypt'

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

def get_username(id)
    sql = "SELECT username FROM users WHERE id = $1"
    db_query(sql, [id])
end

def validate_username(username)
    result = db_query("SELECT * FROM users WHERE username = $1;", [username])
    if result.count == 0
        return true
    end
end

def validate_email(email)
    result = db_query("SELECT * FROM users WHERE email = $1;", [email])
    if result.count == 0
        return true
    end
end

def password_match(password, confirm)
    if password == confirm 
        return true
    end
end