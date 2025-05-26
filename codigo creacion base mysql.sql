-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`pizzeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizzeria` (
  `id_pizzeria` INT NOT NULL AUTO_INCREMENT,
  `Nombrepizzeria` VARCHAR(45) NOT NULL,
  `direccion_pizzeria` VARCHAR(45) NOT NULL,
  `numero_rut` INT NOT NULL,
  PRIMARY KEY (`id_pizzeria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `idclientes` INT NOT NULL AUTO_INCREMENT,
  `id_pizzeria` INT NOT NULL,
  `nombre_cliente` VARCHAR(45) NOT NULL,
  `direccion_del_cliente` VARCHAR(45) NOT NULL,
  `Telefono_cliente` INT NOT NULL,
  `pizzeria_id_pizzeria` INT NOT NULL,
  PRIMARY KEY (`idclientes`),
  INDEX `fk_clientes_pizzeria1_idx` (`pizzeria_id_pizzeria` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_pizzeria1`
    FOREIGN KEY (`pizzeria_id_pizzeria`)
    REFERENCES `mydb`.`pizzeria` (`id_pizzeria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedidos_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedidos_cliente` (
  `idPedidos_cliente` INT NOT NULL AUTO_INCREMENT,
  `idclientes` INT NOT NULL,
  `idcombos` INT NULL,
  `id_productos` INT NULL,
  `idAdicionales_pedidos` INT NULL,
  `domicilio/consumo_en_tienda` VARCHAR(45) NOT NULL,
  `pago_(targeta,efectivo)` VARCHAR(45) NOT NULL,
  `clientes_idclientes` INT NOT NULL,
  PRIMARY KEY (`idPedidos_cliente`),
  INDEX `fk_Pedidos_cliente_clientes_idx` (`clientes_idclientes` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_cliente_clientes`
    FOREIGN KEY (`clientes_idclientes`)
    REFERENCES `mydb`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Menu` (
  `idMenu` INT NOT NULL AUTO_INCREMENT,
  `id_productos` INT NOT NULL,
  `idcombos` INT NOT NULL,
  `idAdicionales_pedidos` INT NOT NULL,
  PRIMARY KEY (`idMenu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`combos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`combos` (
  `idcombos` INT NOT NULL AUTO_INCREMENT,
  `nombre_combo` VARCHAR(45) NOT NULL,
  `id_productos` INT NOT NULL,
  `precio_combo` INT NOT NULL,
  `idAdicionales_pedidos` INT NOT NULL,
  `id_ingredientes` VARCHAR(45) NOT NULL,
  `Pedidos_cliente_idPedidos_cliente` INT NOT NULL,
  `Menu_idMenu` INT NOT NULL,
  PRIMARY KEY (`idcombos`),
  INDEX `fk_combos_Pedidos_cliente1_idx` (`Pedidos_cliente_idPedidos_cliente` ASC) VISIBLE,
  INDEX `fk_combos_Menu1_idx` (`Menu_idMenu` ASC) VISIBLE,
  CONSTRAINT `fk_combos_Pedidos_cliente1`
    FOREIGN KEY (`Pedidos_cliente_idPedidos_cliente`)
    REFERENCES `mydb`.`Pedidos_cliente` (`idPedidos_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_combos_Menu1`
    FOREIGN KEY (`Menu_idMenu`)
    REFERENCES `mydb`.`Menu` (`idMenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`productos_pizzeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`productos_pizzeria` (
  `id_productos` INT NOT NULL AUTO_INCREMENT,
  `productos_pizzeria` VARCHAR(45) NOT NULL,
  `precio_producto` INT NOT NULL,
  `id_ingredientes` INT NOT NULL,
  `productos_elaborado_(si,no)` VARCHAR(4) NOT NULL,
  `Pedidos_cliente_idPedidos_cliente` INT NOT NULL,
  `Menu_idMenu` INT NOT NULL,
  PRIMARY KEY (`id_productos`),
  INDEX `fk_productos_pizzeria_Pedidos_cliente1_idx` (`Pedidos_cliente_idPedidos_cliente` ASC) VISIBLE,
  INDEX `fk_productos_pizzeria_Menu1_idx` (`Menu_idMenu` ASC) VISIBLE,
  CONSTRAINT `fk_productos_pizzeria_Pedidos_cliente1`
    FOREIGN KEY (`Pedidos_cliente_idPedidos_cliente`)
    REFERENCES `mydb`.`Pedidos_cliente` (`idPedidos_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_pizzeria_Menu1`
    FOREIGN KEY (`Menu_idMenu`)
    REFERENCES `mydb`.`Menu` (`idMenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`Ingredientes_Productos` (
  `id_ingredientes` INT NOT NULL AUTO_INCREMENT,
  `nombre_ingrediente` VARCHAR(45) NOT NULL,
  `precio_ingrediente` INT NOT NULL,
  `productos_pizzeria_id_productos` INT NOT NULL,
  `combos_idcombos` INT NOT NULL,
  PRIMARY KEY (`id_ingredientes`),
  INDEX `fk_Ingredientes_Productos_productos_pizzeria1_idx` (`productos_pizzeria_id_productos` ASC) VISIBLE,
  INDEX `fk_Ingredientes_Productos_combos1_idx` (`combos_idcombos` ASC) VISIBLE,
  CONSTRAINT `fk_Ingredientes_Productos_productos_pizzeria1`
    FOREIGN KEY (`productos_pizzeria_id_productos`)
    REFERENCES `mydb`.`productos_pizzeria` (`id_productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingredientes_Productos_combos1`
    FOREIGN KEY (`combos_idcombos`)
    REFERENCES `mydb`.`combos` (`idcombos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Adicionales_pedidos` (
  `idAdicionales_pedidos` INT NOT NULL AUTO_INCREMENT,
  `nombre_del_adicional` VARCHAR(45) NOT NULL,
  `precio_del_adicional` INT NOT NULL,
  `cantidad_por_adicional` INT NOT NULL,
  `Menu_idMenu` INT NOT NULL,
  PRIMARY KEY (`idAdicionales_pedidos`),
  INDEX `fk_Adicionales_pedidos_Menu1_idx` (`Menu_idMenu` ASC) VISIBLE,
  CONSTRAINT `fk_Adicionales_pedidos_Menu1`
    FOREIGN KEY (`Menu_idMenu`)
    REFERENCES `mydb`.`Menu` (`idMenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Clientes
INSERT INTO clientes (idclientes, nombre_cliente, telefono_cliente) VALUES (1, 'Juan Pérez',
'123456789');
INSERT INTO clientes (idclientes, nombre_cliente, telefono_cliente) VALUES (2, 'Ana López',
'987654321');
-- Pizzas
INSERT INTO Pedidos_cliente (id_productos, productos_pizzeria, precio_producto) VALUES (1, 'Pepperoni', 150);
INSERT INTO Pedidos_cliente (id_productos, productos_pizzeria, precio_producto) VALUES (2, 'Hawaiana', 200);
-- Pedidos
INSERT INTO pedidos (idPedidos_cliente, idclientes, idcombos,id_productos) VALUES (1, 1, 1,1);
INSERT INTO pedidos (idPedidos_cliente, idclientes, idcombos,id_productos) VALUES (2, 2, 2,2);





