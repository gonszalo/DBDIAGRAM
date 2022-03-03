CREATE TABLE `actor` (
  `actor_id` SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `address` (
  `address_id` SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(50) NOT NULL,
  `address2` VARCHAR(50) DEFAULT NULL,
  `district` VARCHAR(20) NOT NULL,
  `city_id` SMALLINT NOT NULL,
  `postal_code` VARCHAR(10) DEFAULT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `category` (
  `category_id` TINYINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `city` (
  `city_id` SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(50) NOT NULL,
  `country_id` SMALLINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `country` (
  `country_id` SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(50) NOT NULL,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `customer` (
  `customer_id` SMALLINT PRIMARY KEY NOT NULL,
  `store_id` TINYINT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) DEFAULT NULL,
  `address_id` SMALLINT NOT NULL,
  `active` BOOLEAN NOT NULL,
  `create_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP
);

CREATE TABLE `film` (
  `film_id` SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128) NOT NULL,
  `description` TEXT DEFAULT NULL,
  `release_year` YEAR DEFAULT NULL,
  `language_id` TINYINT NOT NULL,
  `original_language_id` TINYINT DEFAULT NULL,
  `rental_duration` TINYINT NOT NULL DEFAULT 3,
  `rental_rate` DECIMAL(4,2) NOT NULL DEFAULT 4.99,
  `length` SMALLINT DEFAULT NULL,
  `replacement_cost` DECIMAL(5,2) NOT NULL DEFAULT 19.99,
  `rating` ENUM ('G', 'PG', 'PG-13', 'R', 'NC-17') DEFAULT "G",
  `special_features` SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `film_actor` (
  `actor_id` SMALLINT NOT NULL,
  `film_id` SMALLINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`actor_id`, `film_id`)
);

CREATE TABLE `film_category` (
  `film_id` SMALLINT NOT NULL,
  `category_id` TINYINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`film_id`, `category_id`)
);

CREATE TABLE `film_text` (
  `film_id` SMALLINT PRIMARY KEY NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT
);

ALTER TABLE `address` ADD FOREIGN KEY (`address2`) REFERENCES `actor` (`first_name`);

ALTER TABLE `address` ADD FOREIGN KEY (`postal_code`) REFERENCES `country` (`country`);

ALTER TABLE `address` ADD FOREIGN KEY (`last_update`) REFERENCES `customer` (`store_id`);

ALTER TABLE `film` ADD FOREIGN KEY (`rental_rate`) REFERENCES `customer` (`last_name`);

ALTER TABLE `city` ADD FOREIGN KEY (`country_id`) REFERENCES `address` (`city_id`);

ALTER TABLE `film` ADD FOREIGN KEY (`rental_rate`) REFERENCES `film_actor` (`last_update`);

ALTER TABLE `actor` ADD FOREIGN KEY (`last_name`) REFERENCES `film` (`description`);

ALTER TABLE `film` ADD FOREIGN KEY (`film_id`) REFERENCES `film_category` (`category_id`);

ALTER TABLE `category` ADD FOREIGN KEY (`name`) REFERENCES `film_category` (`category_id`);

ALTER TABLE `film` ADD FOREIGN KEY (`rating`) REFERENCES `film_text` (`film_id`);

ALTER TABLE `film_category` ADD FOREIGN KEY (`film_id`) REFERENCES `film_text` (`film_id`);

CREATE INDEX `idx_actor_last_name` ON `actor` (`last_name`);

CREATE INDEX `idx_fk_city_id` ON `address` (`city_id`);

CREATE INDEX `idx_fk_country_id` ON `city` (`country_id`);

CREATE INDEX `idx_fk_store_id` ON `customer` (`store_id`);

CREATE INDEX `idx_fk_address_id` ON `customer` (`address_id`);

CREATE INDEX `idx_last_name` ON `customer` (`last_name`);

CREATE INDEX `idx_fk_film_id` ON `film_actor` (`film_id`);
