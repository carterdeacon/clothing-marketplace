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
    image_url TEXT,
    category TEXT,
    colour TEXT, 
    price INTEGER,
    currency TEXT
);

INSERT INTO items (user_id, designer, image_url, category, colour, price, currency) VALUES (1, 'John Elliott', 'https://img.ssensemedia.com/images/b_white,g_center,f_auto,q_auto:best/212761M192002_1/john-elliott-beige-and-blue-check-oversized-hemi-shirt.jpg', 'shirt', 'blue', 320, 'USD');

INSERT INTO items (user_id, designer, image_url, category, colour, price, currency) VALUES (1, 'Stone Island', 'https://img.ssensemedia.com/images/b_white,g_center,f_auto,q_auto:best/212828M178028_1/stone-island-khaki-crinkle-reps-down-jacket.jpg', 'jacket', 'green', 944, 'AUD');


dummy user details:
username = carter_deacon
password = pudding

username = second_user
password = second
