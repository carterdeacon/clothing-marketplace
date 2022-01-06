require 'pg'
require 'pry'
require 'bcrypt'

puts "Creating dummy user..."

username = "carter_deacon"
profile_image_url = "https://instagram.fbne6-1.fna.fbcdn.net/v/t51.2885-19/s150x150/87593422_490494994976847_484734772145291264_n.jpg?_nc_ht=instagram.fbne6-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=LdpJFqmLm8kAX_ogYWQ&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT--RbC39zPZsGvBUZ4bO7rZAqp9fitEVdVd3X972_4PsQ&oe=61DD3E4E&_nc_sid=7bff83"
email = "carter.deacon@gmail.com"
password = "pudding"

conn = PG.connect(dbname: 'marketplace')

password_digest = BCrypt::Password.create(password)

sql = "INSERT INTO users (username, profile_image_url, email, password_digest) VALUES ('#{username}', '#{profile_image_url}', '#{email}', '#{password_digest}');"

conn.exec(sql)
conn.close

puts "Done!"