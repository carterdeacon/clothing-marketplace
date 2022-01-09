require 'pg'

def db_query(sql, params = [])
    conn = PG.connect(dbname: 'marketplace')
    result = conn.exec_params(sql, params)
    conn.close
    return result
end

def all_items()
    db_query("SELECT * FROM items ORDER BY id;")
end

def new_items()
    db_query("SELECT * FROM items ORDER by id DESC;")
end

def create_listing(user_id, designer, image_url, category, colour, price, currency)
    sql = "INSERT INTO items (user_id, designer, image_url, category, colour, price, currency) VALUES ($1, $2, $3, $4, $5, $6, $7);"
    db_query(sql, [user_id, designer, image_url, category, colour, price, currency])
end

def update_listing(designer, image_url, category, colour, price, currency, id)
    sql = "UPDATE items SET designer = $1, image_url = $2, category = $3, colour = $4, price = $5, currency = $6 WHERE id = $7;"
    db_query(sql, [designer, image_url, category, colour, price, currency, id])
end

def remove_listing(id)
    db_query("DELETE FROM items WHERE id = $1;", [id])
end