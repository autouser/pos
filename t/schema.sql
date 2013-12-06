CREATE TABLE customers (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);
CREATE TABLE items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255),
  manufacturer VARCHAR(255),
  unique(name, manufacturer)
);
CREATE TABLE orders (
  id INTEGER,
  created_at DATETIME,
  customer_id INTEGER,
  item_id INTEGER,
  price MONEY,
  unique(id, created_at, customer_id, item_id, price)
);
