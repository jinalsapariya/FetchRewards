-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FetchRewards
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FetchRewards
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FetchRewards` DEFAULT CHARACTER SET utf8 ;
USE `FetchRewards` ;

-- -----------------------------------------------------
-- Table `FetchRewards`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FetchRewards`.`Users` (
  `userId` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NULL,
  `createdDate` DATE NULL,
  `lastLogin` DATETIME NULL,
  `role` VARCHAR(45) NULL,
  `active` VARCHAR(45) NULL,
  `signUpSource` VARCHAR(45) NULL,
  PRIMARY KEY (`userId`),
  UNIQUE INDEX `userId_UNIQUE` (`userId` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FetchRewards`.`Brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FetchRewards`.`Brand` (
  `brandId` VARCHAR(45) NOT NULL,
  `barcode` INT NOT NULL,
  `brandCode` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NULL,
  `categoryCode` VARCHAR(45) NULL,
  `cpg` VARCHAR(45) NULL,
  `topBrand` TINYINT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`brandCode`, `brandId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FetchRewards`.`Receipts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FetchRewards`.`Receipts` (
  `receiptId` VARCHAR(45) NOT NULL,
  `bonusPointsEarned` INT NULL,
  `bonusPointsEarnedReason` VARCHAR(45) NULL,
  `createDate` DATE NULL,
  `dateScanned` DATETIME NULL,
  `finishedDate` DATETIME NULL,
  `modifyDate` DATETIME NULL,
  `pointsAwardedDate` DATETIME NULL,
  `pointsEarned` FLOAT NULL,
  `purchaseDate` DATETIME NULL,
  `purchasedItemCount` INT NULL,
  `rewardsReceiptStatus` VARCHAR(45) NULL,
  `totalSpent` FLOAT NULL,
  `userId` VARCHAR(45) NULL,
  `Users_userId` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`receiptId`, `Users_userId`),
  INDEX `fk_Receipts_Users_idx` (`Users_userId` ASC) VISIBLE,
  CONSTRAINT `fk_Receipts_Users`
    FOREIGN KEY (`Users_userId`)
    REFERENCES `FetchRewards`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FetchRewards`.`RewardsReceiptItemDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FetchRewards`.`RewardsReceiptItemDetails` (
  `barcode` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `finalPrice` FLOAT NULL,
  `itemPrice` FLOAT NULL,
  `needsFetchReview` TINYINT NULL,
  `partnerItemId` INT NULL,
  `preventTargetGapPoints` TINYINT NULL,
  `quantityPurchased` INT NULL,
  `userFlaggedBarcode` INT NULL,
  `userFlaggedNewItem` TINYINT NULL,
  `userFlaggedPrice` FLOAT NULL,
  `userFlaggedQuantity` TINYINT NULL,
  `itemNumber` FLOAT NULL,
  `RewardsReceiptItemDetailscol` VARCHAR(45) NULL,
  `userFlaggedDescription` VARCHAR(45) NULL,
  `originalReceiptItemText` VARCHAR(45) NULL,
  `deleted` TINYINT NULL,
  `metabriteCampaignId` VARCHAR(45) NULL,
  `discountedItemPrice` FLOAT NULL,
  `competitiveProduct` VARCHAR(45) NULL,
  `originalMetaBriteDescription` VARCHAR(45) NULL,
  `pointsNotAwardedReason` VARCHAR(45) NULL,
  `originalMetaBriteBarcode` FLOAT NULL,
  `originalMetaBriteItemPrice` FLOAT NULL,
  `pointsPayerId` VARCHAR(45) NULL,
  `originalMetaBriteQuantityPurchased` VARCHAR(45) NULL,
  `originalFinalPrice` FLOAT NULL,
  `targetPrice` FLOAT NULL,
  `pointsEarned` FLOAT NULL,
  `competitorRewardsGroup` VARCHAR(45) NULL,
  `rewardsProductPartnerId` VARCHAR(45) NULL,
  `rewardsGroup` VARCHAR(45) NULL,
  `priceAfterCoupon` FLOAT NULL,
  `receiptId` VARCHAR(45) NULL,
  `Receipts_receiptId` VARCHAR(45) NOT NULL,
  `brandCode` VARCHAR(60) NULL,
  `Brand_brandCode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`barcode`, `Brand_brandCode`),
  INDEX `fk_RewardsReceiptItemDetails_Receipts1_idx` (`Receipts_receiptId` ASC) VISIBLE,
  INDEX `fk_RewardsReceiptItemDetails_Brand1_idx` (`Brand_brandCode` ASC) VISIBLE,
  CONSTRAINT `fk_RewardsReceiptItemDetails_Receipts1`
    FOREIGN KEY (`Receipts_receiptId`)
    REFERENCES `FetchRewards`.`Receipts` (`receiptId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RewardsReceiptItemDetails_Brand1`
    FOREIGN KEY (`Brand_brandCode`)
    REFERENCES `FetchRewards`.`Brand` (`brandCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
