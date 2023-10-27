-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema impactxgrupo3_impactx
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema impactxgrupo3_impactx
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `impactxgrupo3_impactx` DEFAULT CHARACTER SET utf8mb4 ;
USE `impactxgrupo3_impactx` ;

-- -----------------------------------------------------
-- Table `impactxgrupo3_impactx`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `impactxgrupo3_impactx`.`categories` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `impactxgrupo3_impactx`.`profiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `impactxgrupo3_impactx`.`profiles` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `impactxgrupo3_impactx`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `impactxgrupo3_impactx`.`users` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `user_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `profile_id` BIGINT(20) UNSIGNED NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `confirm_password` VARCHAR(255) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `users_profile_id_foreign` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `users_profile_id_foreign`
    FOREIGN KEY (`profile_id`)
    REFERENCES `impactxgrupo3_impactx`.`profiles` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 121
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `impactxgrupo3_impactx`.`contact_msg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `impactxgrupo3_impactx`.`contact_msg` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT(20) UNSIGNED NOT NULL,
  `message` TEXT NOT NULL,
  `response` TEXT NULL DEFAULT NULL,
  `is_answered` TINYINT(3) UNSIGNED NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `contact_msg_user_id_foreign` (`user_id` ASC) VISIBLE,
  CONSTRAINT `contact_msg_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `impactxgrupo3_impactx`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 40
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `impactxgrupo3_impactx`.`old_passwords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `impactxgrupo3_impactx`.`old_passwords` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT(20) UNSIGNED NOT NULL,
  `old_password` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `old_passwords_user_id_foreign` (`user_id` ASC) VISIBLE,
  CONSTRAINT `old_passwords_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `impactxgrupo3_impactx`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `impactxgrupo3_impactx`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `impactxgrupo3_impactx`.`products` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `category_id` BIGINT(20) UNSIGNED NOT NULL,
  `price` BIGINT(20) UNSIGNED NOT NULL,
  `description` TEXT NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `products_category_id_foreign` (`category_id` ASC) VISIBLE,
  CONSTRAINT `products_category_id_foreign`
    FOREIGN KEY (`category_id`)
    REFERENCES `impactxgrupo3_impactx`.`categories` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 47
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `impactxgrupo3_impactx`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `impactxgrupo3_impactx`.`ticket` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT(20) UNSIGNED NOT NULL,
  `date` DATETIME NOT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  `province` VARCHAR(255) NULL DEFAULT NULL,
  `country` VARCHAR(255) NULL DEFAULT NULL,
  `total` BIGINT(20) UNSIGNED NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `ticket_user_id_foreign` (`user_id` ASC) VISIBLE,
  CONSTRAINT `ticket_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `impactxgrupo3_impactx`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 62
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `impactxgrupo3_impactx`.`product_ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `impactxgrupo3_impactx`.`product_ticket` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_id` BIGINT(20) UNSIGNED NOT NULL,
  `product_id` BIGINT(20) UNSIGNED NOT NULL,
  `price` BIGINT(20) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_ticket_ticket_id_foreign` (`ticket_id` ASC) VISIBLE,
  INDEX `product_ticket_product_id_foreign` (`product_id` ASC) VISIBLE,
  CONSTRAINT `product_ticket_product_id_foreign`
    FOREIGN KEY (`product_id`)
    REFERENCES `impactxgrupo3_impactx`.`products` (`id`),
  CONSTRAINT `product_ticket_ticket_id_foreign`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `impactxgrupo3_impactx`.`ticket` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 91
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `impactxgrupo3_impactx`.`user_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `impactxgrupo3_impactx`.`user_product` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT(20) UNSIGNED NOT NULL,
  `product_id` BIGINT(20) UNSIGNED NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_product_product_id_foreign` (`product_id` ASC) VISIBLE,
  INDEX `user_product_user_id_foreign` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_product_product_id_foreign`
    FOREIGN KEY (`product_id`)
    REFERENCES `impactxgrupo3_impactx`.`products` (`id`),
  CONSTRAINT `user_product_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `impactxgrupo3_impactx`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO categories (id, name, created_at) VALUES (1, 'Servicio');
INSERT INTO categories (id, name, created_at) VALUES (2, 'Producto');


INSERT INTO profiles (id, name, created_at) VALUES (1, 'Admin');
INSERT INTO profiles (id, name, created_at) VALUES (2, 'Cliente');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
