-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.14-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             8.1.0.4545
-- --------------------------------------------------------

-- Dumping database structure for world
CREATE DATABASE IF NOT EXISTS Perfumazon;
USE Perfumazon;

-- Check/Create db user
-- CREATE USER 'rizwan'@'localhost' IDENTIFIED BY 'rizwan';

-- Grant privilages to user on perfumazon db
GRANT ALL PRIVILEGES ON *.* TO 'rizwan'@'localhost';
GRANT USAGE ON *.* TO 'rizwan'@'localhost';
GRANT ALL PRIVILEGES ON Perfumazon.* TO 'rizwan'@'localhost';
FLUSH PRIVILEGES;

-- Dumping structure for tables
CREATE TABLE IF NOT EXISTS users
(
  Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100) UNIQUE NOT NULL,
  Password BINARY(60) NOT NULL,
  primary key(Id)
);

CREATE TABLE IF NOT EXISTS roles
(
  Id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Role VARCHAR(100) UNIQUE NOT NULL,
  primary key(Id)
);

CREATE TABLE IF NOT EXISTS userroles
(
  UserId INT UNSIGNED NOT NULL,
  RoleId TINYINT UNSIGNED NOT NULL,
  UNIQUE(UserId, RoleId),
  INDEX(UserId),
  FOREIGN KEY (UserId)
  REFERENCES users(Id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX (RoleId),
  FOREIGN KEY (RoleId)
  REFERENCES roles(Id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS itemcategory (
  Id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50) UNIQUE NOT NULL,
  Description TINYTEXT,
  PRIMARY KEY (Id)
);

CREATE TABLE IF NOT EXISTS item (
  Id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100) UNIQUE NOT NULL,
  Description TINYTEXT,
  CatId TINYINT UNSIGNED NOT NULL,
  CreateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
  UpdateTime DATETIME ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (Id),
  INDEX (CatId),
  FOREIGN KEY (CatId)
  REFERENCES itemcategory(Id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS unitofmeasure (
  Id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50) UNIQUE NOT NULL,
  Description TINYTEXT,
  Internal TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (Id)
);

CREATE TABLE IF NOT EXISTS currency (
  Id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50) UNIQUE NOT NULL,
  Code CHAR(3) UNIQUE NOT NULL,
  PRIMARY KEY (Id)
);

CREATE TABLE IF NOT EXISTS itemprice (
  ItemId SMALLINT UNSIGNED NOT NULL,
  Price DECIMAL(7,2) UNSIGNED NOT NULL,
  CurrencyId TINYINT UNSIGNED NOT NULL,
  UOMId TINYINT UNSIGNED NOT NULL,
  UNIQUE (ItemId, Price, CurrencyId, UOMId),
  INDEX (ItemId),
  FOREIGN KEY (ItemId)
  REFERENCES item(Id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX (CurrencyId),
  FOREIGN KEY (CurrencyId)
  REFERENCES currency(Id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX (UOMId),
  FOREIGN KEY (UOMId)
  REFERENCES unitofmeasure(Id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS productcategory (
  Id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50) UNIQUE NOT NULL,
  Description TINYTEXT,
  PRIMARY KEY (Id)
);

CREATE TABLE IF NOT EXISTS product (
  Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50) NOT NULL,
  Description TINYTEXT,
  CatId TINYINT UNSIGNED NOT NULL,
  CreatedBy INT UNSIGNED NOT NULL,
  CreationTime DATETIME DEFAULT CURRENT_TIMESTAMP,
  ModificationTime DATETIME ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (Id),
  UNIQUE(Name, CatId, CreatedBy),
  INDEX (CatId),
  FOREIGN KEY (CatId)
  REFERENCES productcategory(Id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX (CreatedBy),
  FOREIGN KEY (CreatedBy)
  REFERENCES users(Id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS productprice (
  ProductId INT UNSIGNED NOT NULL,
  Price DECIMAL(7,2) UNSIGNED NOT NULL,
  CurrencyId TINYINT UNSIGNED NOT NULL,
  UOMId TINYINT UNSIGNED NOT NULL,
  UNIQUE(ProductId, Price, CurrencyId, UOMId),
  INDEX (ProductId),
  FOREIGN KEY (ProductId)
  REFERENCES product(Id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX (CurrencyId),
  FOREIGN KEY (CurrencyId)
  REFERENCES currency(Id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX (UOMId),
  FOREIGN KEY (UOMId)
  REFERENCES unitofmeasure(Id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS formula (
  ProductId INT UNSIGNED NOT NULL,
  ItemId SMALLINT UNSIGNED NOT NULL,
  Quantity DECIMAL(7,2) UNSIGNED NOT NULL,
  UOMId TINYINT UNSIGNED NOT NULL,
  UNIQUE(ProductId, ItemId),
  INDEX (ProductId),
  FOREIGN KEY (ProductId)
  REFERENCES product(Id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX (ItemId),
  FOREIGN KEY (ItemId)
  REFERENCES item(Id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX (UOMId),
  FOREIGN KEY (UOMId)
  REFERENCES unitofmeasure(Id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

-- insert into users(Username, Password) values(admin, $2a$10$YX3cYqn9nHmCOmPZBHXrQ.2nxrktB3CRYG8tXmBmmWvrDKU8uwRSe