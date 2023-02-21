SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
-- -----------------------------------------------------
-- Schema chicago_crime
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Table `chicago_crime`.`dim_location`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `chicago_crime`.`dim_location` (
  `location_key` INT NOT NULL AUTO_INCREMENT,
  `location_description` VARCHAR(100) NULL,
  `beat` INT NOT NULL,
  `block` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NULL,
  `ward` INT NULL,
  `community_area` INT NULL,
  `x_coordinate` FLOAT,
  `y_coordinate` FLOAT,
  `longitude` FLOAT,
  `latitude` FLOAT,
PRIMARY KEY (`location_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Now insert data into dim_location table
-- -----------------------------------------------------
#drop table chicago_crime.dim_location;

INSERT INTO chicago_crime.dim_location (
    location_description,
    beat,
    block,
    district,
    ward,
    community_area,
    x_coordinate,
    y_coordinate,
    longitude,
    latitude)
(SELECT 
    location_description,
    beat,
    block,
    district,
    ward,
    community_area,
    x_coordinate,
    y_coordinate,
    longitude,
    latitude
FROM chicago_crime.chicago_crime);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;