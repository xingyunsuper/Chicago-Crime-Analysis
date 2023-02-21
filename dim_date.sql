SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `chicago_crime`.`chicago_crime` MODIFY `date` CHAR(30);
ALTER TABLE `chicago_crime`.`chicago_crime` ALTER `date` SET DEFAULT NULL;

-- -----------------------------------------------------
-- Schema chicago_crime
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Table `chicago_crime`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chicago_crime`.`dim_date` (
  `date_key` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL DEFAULT NULL,
  `timestamp` DATETIME NULL DEFAULT NULL,
  `weekend` CHAR(10) NOT NULL DEFAULT 'Weekday',
  `day_of_week` CHAR(10) NULL DEFAULT NULL,
  `month` CHAR(10) NULL DEFAULT NULL,
  `month_day` CHAR(10) NULL DEFAULT NULL,
  `year` INT NULL DEFAULT NULL,
  `week_starting_monday` CHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`date_key`),
INDEX `date` (`date` ASC),
  INDEX `year_week` (`year` ASC, `week_starting_monday` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Populate dim_date table
-- -----------------------------------------------------

INSERT INTO `chicago_crime`.`dim_date` (timestamp,year)
SELECT 
    STR_TO_DATE(c.date,'%m/%d/%Y %h:%i:%s %p'),c.year
FROM
    `chicago_crime`.`chicago_crime` c;

SET SQL_SAFE_UPDATES = 0;
UPDATE `chicago_crime`.`dim_date` 
SET 
    day_of_week = DATE_FORMAT(timestamp, '%W'),
    weekend = IF(DATE_FORMAT(timestamp, '%W') IN ('Saturday' , 'Sunday'),
        'Weekend',
        'Weekday'),
    month = DATE_FORMAT(timestamp, '%M'),
    month_day = DATE_FORMAT(timestamp, '%d');

UPDATE `chicago_crime`.`dim_date` 
SET 
    week_starting_monday = DATE_FORMAT(timestamp, '%v');

UPDATE `chicago_crime`.`dim_date` 
SET 
    date = DATE(timestamp);