CREATE DATABASE marketplace;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT,
    profile_image_url TEXT,
    email TEXT,
    password_digest TEXT
);

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    designer VARCHAR(150),
    category TEXT,
    colour TEXT, 
    price INTEGER,
    currency TEXT
);

INSERT INTO items ()