CREATE DATABASE plants_db;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password_digest TEXT
);

CREATE TABLE plants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(300) NOT NULL,
  image_url VARCHAR(400) NOT NULL
);

# join table: contains the foreign keys

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  body TEXT NOT NULL,
  plant_id INTEGER NOT NULL,
  FOREIGN KEY (plant_id) REFERENCES plants(id) ON DELETE CASCADE,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
); 


CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  plant_id INTEGER NOT NULL,
  FOREIGN KEY (plant_id) REFERENCES plants(id) ON DELETE CASCADE,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
