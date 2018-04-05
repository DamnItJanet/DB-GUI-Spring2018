USE foodapp;

CREATE TABLE IF NOT EXISTS `foodapp`.`account` (
  `accID` INT NOT NULL AUTO_INCREMENT,
  `fName` VARCHAR(45) NULL,
  `lName` VARCHAR(45) NULL,
  `uName` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`accID`));
  
CREATE TABLE IF NOT EXISTS `foodapp`.`food` (
  `foodID` INT NOT NULL AUTO_INCREMENT,
  `foodName` VARCHAR(45) NULL,
  `foodType` VARCHAR(45) NULL,
  `foodGroup` VARCHAR(45) NULL,
  `foodAmount` INT NULL,
  `amountSold` INT NULL,
  `foodCost` DECIMAL(5,2) NULL,
  PRIMARY KEY (`foodID`));

INSERT INTO account(fName, lName, uName, password)
VALUES ('Greg', 'Gregg', 'Greg10101', 'password');

INSERT INTO food(foodName, foodType, foodGroup, foodAmount, amountSold, foodCost)
VALUES ('Banana', 'Fruit', 'Yellow', 15, 25, 1.99);

INSERT INTO food(foodName, foodType, foodGroup, foodAmount, amountSold, foodCost)
VALUES ('Apple', 'Fruit', 'Red', 18, 22, 1.49);

INSERT INTO food(foodName, foodType, foodGroup, foodAmount, amountSold, foodCost)
VALUES ('Steak', 'Meat', 'Brown', 7, 33, 14.99);