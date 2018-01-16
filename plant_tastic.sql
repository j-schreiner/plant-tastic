CREATE DATABASE plant_tastic;

CREATE TABLE plants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(300) NOT NULL,
  image_url VARCHAR(400) NOT NULL
);

CREATE TABLE details (
  id SERIAL PRIMARY KEY,
  sci_name VARCHAR(400) NOT NULL,
  origin VARCHAR(300) NOT NULL,
  plant_id INTEGER NOT NULL,
  FOREIGN KEY (plant_id) REFERENCES plants (id) ON DELETE CASCADE
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  body VARCHAR(500) NOT NULL,
  plant_id INTEGER NOT NULL,
  FOREIGN KEY (plant_id) REFERENCES plants (id) ON DELETE CASCADE
);

