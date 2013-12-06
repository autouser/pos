-- Customer

CREATE TABLE IF NOT EXISTS customers (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

-- Item
CREATE TABLE IF NOT EXISTS items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255),
  manufacturer VARCHAR(255),
  unique(name, manufacturer)
);


-- Order
CREATE TABLE IF NOT EXISTS orders (
  id VARCHAR(255),
  created_at DATETIME,
  customer_id INTEGER,
  item_id INTEGER,
  price MONEY,
  unique(id, created_at, customer_id, item_id, price)
);
