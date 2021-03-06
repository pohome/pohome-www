-- MySQL Script generated by MySQL Workbench
-- Sun Mar 29 15:45:00 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pohome
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pohome` ;

-- -----------------------------------------------------
-- Schema pohome
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pohome` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `pohome` ;

-- -----------------------------------------------------
-- Table `pohome`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`user` (
  `id` BIGINT UNSIGNED NOT NULL,
  `username` VARCHAR(15) NOT NULL,
  `password` CHAR(60) NOT NULL,
  `email` VARCHAR(25) NULL,
  `mobile` CHAR(11) NULL,
  `user_type` ENUM('individual','group') NOT NULL,
  `email_verified` TINYINT(1) NOT NULL,
  `mobile_verified` TINYINT(1) NOT NULL,
  `contribution_intension` INT UNSIGNED NOT NULL DEFAULT 0,
  `permission` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `max_allowed_pet_application_num` DECIMAL(3,1) NOT NULL,
  `max_allowed_pet_post_num` DECIMAL(3,1) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `last_login_at` DATETIME NOT NULL,
  `last_login_ip` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `pohome`.`pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`pet` (
  `id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `species` ENUM('C','D') NOT NULL,
  `gender` ENUM('M','F') NOT NULL,
  `breed` VARCHAR(20) NOT NULL,
  `size` ENUM('S','M','L','XL') NOT NULL,
  `birthday` DATE NOT NULL,
  `friendly_index` TINYINT UNSIGNED NOT NULL,
  `energy_index` TINYINT UNSIGNED NOT NULL,
  `adaptability_index` TINYINT UNSIGNED NOT NULL,
  `notice` VARCHAR(400) NOT NULL,
  `story` TEXT NOT NULL,
  `draft` TINYINT(1) NOT NULL,
  `creator_id` BIGINT UNSIGNED NOT NULL,
  `belongs_to_pohome` TINYINT(1) NOT NULL,
  `adoptable` TINYINT(1) NOT NULL,
  `viewed` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL COMMENT '	',
  `modified_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pet_user_idx` (`creator_id` ASC),
  INDEX `name_idx` (`name` ASC),
  INDEX `pohome_idx` (`belongs_to_pohome` ASC),
  CONSTRAINT `fk_pet_user`
    FOREIGN KEY (`creator_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `pohome`.`blog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`blog` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `content` MEDIUMTEXT NOT NULL,
  `abstract` VARCHAR(400) NOT NULL,
  `feature_image` BIGINT UNSIGNED NOT NULL,
  `author_id` BIGINT UNSIGNED NOT NULL,
  `catelog_id` TINYINT UNSIGNED NOT NULL,
  `draft` TINYINT(1) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NOT NULL,
  `viewed` INT UNSIGNED NOT NULL,
  `published_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_blog_user1_idx` (`author_id` ASC),
  INDEX `published_at_idx` (`published_at` DESC),
  CONSTRAINT `fk_blog_user1`
    FOREIGN KEY (`author_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`event` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `begin_at` DATETIME NOT NULL,
  `end_at` DATETIME NOT NULL,
  `deadline` DATETIME NOT NULL,
  `location` VARCHAR(20) NOT NULL,
  `content` TEXT NOT NULL,
  `member_limit` TINYINT NOT NULL,
  `event_type_id` TINYINT NOT NULL,
  `creator_id` BIGINT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_user1_idx` (`creator_id` ASC),
  CONSTRAINT `fk_event_user1`
    FOREIGN KEY (`creator_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`file`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`file` (
  `id` BIGINT UNSIGNED NOT NULL,
  `original_filename` VARCHAR(255) NOT NULL,
  `file_type` ENUM('jpg', 'jpeg', 'png', 'gif', 'pdf', 'doc', 'xls', 'zip') NOT NULL,
  `file_size` INT UNSIGNED NOT NULL,
  `uploader_id` BIGINT UNSIGNED NOT NULL,
  `uploaded_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_file_user1_idx` (`uploader_id` ASC),
  CONSTRAINT `fk_file_user1`
    FOREIGN KEY (`uploader_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`setting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`setting` (
  `key` VARCHAR(20) NOT NULL,
  `value` TEXT NOT NULL,
  `catelog` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`user_extra_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`user_extra_info` (
  `user_id` BIGINT UNSIGNED NOT NULL,
  `realname` VARCHAR(15) NULL,
  `id_card_num` CHAR(18) NULL,
  `birthday` DATE NULL,
  `gender` ENUM('M','F') NULL,
  `qq` VARCHAR(15) NULL,
  `weibo` VARCHAR(30) NULL,
  `taobao` VARCHAR(25) NULL,
  `has_car` TINYINT(1) NULL,
  `referee_id` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_user_extra_info_user2_idx` (`referee_id` ASC),
  CONSTRAINT `fk_user_extra_info_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_extra_info_user2`
    FOREIGN KEY (`referee_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`service_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`service_record` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `description` VARCHAR(50) NOT NULL,
  `date` DATE NOT NULL,
  `contribute_hour` TINYINT UNSIGNED NOT NULL,
  `creator_id` BIGINT UNSIGNED NOT NULL,
  `create_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_service_record_user1_idx` (`user_id` ASC),
  INDEX `fk_service_record_user2_idx` (`creator_id` ASC),
  CONSTRAINT `fk_service_record_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_service_record_user2`
    FOREIGN KEY (`creator_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pet_story`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`pet_story` (
  `blog_id` INT UNSIGNED NOT NULL,
  `pet_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`blog_id`, `pet_id`),
  INDEX `fk_blog_has_pet_pet1_idx` (`pet_id` ASC),
  INDEX `fk_blog_has_pet_blog1_idx` (`blog_id` ASC),
  CONSTRAINT `fk_blog_has_pet_blog1`
    FOREIGN KEY (`blog_id`)
    REFERENCES `pohome`.`blog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blog_has_pet_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pohome`.`pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`event_application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`event_application` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_id` INT UNSIGNED NOT NULL,
  `applicant_id` BIGINT UNSIGNED NOT NULL,
  `number_of_people` TINYINT UNSIGNED NOT NULL,
  `departure_from` VARCHAR(40) NOT NULL,
  `has_car` TINYINT(1) NOT NULL,
  `remark` VARCHAR(400) NOT NULL,
  `applied_at` DATETIME NOT NULL,
  `contacted` TINYINT(1) NOT NULL,
  `approved` TINYINT(1) NOT NULL,
  `discard` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_application_event1_idx` (`event_id` ASC),
  INDEX `fk_event_application_user1_idx` (`applicant_id` ASC),
  CONSTRAINT `fk_event_application_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `pohome`.`event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_application_user1`
    FOREIGN KEY (`applicant_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pohome_pet_extra_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`pohome_pet_extra_data` (
  `pet_id` BIGINT UNSIGNED NOT NULL,
  `entry_date` DATE NOT NULL,
  `location_id` TINYINT UNSIGNED NOT NULL,
  `status_id` TINYINT UNSIGNED NOT NULL,
  `angel_id` SMALLINT UNSIGNED NULL,
  `neutered` TINYINT(1) NOT NULL,
  `taobao_url` BIGINT UNSIGNED NULL,
  INDEX `fk_pohome_pet_extra_data_pet1_idx` (`pet_id` ASC),
  PRIMARY KEY (`pet_id`),
  CONSTRAINT `fk_pohome_pet_extra_data_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pohome`.`pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`medical_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`medical_record` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pet_id` BIGINT UNSIGNED NOT NULL,
  `type` ENUM('I','N','T','A','PE','B') NOT NULL,
  `decription` VARCHAR(400) NULL,
  `location_id` TINYINT NOT NULL,
  `happened_at` DATETIME NOT NULL,
  `creator_id` BIGINT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medical_record_pet1_idx` (`pet_id` ASC),
  INDEX `fk_medical_record_user1_idx` (`creator_id` ASC),
  CONSTRAINT `fk_medical_record_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pohome`.`pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medical_record_user1`
    FOREIGN KEY (`creator_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`favorite` (
  `pet_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`pet_id`, `user_id`),
  INDEX `fk_pet_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_pet_has_user_pet1_idx` (`pet_id` ASC),
  CONSTRAINT `fk_pet_has_user_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pohome`.`pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`faq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`faq` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `question` VARCHAR(100) NOT NULL,
  `answer` VARCHAR(400) NOT NULL,
  `catelog_id` SMALLINT UNSIGNED NOT NULL,
  `creator_id` BIGINT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_faq_user1_idx` (`creator_id` ASC),
  CONSTRAINT `fk_faq_user1`
    FOREIGN KEY (`creator_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pet_photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`pet_photo` (
  `pet_id` BIGINT UNSIGNED NOT NULL,
  `file_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`pet_id`, `file_id`),
  INDEX `fk_pet_has_file_file1_idx` (`file_id` ASC),
  INDEX `fk_pet_has_file_pet1_idx` (`pet_id` ASC),
  CONSTRAINT `fk_pet_has_file_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pohome`.`pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_has_file_file1`
    FOREIGN KEY (`file_id`)
    REFERENCES `pohome`.`file` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`adoption_application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`adoption_application` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pet_id` BIGINT UNSIGNED NOT NULL,
  `applicant_id` BIGINT UNSIGNED NOT NULL,
  `application_form` TEXT NOT NULL,
  `applied_at` DATETIME NOT NULL,
  `status` ENUM('S','PC','I','A','D') NOT NULL,
  `closed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_adoption_application_pet1_idx` (`pet_id` ASC),
  INDEX `fk_adoption_application_user1_idx` (`applicant_id` ASC),
  CONSTRAINT `fk_adoption_application_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pohome`.`pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adoption_application_user1`
    FOREIGN KEY (`applicant_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`contact_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pohome`.`contact_record` (
  `user_id` BIGINT UNSIGNED NOT NULL,
  `adoption_application_id` INT UNSIGNED NOT NULL,
  `type` ENUM('V','PC','I','A','D') NOT NULL,
  `opinion` VARCHAR(400) NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`user_id`, `adoption_application_id`),
  INDEX `fk_user_has_adoption_application_adoption_application1_idx` (`adoption_application_id` ASC),
  INDEX `fk_user_has_adoption_application_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_adoption_application_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pohome`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_adoption_application_adoption_application1`
    FOREIGN KEY (`adoption_application_id`)
    REFERENCES `pohome`.`adoption_application` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;