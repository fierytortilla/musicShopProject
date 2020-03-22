DROP TABLE IF EXISTS inventory_items;
DROP TABLE IF EXISTS music_items;
DROP TABLE IF EXISTS categories;
DROP TABLE if exists users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  user_name VARCHAR(255),
  email_address VARCHAR(255)
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
  bought_flag BOOLEAN,
  category_id INT REFERENCES categories(id) ON DELETE CASCADE,
  user_id INT REFERENCES users(id) ON DELETE CASCADE
);
