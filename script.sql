-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hospital_management_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hospital_management_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital_management_system` DEFAULT CHARACTER SET utf8 ;
USE `hospital_management_system` ;

-- -----------------------------------------------------
-- Table `hospital_management_system`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`patients` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `sex` CHAR(1) NOT NULL DEFAULT 'o',
  `date_of_birth` DATE NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `middle_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `postcode` VARCHAR(6) NOT NULL,
  `phone_number` VARCHAR(11) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`patient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`department` (
  `department_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`doctors` (
  `doctor_id` TINYINT NOT NULL AUTO_INCREMENT,
  `department_id` TINYINT NOT NULL,
  `specialization` JSON NOT NULL,
  `sex` CHAR(1) NOT NULL DEFAULT 'O',
  `date_of_birth` DATE NOT NULL,
  `phone_number` CHAR(11) NOT NULL,
  `email` VARCHAR(255) NULL,
  `postcode` VARCHAR(6) NOT NULL,
  `address` VARCHAR(255) NULL,
  PRIMARY KEY (`doctor_id`, `department_id`),
  INDEX `fk_doctors_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_doctors_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `hospital_management_system`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`appointment` (
  `appointment_id` TINYINT NOT NULL AUTO_INCREMENT,
  `patient_id` INT NOT NULL,
  `doctor_id` TINYINT NOT NULL,
  PRIMARY KEY (`appointment_id`, `patient_id`, `doctor_id`),
  INDEX `fk_appointment_patients_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_appointment_doctors1_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_patients`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital_management_system`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_appointment_doctors1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `hospital_management_system`.`doctors` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`venue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`venue` (
  `venue_id` TINYINT NOT NULL AUTO_INCREMENT,
  `department_id` TINYINT NOT NULL,
  `unit` VARCHAR(50) NOT NULL,
  `room_no` TINYINT NULL,
  PRIMARY KEY (`venue_id`, `department_id`),
  INDEX `fk_venue_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_venue_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `hospital_management_system`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`bookings` (
  `appointment_id` TINYINT NOT NULL,
  `venue_id` TINYINT NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`appointment_id`, `venue_id`),
  INDEX `fk_bookings_venue1_idx` (`venue_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookings_appointment1`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `hospital_management_system`.`appointment` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bookings_venue1`
    FOREIGN KEY (`venue_id`)
    REFERENCES `hospital_management_system`.`venue` (`venue_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`services` (
  `service_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `department_id` TINYINT NOT NULL,
  PRIMARY KEY (`service_id`, `department_id`),
  INDEX `fk_services_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_services_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `hospital_management_system`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`billing` (
  `billing_id` TINYINT NOT NULL AUTO_INCREMENT,
  `patient_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  `amount_due` FLOAT NULL DEFAULT 0.00,
  `due_date` DATETIME NULL,
  PRIMARY KEY (`billing_id`, `patient_id`, `service_id`),
  INDEX `fk_billing_patients1_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_billing_services1_idx` (`service_id` ASC) VISIBLE,
  CONSTRAINT `fk_billing_patients1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital_management_system`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_billing_services1`
    FOREIGN KEY (`service_id`)
    REFERENCES `hospital_management_system`.`services` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `service_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `amount` FLOAT NULL DEFAULT 0.00,
  `date` DATETIME NULL DEFAULT 0.00,
  PRIMARY KEY (`payment_id`, `service_id`, `patient_id`),
  INDEX `fk_payment_services1_idx` (`service_id` ASC) VISIBLE,
  INDEX `fk_payment_patients1_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_services1`
    FOREIGN KEY (`service_id`)
    REFERENCES `hospital_management_system`.`services` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_patients1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital_management_system`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`medical_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`medical_record` (
  `patient_id` INT NOT NULL,
  `allergens` TEXT NULL,
  `disablilty` TEXT NULL,
  `history` JSON NULL,
  PRIMARY KEY (`patient_id`),
  CONSTRAINT `fk_medical_status_patients1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital_management_system`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_management_system`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_management_system`.`inventory` (
  `inventory_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `quantity_in_stock` TINYINT NULL,
  PRIMARY KEY (`inventory_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
