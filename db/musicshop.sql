DROP TABLE IF EXISTS inventory_items;
DROP TABLE IF EXISTS music_items;
DROP TABLE IF EXISTS categories;
DROP TABLE if exists users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  user_name VARCHAR(255),
  email_address VARCHAR(255),
  active_flag BOOLEAN
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  category_name VARCHAR(255)
);

CREATE TABLE music_items (
  id SERIAL PRIMARY KEY,
  item_name VARCHAR(255),
  buying_cost FLOAT(2),
  selling_price FLOAT(2),
  category_id INT REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE inventory_items (
  id SERIAL PRIMARY KEY,
  bought_flag BOOLEAN,
  selling_item_id INT REFERENCES music_items(id) ON DELETE CASCADE,
  seller_user_id INT REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE purchased_items (
  id SERIAL PRIMARY KEY,
  bought_item_id INT REFERENCES music_items(id) ON DELETE CASCADE,
  buyer_user_id INT REFERENCES users(id) ON DELETE CASCADE
);
