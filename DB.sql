/*create database demo*/

CREATE TABLE Brand (
  ID INT(11) NOT NULL AUTO_INCREMENT,
  Name NVARCHAR(100) NOT NULL,
  Description NVARCHAR(1000),
  PRIMARY KEY (ID)
);

CREATE TABLE AvailableStatus (
  ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Name NVARCHAR(100) NOT NULL    
);

CREATE TABLE UserType (
  ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Name NVARCHAR(100) NOT NULL    
);

CREATE TABLE User(
  ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  UserName NVARCHAR(100) NOT NULL UNIQUE,
  UserTypeId INT NOT NULL,
  Email VARCHAR(100) NOT NULL UNIQUE,
  DOB DATETIME NULL,
  CONSTRAINT FK_User_UserType FOREIGN KEY (UserTypeId) REFERENCES AvailableStatus(ID)
);

CREATE TABLE Product(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  Name NVARCHAR(100) NOT NULL,
  BrandId INT NOT NULL,
  Description NVARCHAR(1000),
  Price DECIMAL(13,2) DEFAULT 0.00,
  Colour NVARCHAR(100),
  Created DATETIME NULL,
  StatusId INT NOT NULL DEFAULT 1,
  PRIMARY KEY (ID),
  CONSTRAINT FK_Product_Brand FOREIGN KEY (BrandId) REFERENCES Brand(ID),
  CONSTRAINT FK_Product_Status FOREIGN KEY (StatusId) REFERENCES Brand(ID)
);

CREATE TABLE Preview(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  ProductId INT NOT NULL,
  Rating INT NOT NULL DEFAULT 0,
  Comment NVARCHAR(2000),
  UserId INT NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT FK_Review_Product FOREIGN KEY (ProductId) REFERENCES Product(ID),
  CONSTRAINT FK_Review_User FOREIGN KEY (UserId) REFERENCES User(ID)
);

INSERT INTO brand(Name, Description) values ('SamSung', 'SamSung Electric Company'), ('Sony','Sony Electric Company'), ('Apple','Apple Technology');

INSERT INTO usertype(Name) values ('Customer'), ('Merchant');

INSERT INTO availablestatus(Name) values ('In Stock'), ('Out Stock'), ('Archived');

INSERT INTO user(UserName,UserTypeId, Email, DOB) value ('admin', 1, 'admin@demo.com', 10/10/2016);



