
CREATE DATABASE  IF NOT EXISTS `demo`;
USE `demo`;


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
  Image VARCHAR(100) NULL,
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
  Created DATETIME NULL,
  PRIMARY KEY (ID),
  CONSTRAINT FK_Review_Product FOREIGN KEY (ProductId) REFERENCES Product(ID),
  CONSTRAINT FK_Review_User FOREIGN KEY (UserId) REFERENCES User(ID)
);

INSERT INTO brand(Name, Description) values ('SamSung', 'SamSung Electric Company'), ('Sony','Sony Electric Company'), ('Apple','Apple Technology')
, ('Microsoft','Microsoft');

INSERT INTO usertype(Name) values ('Customer'), ('Merchant');

INSERT INTO availablestatus(Name) values ('In Stock'), ('Out Stock'), ('Archived');

INSERT INTO user(UserName,UserTypeId, Email, DOB) value ('user2', 2, 'admin@demo.com', '1990-10-10');
INSERT INTO user(UserName,UserTypeId, Email, DOB) value ('user3', 1, 'user3@demo.com', '1990-10-10');
INSERT INTO user(UserName,UserTypeId, Email, DOB) value ('user4', 2, 'user4@demo.com', '1990-10-10');


INSERT INTO product(Name, BrandId, Description, Price, Colour, Created, StatusId)
VALUES('Galaxy Y', 1, 'Samsung galaxy Y', 150, 'Black', '2014-1-1', 2)
,('Galaxy S2', 1, 'Samsung galaxy S2', 350, 'White', '2014-3-3', 3)
,('Galaxy S3', 1, 'Samsung galaxy S3', 350, 'White', '2015-1-1', 1)
,('Galaxy S4', 1, 'Samsung galaxy S4', 550, 'White', '2016-1-1', 1)
,('Galaxy Edge', 1, 'Samsung galaxy Edge', 750, 'White', '2016-3-3', 1)
,('Aqua M2', 2, 'Sony Aqua M2', 250, 'Snow', '2015-5-5', 2)
,('C2', 2, 'Sony C2', 350, 'Blue', '2014-6-7', 1)
,('C3', 2, 'Sony C3', 450, 'Black', '2015-9-7', 1)
,('Revole', 2, 'Sony Revole', 150, 'White', '2013-1-5', 2)
,('Iphone 4', 3, 'Appy iphone 4', 150, 'White', '2013-1-3', 3)
,('Iphone 4s', 3, 'Appy iphone 4s', 250, 'White', '2013-9-8', 2)
,('Iphone 5', 3, 'Appy iphone 5', 300, 'White', '2014-8-6', 1)
,('Iphone 5c', 3, 'Appy iphone 5c', 250, 'White', '2014-11-11', 2)
,('Iphone 5s', 3, 'Appy iphone 5s', 350, 'White', '2015-6-3', 1)
,('Iphone 6', 3, 'Appy iphone 6', 450, 'White', '2015-11-11', 1)
,('Iphone 6s', 3, 'Appy iphone 6s', 250, 'White', '2016-1-1', 1);

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getListProducts`(
	IN brandId INT
)
BEGIN
	CREATE TABLE temp
	SELECT p.ProductId, p.Rating,p.Comment, u.UserName
	FROM preview p 
    INNER JOIN User u ON p.UserId = u.Id
	INNER JOIN (SELECT MAX(id) AS id
						FROM preview
						GROUP BY productId) mostRecent ON mostRecent.id = p.ID;


	SELECT 	p.ID, p.Name, p.Description, 
			b.Name AS Brand,
            p.Price,
			npr.UserName, 
			npr.Rating, 
			npr.Comment,
            p.Image
	FROM product p 
    LEFT JOIN Brand b ON p.BrandId = b.Id
	LEFT JOIN temp npr ON p.Id = npr.ProductId	
    WHERE p.brandId = brandId OR brandId = 0
	ORDER BY p.Created DESC LIMIT 10;

	DROP TABLE temp;
END;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAll`(
	IN brandId INT
)
BEGIN
	SELECT * FROM product order by Created Limit 10;
END;
DELIMITER ;;
SELECT p.*, b.Name as Brand
FROM product p
INNER JOIN brand b ON p.BrandId = b.Id WHERE p.Id = 2

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getProductDetails`(
	IN productId INT
)
BEGIN
	SELECT p.*, b.Name as Brand, a.Name as Status
	FROM product p
	INNER JOIN brand b ON p.BrandId = b.Id 
    INNER JOIN availablestatus a ON p.StatusId = a.ID
    WHERE p.Id = productId;

	SELECT p.*, u.UserName
    FROM preview p 
    INNER JOIN user u ON p.UserId = u.ID
    WHERE p.ProductId = productId    
	ORDER BY p.ID DESC ;    
END;;
DELIMITER ;


