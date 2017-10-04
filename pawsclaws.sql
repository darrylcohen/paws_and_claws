CREATE DATABASE pawsclaws;

CREATE TABLE shelters (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(400) NOT NULL,
  address VARCHAR(400),
  phone VARCHAR(20)
);

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(400) NOT NULL,
  email VARCHAR(100),
  admin VARCHAR(10),
  password_digest VARCHAR(200)
);

CREATE TABLE user_shelters (
  id SERIAL4 PRIMARY KEY,
  shelter_id INTEGER,
  FOREIGN KEY (shelter_id) REFERENCES shelters (id) on delete RESTRICT,
  user_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users (id) on delete RESTRICT
);

CREATE TABLE clients (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(400) NOT NULL,
  pic_image VARCHAR(100),
  phone VARCHAR(20),
  email VARCHAR(100),
  shelter_id INTEGER,
  FOREIGN KEY (shelter_id) REFERENCES shelters (id) on delete RESTRICT
);

CREATE TABLE animal (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(400) NOT NULL,
  pic_image VARCHAR(100),
  age INTEGER,
  species VARCHAR(100),
  shelter_id INTEGER,
  FOREIGN KEY (shelter_id) REFERENCES shelters (id) on delete RESTRICT,
  client_id INTEGER
);

INSERT INTO shelters (name, address, phone) VALUES ('Melbourne', '123 Collins Street', '9999-999');
INSERT INTO shelters (name, address, phone) VALUES ('Sydney', '123 Bourke Street', '9999-999');
INSERT INTO users (name, email) VALUES ('Darryl', 'a@b.com');
INSERT INTO user_shelters (shelter_id, user_id) VALUES (1, 1);
INSERT INTO
ALTER TABLE animal RENAME TO animals;
ALTER TABLE users ADD admin VARCHAR(10);
