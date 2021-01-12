-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`CLIENTE_TIPO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENTE_TIPO` (
  `ctip_id` INT NOT NULL COMMENT '',
  `ctip_nombre` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`ctip_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENTE` (
  `cli_id` INT NOT NULL COMMENT '',
  `cli_tipo` INT NOT NULL COMMENT '',
  `cli_nombre` VARCHAR(45) NOT NULL COMMENT '',
  `cli_dirección` VARCHAR(45) NULL COMMENT '',
  `cli_telefono` INT NULL COMMENT '',
  `cli_nit` VARCHAR(45) NULL COMMENT '',
  `cli_cedula` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`cli_id`, `cli_tipo`)  COMMENT '',
  INDEX `fk_CLIENTE_CLIENTE_TIPO1_idx` (`cli_tipo` ASC)  COMMENT '',
  CONSTRAINT `fk_CLIENTE_CLIENTE_TIPO1`
    FOREIGN KEY (`cli_tipo`)
    REFERENCES `mydb`.`CLIENTE_TIPO` (`ctip_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VENDEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VENDEDOR` (
  `ven_id` INT NOT NULL COMMENT '',
  `ven_nombre` VARCHAR(45) NOT NULL COMMENT '',
  `ven_cedula` INT NOT NULL COMMENT '',
  `ven_email` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`ven_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FACTURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FACTURA` (
  `fac_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `fac_ven_id` INT NOT NULL COMMENT '',
  `fac_cli_id` INT NOT NULL COMMENT '',
  `fac_fecha` DATE NOT NULL COMMENT '',
  `fac_subtotal` FLOAT NOT NULL COMMENT '',
  `fac_iva` FLOAT NOT NULL COMMENT '',
  `fac_total` FLOAT NOT NULL COMMENT '',
  INDEX `fk_VENDEDOR_has_CLIENTE_CLIENTE1_idx` (`fac_cli_id` ASC)  COMMENT '',
  INDEX `fk_VENDEDOR_has_CLIENTE_VENDEDOR_idx` (`fac_ven_id` ASC)  COMMENT '',
  PRIMARY KEY (`fac_id`)  COMMENT '',
  CONSTRAINT `fk_VENDEDOR_has_CLIENTE_VENDEDOR`
    FOREIGN KEY (`fac_ven_id`)
    REFERENCES `mydb`.`VENDEDOR` (`ven_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENDEDOR_has_CLIENTE_CLIENTE1`
    FOREIGN KEY (`fac_cli_id`)
    REFERENCES `mydb`.`CLIENTE` (`cli_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FABRICANTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FABRICANTE` (
  `fab_id` INT NOT NULL COMMENT '',
  `fab_nombre` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`fab_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTO_CLASE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTO_CLASE` (
  `pcla_id` INT NOT NULL COMMENT '',
  `pcla_nombre` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`pcla_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTO_TIPO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTO_TIPO` (
  `ptip_id` INT NOT NULL COMMENT '',
  `ptip_clase` INT NOT NULL COMMENT '',
  `ptip_nombre` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`ptip_id`)  COMMENT '',
  INDEX `fk_PRODUCTO_TIPO_PRODUCTO_CLASE1_idx` (`ptip_clase` ASC)  COMMENT '',
  CONSTRAINT `fk_PRODUCTO_TIPO_PRODUCTO_CLASE1`
    FOREIGN KEY (`ptip_clase`)
    REFERENCES `mydb`.`PRODUCTO_CLASE` (`pcla_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTO` (
  `pro_codigo` INT NOT NULL COMMENT '',
  `pro_fabricante` INT NOT NULL COMMENT '',
  `pro_tipo` INT NOT NULL COMMENT '',
  `pro_precio` DOUBLE NOT NULL COMMENT '',
  `pro_disponible` INT NOT NULL COMMENT '',
  PRIMARY KEY (`pro_codigo`)  COMMENT '',
  INDEX `fk_PRODUCTO_FABRICANTE1_idx` (`pro_fabricante` ASC)  COMMENT '',
  INDEX `fk_PRODUCTO_PRODUCTO_TIPO1_idx` (`pro_tipo` ASC)  COMMENT '',
  CONSTRAINT `fk_PRODUCTO_FABRICANTE1`
    FOREIGN KEY (`pro_fabricante`)
    REFERENCES `mydb`.`FABRICANTE` (`fab_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTO_PRODUCTO_TIPO1`
    FOREIGN KEY (`pro_tipo`)
    REFERENCES `mydb`.`PRODUCTO_TIPO` (`ptip_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VENTA_DETALLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VENTA_DETALLES` (
  `vdet_factura` INT NOT NULL COMMENT '',
  `vdet_producto` INT NOT NULL COMMENT '',
  `vdet_cantidad` FLOAT NOT NULL COMMENT '',
  PRIMARY KEY (`vdet_factura`, `vdet_producto`)  COMMENT '',
  INDEX `fk_VENTA_has_PRODUCTO_PRODUCTO1_idx` (`vdet_producto` ASC)  COMMENT '',
  INDEX `fk_VENTA_has_PRODUCTO_VENTA1_idx` (`vdet_factura` ASC)  COMMENT '',
  CONSTRAINT `fk_VENTA_has_PRODUCTO_VENTA1`
    FOREIGN KEY (`vdet_factura`)
    REFERENCES `mydb`.`FACTURA` (`fac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENTA_has_PRODUCTO_PRODUCTO1`
    FOREIGN KEY (`vdet_producto`)
    REFERENCES `mydb`.`PRODUCTO` (`pro_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ALMACEN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ALMACEN` (
  `alm_id` INT NOT NULL COMMENT '',
  `alm_direccion` VARCHAR(45) NOT NULL COMMENT '',
  `alm_telefono` INT NOT NULL COMMENT '',
  PRIMARY KEY (`alm_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`INVETARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`INVETARIO` (
  `inv_almacen` INT NOT NULL COMMENT '',
  `inv_producto` INT NOT NULL COMMENT '',
  `inv_cantidad` INT NOT NULL COMMENT '',
  PRIMARY KEY (`inv_almacen`, `inv_producto`)  COMMENT '',
  INDEX `fk_ALMACEN_has_PRODUCTO_PRODUCTO1_idx` (`inv_producto` ASC)  COMMENT '',
  INDEX `fk_ALMACEN_has_PRODUCTO_ALMACEN1_idx` (`inv_almacen` ASC)  COMMENT '',
  CONSTRAINT `fk_ALMACEN_has_PRODUCTO_ALMACEN1`
    FOREIGN KEY (`inv_almacen`)
    REFERENCES `mydb`.`ALMACEN` (`alm_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALMACEN_has_PRODUCTO_PRODUCTO1`
    FOREIGN KEY (`inv_producto`)
    REFERENCES `mydb`.`PRODUCTO` (`pro_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
