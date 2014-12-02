-- MySQL Script generated by MySQL Workbench
-- Tue Dec  2 09:34:58 2014
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
DROP TABLE IF EXISTS `pohome`.`user` ;

CREATE TABLE IF NOT EXISTS `pohome`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(15) NOT NULL,
  `password` CHAR(60) NOT NULL,
  `email` VARCHAR(25) NOT NULL,
  `mobile` CHAR(11) NULL,
  `created_at` DATETIME NOT NULL,
  `last_visit_at` DATETIME NOT NULL,
  `last_visit_ip` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `mobile_UNIQUE` (`mobile` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`pets` ;

CREATE TABLE IF NOT EXISTS `pohome`.`pets` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  `avatar` INT UNSIGNED NOT NULL DEFAULT 0,
  `species` ENUM('D','C') NOT NULL,
  `gender` ENUM('M','F') NOT NULL,
  `breed` VARCHAR(10) NOT NULL,
  `birthday` DATE NOT NULL,
  `body_size` ENUM('XL','L','M','S') NOT NULL,
  `character` VARCHAR(80) NOT NULL,
  `health` VARCHAR(80) NOT NULL,
  `neutered` TINYINT(1) NOT NULL,
  `adoption_notice` VARCHAR(400) NULL,
  `adoptable` TINYINT(1) NOT NULL,
  `draft` TINYINT(1) NOT NULL,
  `viewed` INT UNSIGNED NOT NULL,
  `favorite` INT UNSIGNED NOT NULL,
  `creator_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `NAME` (`name` ASC),
  INDEX `fk_pets_users1_idx` (`creator_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pohome_pet_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`pohome_pet_info` ;

CREATE TABLE IF NOT EXISTS `pohome`.`pohome_pet_info` (
  `pet_id` INT UNSIGNED NOT NULL,
  `angel_id` SMALLINT UNSIGNED NULL,
  `entry_date` DATE NOT NULL,
  `location` TINYINT UNSIGNED NULL,
  `status` TINYINT UNSIGNED NULL,
  `neuter_date` DATE NULL,
  `next_immune_date` DATE NULL,
  `next_anthelmintic_date` DATE NULL,
  INDEX `fk_pohome_pet_info_pets1_idx` (`pet_id` ASC),
  UNIQUE INDEX `angel_id_UNIQUE` (`angel_id` ASC),
  UNIQUE INDEX `pet_id_UNIQUE` (`pet_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pet_status_change_logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`pet_status_change_logs` ;

CREATE TABLE IF NOT EXISTS `pohome`.`pet_status_change_logs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pets_id` INT UNSIGNED NOT NULL,
  `type` ENUM('L','S') NOT NULL,
  `old` TINYINT NOT NULL,
  `new` TINYINT NOT NULL,
  `remark` VARCHAR(400) NOT NULL,
  `users_id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pet_status_change_records_pets1_idx` (`pets_id` ASC),
  INDEX `fk_pet_status_change_records_users1_idx` (`users_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`blogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`blogs` ;

CREATE TABLE IF NOT EXISTS `pohome`.`blogs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `featured_image` VARCHAR(45) NULL,
  `content` TEXT NOT NULL,
  `catelog_id` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` DATETIME NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `draft` TINYINT(1) NOT NULL,
  `viewed` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_blogs_users1_idx` (`author_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`blog_has_pets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`blog_has_pets` ;

CREATE TABLE IF NOT EXISTS `pohome`.`blog_has_pets` (
  `blog_id` INT UNSIGNED NOT NULL,
  `pet_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`blog_id`, `pet_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`roles` ;

CREATE TABLE IF NOT EXISTS `pohome`.`roles` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `description` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`permissions` ;

CREATE TABLE IF NOT EXISTS `pohome`.`permissions` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `description` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`user_has_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`user_has_roles` ;

CREATE TABLE IF NOT EXISTS `pohome`.`user_has_roles` (
  `user_id` INT UNSIGNED NOT NULL,
  `role_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_users_has_roles_roles1_idx` (`role_id` ASC),
  INDEX `fk_users_has_roles_users1_idx` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`role_has_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`role_has_permissions` ;

CREATE TABLE IF NOT EXISTS `pohome`.`role_has_permissions` (
  `role_id` SMALLINT UNSIGNED NOT NULL,
  `permission_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `permission_id`),
  INDEX `fk_roles_has_permissions_permissions1_idx` (`permission_id` ASC),
  INDEX `fk_roles_has_permissions_roles1_idx` (`role_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`public_pet_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`public_pet_info` ;

CREATE TABLE IF NOT EXISTS `pohome`.`public_pet_info` (
  `pet_id` INT UNSIGNED NOT NULL,
  `type` ENUM('R','S') NOT NULL,
  `hope` VARCHAR(20) NOT NULL,
  `story` TEXT NOT NULL,
  `location_limit` ENUM('P','C','N') NOT NULL,
  INDEX `fk_public_pet_info_pets1_idx` (`pet_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`events` ;

CREATE TABLE IF NOT EXISTS `pohome`.`events` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL,
  `location` VARCHAR(20) NOT NULL DEFAULT '',
  `content` TEXT NOT NULL,
  `deadline` DATETIME NULL,
  `member_limit` TINYINT NOT NULL,
  `type` TINYINT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `taobao_link` VARCHAR(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  INDEX `fk_event_users1_idx` (`author_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`event_applications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`event_applications` ;

CREATE TABLE IF NOT EXISTS `pohome`.`event_applications` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `events_id` INT UNSIGNED NOT NULL,
  `users_id` INT UNSIGNED NOT NULL,
  `number_of_people` TINYINT NOT NULL,
  `location` VARCHAR(20) NOT NULL,
  `has_car` TINYINT(1) NULL,
  `contacted` TINYINT(1) NOT NULL,
  `approved` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_applications_events1_idx` (`events_id` ASC),
  INDEX `fk_event_applications_users1_idx` (`users_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`adoption_applications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`adoption_applications` ;

CREATE TABLE IF NOT EXISTS `pohome`.`adoption_applications` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pet_id` INT UNSIGNED NOT NULL,
  `applicant_id` INT UNSIGNED NOT NULL,
  `eq` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `application_form` TEXT NULL,
  `reviewed_at` DATETIME NULL,
  `status` TINYINT NULL,
  `closed_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_adoption_applications_pets1_idx` (`pet_id` ASC),
  INDEX `fk_adoption_applications_users1_idx` (`applicant_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`adoption_application_review_logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`adoption_application_review_logs` ;

CREATE TABLE IF NOT EXISTS `pohome`.`adoption_application_review_logs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `reviewer_id` INT UNSIGNED NOT NULL,
  `reviewed_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_adoption_application_review_logs_users1_idx` (`reviewer_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`files`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`files` ;

CREATE TABLE IF NOT EXISTS `pohome`.`files` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `filename` CHAR(19) NOT NULL,
  `uploader_id` INT UNSIGNED NOT NULL,
  `upload_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pet_images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`pet_images` ;

CREATE TABLE IF NOT EXISTS `pohome`.`pet_images` (
  `pet_id` INT UNSIGNED NOT NULL,
  `image_id` INT UNSIGNED NOT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`province`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`province` ;

CREATE TABLE IF NOT EXISTS `pohome`.`province` (
  `id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`pet` ;

CREATE TABLE IF NOT EXISTS `pohome`.`pet` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  `species` ENUM('D','C') NOT NULL,
  `gender` ENUM('M','F') NOT NULL,
  `breed` VARCHAR(10) NOT NULL,
  `birthday` DATE NOT NULL,
  `body_size` VARCHAR(45) NOT NULL,
  `neutered` TINYINT(1) NOT NULL,
  `location` TINYINT UNSIGNED NOT NULL,
  `status` TINYINT UNSIGNED NOT NULL,
  `adoptable` TINYINT(1) NOT NULL,
  `draft` TINYINT(1) NOT NULL,
  `viewed` INT UNSIGNED NOT NULL,
  `favorite` INT UNSIGNED NOT NULL,
  `creator_id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL COMMENT '  ',
  `modified_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pet_name_INDEX` ())
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pet_extra_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`pet_extra_info` ;

CREATE TABLE IF NOT EXISTS `pohome`.`pet_extra_info` (
  `pet_id` INT UNSIGNED NOT NULL,
  `character` VARCHAR(40) NOT NULL,
  `health` VARCHAR(40) NOT NULL,
  `notice` VARCHAR(400) NOT NULL,
  `entry_date` DATE NOT NULL,
  `neuter_date` DATE NULL,
  `last_immune_date` DATE NULL,
  `angel_id` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  INDEX `fk_pet_extra_info_pet1_idx` (`pet_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`user_extra_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`user_extra_info` ;

CREATE TABLE IF NOT EXISTS `pohome`.`user_extra_info` (
  `user_id` INT UNSIGNED NOT NULL,
  `realname` VARCHAR(15) NULL,
  `id_num` CHAR(18) NULL,
  `birthday` DATE NULL,
  `gender` ENUM('M','F') NULL,
  `province` TINYINT UNSIGNED NULL,
  `city` TINYINT UNSIGNED NULL,
  `qq` VARCHAR(15) NULL,
  `weibo` VARCHAR(30) NULL,
  `taobao` VARCHAR(25) NULL,
  `referee_id` INT UNSIGNED NULL,
  INDEX `fk_user_extra_info_user1_idx` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`log` ;

CREATE TABLE IF NOT EXISTS `pohome`.`log` (
  `id` INT UNSIGNED NOT NULL,
  `type` TINYINT UNSIGNED NOT NULL,
  `sub_type` TINYINT UNSIGNED NOT NULL,
  `datetime` DATETIME NOT NULL,
  `creator_id` INT UNSIGNED NOT NULL,
  `content` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`contribution_intension`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`contribution_intension` ;

CREATE TABLE IF NOT EXISTS `pohome`.`contribution_intension` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `intension` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`service_record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`service_record` ;

CREATE TABLE IF NOT EXISTS `pohome`.`service_record` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `contribution_hour` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_volunteer_service_record_user1_idx` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`volunteer_contribution_intension`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`volunteer_contribution_intension` ;

CREATE TABLE IF NOT EXISTS `pohome`.`volunteer_contribution_intension` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `contribution_intension_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_volunteer_contribution_intension_user1_idx` (`user_id` ASC),
  INDEX `fk_volunteer_contribution_intension_contribution_intension1_idx` (`contribution_intension_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`event` ;

CREATE TABLE IF NOT EXISTS `pohome`.`event` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `begin` DATETIME NOT NULL,
  `end` DATETIME NOT NULL,
  `deadline` DATETIME NULL,
  `location` VARCHAR(20) NOT NULL,
  `content` TEXT NOT NULL,
  `member_limit` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `type_id` TINYINT UNSIGNED NOT NULL,
  `published_id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`blog` ;

CREATE TABLE IF NOT EXISTS `pohome`.`blog` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `content` TEXT NOT NULL,
  `featured_image` CHAR(19) NOT NULL,
  `catelog_id` TINYINT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `draft` TINYINT(1) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `viewed` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`event_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`event_type` ;

CREATE TABLE IF NOT EXISTS `pohome`.`event_type` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`blog_catelog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`blog_catelog` ;

CREATE TABLE IF NOT EXISTS `pohome`.`blog_catelog` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`city` ;

CREATE TABLE IF NOT EXISTS `pohome`.`city` (
  `id` SMALLINT NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`event_application`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`event_application` ;

CREATE TABLE IF NOT EXISTS `pohome`.`event_application` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_id` INT UNSIGNED NOT NULL,
  `applicant_id` INT UNSIGNED NOT NULL,
  `number_of_people` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `location` VARCHAR(20) NOT NULL,
  `has_car` TINYINT(1) NOT NULL,
  `addition_remark` VARCHAR(100) NOT NULL,
  `applied_at` DATETIME NOT NULL,
  `contacted` TINYINT(1) NOT NULL DEFAULT 0,
  `approved` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`adoption_application`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`adoption_application` ;

CREATE TABLE IF NOT EXISTS `pohome`.`adoption_application` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pet_id` INT UNSIGNED NOT NULL,
  `applicant_id` INT UNSIGNED NOT NULL,
  `application_form` TEXT NOT NULL,
  `applied_at` DATETIME NOT NULL,
  `status` ENUM('S','R','EC','PC','V','A','D') NOT NULL,
  `closed` TINYINT(1) NOT NULL DEFAULT 0,
  `closed_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`contact_record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`contact_record` ;

CREATE TABLE IF NOT EXISTS `pohome`.`contact_record` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `application_id` INT UNSIGNED NOT NULL,
  `contact_person_id` INT UNSIGNED NOT NULL,
  `type` ENUM('P','E','R') NOT NULL,
  `opinion` VARCHAR(400) NOT NULL,
  `datetime` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`medical_record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`medical_record` ;

CREATE TABLE IF NOT EXISTS `pohome`.`medical_record` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pet_id` INT UNSIGNED NOT NULL,
  `datetime` DATETIME NOT NULL,
  `type` ENUM('N','I','A','B','T') NOT NULL,
  `detail` TEXT NOT NULL,
  `creator_id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pet_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`pet_log` ;

CREATE TABLE IF NOT EXISTS `pohome`.`pet_log` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pet_id` INT UNSIGNED NOT NULL,
  `log_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`file`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`file` ;

CREATE TABLE IF NOT EXISTS `pohome`.`file` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `filename` CHAR(19) NOT NULL,
  `path` VARCHAR(100) NOT NULL,
  `size` INT UNSIGNED NOT NULL,
  `uploader_id` INT UNSIGNED NOT NULL,
  `upload_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.`pet_photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`pet_photo` ;

CREATE TABLE IF NOT EXISTS `pohome`.`pet_photo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pet_id` INT UNSIGNED NOT NULL,
  `image_id` INT UNSIGNED NOT NULL,
  `priority` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pohome`.``
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pohome`.`` ;

CREATE TABLE IF NOT EXISTS `pohome`.`` (
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
