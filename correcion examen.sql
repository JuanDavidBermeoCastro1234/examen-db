CREATE DATABASE IF NOT EXISTS pizzeria;
USE pizzeria;

-- USUARIOS
CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(15)
);

-- TIPOS DE PRODUCTO
CREATE TABLE TIPO_PRODUCTO (
    id_tipo_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

-- PRODUCTOS
CREATE TABLE PRODUCTO (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(8,2),
    solo_en_combo BOOLEAN DEFAULT FALSE,
    id_tipo_producto INT,
    FOREIGN KEY (id_tipo_producto) REFERENCES TIPO_PRODUCTO(id_tipo_producto)
);

-- TIPOS DE PEDIDO
CREATE TABLE TIPO_PEDIDO (
    id_tipo_pedido INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

-- PEDIDOS
CREATE TABLE PEDIDO (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME,
    id_usuario INT,
    id_tipo_pedido INT,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_tipo_pedido) REFERENCES TIPO_PEDIDO(id_tipo_pedido)
);

-- PRODUCTOS EN PEDIDO
CREATE TABLE PRODUCTO_PEDIDO (
    id_producto_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);

-- TIPOS DE ADICION
CREATE TABLE TIPO_ADICION (
    id_tipo_adicion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

-- ADICIONES
CREATE TABLE ADICION (
    id_adicion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(8,2),
    id_tipo_adicion INT,
    FOREIGN KEY (id_tipo_adicion) REFERENCES TIPO_ADICION(id_tipo_adicion)
);

-- ADICIONES APLICADAS A PRODUCTOS DE PEDIDO
CREATE TABLE PRODUCTO_PEDIDO_ADICION (
    id_producto_pedido INT,
    id_adicion INT,
    PRIMARY KEY (id_producto_pedido, id_adicion),
    FOREIGN KEY (id_producto_pedido) REFERENCES PRODUCTO_PEDIDO(id_producto_pedido),
    FOREIGN KEY (id_adicion) REFERENCES ADICION(id_adicion)
);

-- COMBOS
CREATE TABLE COMBO (
    id_combo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(8,2)
);

-- PRODUCTOS QUE INCLUYE UN COMBO
CREATE TABLE COMBO_PRODUCTO (
    id_combo_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_combo INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_combo) REFERENCES COMBO(id_combo),
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);

-- COMBOS VENDIDOS EN UN PEDIDO
CREATE TABLE COMBO_PEDIDO (
    id_combo_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_combo INT,
    id_pedido INT,
    cantidad INT,
    FOREIGN KEY (id_combo) REFERENCES COMBO(id_combo),
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);

-- Tipos de producto
INSERT INTO TIPO_PRODUCTO (nombre) VALUES ('Pizza'), ('Bebida'), ('Postre');

-- Productos
INSERT INTO PRODUCTO (nombre, descripcion, precio, id_tipo_producto) VALUES
('Pizza Margarita', 'Pizza clasica con tomate y mozzarella', 25000, 1),
('Pizza Pepperoni', 'Pizza con pepperoni y queso', 28000, 1),
('Gaseosa 350ml', 'Coca-Cola', 5000, 2),
('Postre de chocolate', 'Brownie con helado', 8000, 3);

-- Tipos de pedido
INSERT INTO TIPO_PEDIDO (nombre) VALUES ('En tienda'), ('Para llevar');

-- Usuarios
INSERT INTO USUARIO (nombre, telefono) VALUES
('Carlos Perez', '3001234567'),
('Maria Garcia', '3009876543');

-- Pedidos
INSERT INTO PEDIDO (fecha_hora, id_usuario, id_tipo_pedido) VALUES
(NOW(), 1, 1),
(NOW(), 2, 2);

-- Productos en pedidos
INSERT INTO PRODUCTO_PEDIDO (id_pedido, id_producto, cantidad) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 1),
(2, 4, 2);

-- Tipos de adicion
INSERT INTO TIPO_ADICION (nombre) VALUES ('Salsa'), ('Extra Queso');

-- Adiciones
INSERT INTO ADICION (nombre, precio, id_tipo_adicion) VALUES
('Salsa BBQ', 2000, 1),
('Queso extra', 3000, 2);

-- Adiciones aplicadas
INSERT INTO PRODUCTO_PEDIDO_ADICION (id_producto_pedido, id_adicion) VALUES
(1, 1),
(1, 2),
(3, 1);

-- Combos
INSERT INTO COMBO (nombre, precio) VALUES
('Combo Familiar', 45000),
('Combo Pareja', 35000);

-- Productos en combos
INSERT INTO COMBO_PRODUCTO (id_combo, id_producto, cantidad) VALUES
(1, 1, 2),
(1, 3, 2),
(2, 2, 1),
(2, 3, 1);


-- consultas solicitadas 

-- Combos vendidos
INSERT INTO COMBO_PEDIDO (id_combo, id_pedido, cantidad) VALUES
(1, 1, 1),
(2, 2, 1);

-- 1. Total de ventas por producto
SELECT p.nombre, SUM(pp.cantidad) AS total_vendidos
FROM PRODUCTO_PEDIDO pp
JOIN PRODUCTO p ON pp.id_producto = p.id_producto
GROUP BY p.nombre;

-- 2. Productos más vendidos (top 5)
SELECT p.nombre, SUM(pp.cantidad) AS vendidos
FROM PRODUCTO_PEDIDO pp
JOIN PRODUCTO p ON pp.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY vendidos DESC
LIMIT 5;

-- 3. Total recaudado por cada pedido
SELECT pe.id_pedido, SUM(pr.precio * pp.cantidad) AS total
FROM PEDIDO pe
JOIN PRODUCTO_PEDIDO pp ON pe.id_pedido = pp.id_pedido
JOIN PRODUCTO pr ON pp.id_producto = pr.id_producto
GROUP BY pe.id_pedido;

-- 4. Pedidos hechos por cada usuario
SELECT u.nombre, COUNT(p.id_pedido) AS total_pedidos
FROM USUARIO u
JOIN PEDIDO p ON u.id_usuario = p.id_usuario
GROUP BY u.nombre;

-- 5. Total recaudado por combos
SELECT c.nombre, SUM(cp.cantidad * c.precio) AS total_combo
FROM COMBO_PEDIDO cp
JOIN COMBO c ON cp.id_combo = c.id_combo
GROUP BY c.nombre;

-- 6. Productos de cada combo
SELECT c.nombre AS combo, p.nombre AS producto, cp.cantidad
FROM COMBO_PRODUCTO cp
JOIN COMBO c ON cp.id_combo = c.id_combo
JOIN PRODUCTO p ON cp.id_producto = p.id_producto;

-- 7. Ventas por tipo de producto
SELECT tp.nombre AS tipo, SUM(pp.cantidad) AS total_vendidos
FROM PRODUCTO_PEDIDO pp
JOIN PRODUCTO p ON pp.id_producto = p.id_producto
JOIN TIPO_PRODUCTO tp ON p.id_tipo_producto = tp.id_tipo_producto
GROUP BY tp.nombre;

-- 8. Pedidos con adiciones
SELECT pe.id_pedido, COUNT(DISTINCT ppa.id_adicion) AS total_adiciones
FROM PEDIDO pe
JOIN PRODUCTO_PEDIDO pp ON pe.id_pedido = pp.id_pedido
JOIN PRODUCTO_PEDIDO_ADICION ppa ON pp.id_producto_pedido = ppa.id_producto_pedido
GROUP BY pe.id_pedido;

-- 9. Adiciones más solicitadas
SELECT a.nombre, COUNT(*) AS veces_usada
FROM PRODUCTO_PEDIDO_ADICION ppa
JOIN ADICION a ON ppa.id_adicion = a.id_adicion
GROUP BY a.nombre
ORDER BY veces_usada DESC;

-- 10. Pedidos por fecha
SELECT DATE(fecha_hora) AS fecha, COUNT(*) AS total_pedidos
FROM PEDIDO
GROUP BY fecha;

-- 11. Ventas por tipo de pedido
SELECT tp.nombre, COUNT(p.id_pedido) AS cantidad
FROM PEDIDO p
JOIN TIPO_PEDIDO tp ON p.id_tipo_pedido = tp.id_tipo_pedido
GROUP BY tp.nombre;

-- 12. Usuarios frecuentes (más de 1 pedido)
SELECT u.nombre, COUNT(p.id_pedido) AS pedidos
FROM USUARIO u
JOIN PEDIDO p ON u.id_usuario = p.id_usuario
GROUP BY u.nombre
HAVING pedidos > 1;

-- 13. Productos con adiciones extra
SELECT DISTINCT p.nombre
FROM PRODUCTO_PEDIDO_ADICION ppa
JOIN PRODUCTO_PEDIDO pp ON ppa.id_producto_pedido = pp.id_producto_pedido
JOIN PRODUCTO p ON pp.id_producto = p.id_producto;

-- 14. Total generado por adiciones
SELECT SUM(a.precio) AS total_adiciones
FROM PRODUCTO_PEDIDO_ADICION ppa
JOIN ADICION a ON ppa.id_adicion = a.id_adicion;

-- 15. Usuarios y su pedido más reciente
SELECT u.nombre, MAX(p.fecha_hora) AS ultimo_pedido
FROM USUARIO u
JOIN PEDIDO p ON u.id_usuario = p.id_usuario
GROUP BY u.nombre;

-- 16. Productos vendidos por fecha
SELECT DATE(p.fecha_hora) AS fecha, pr.nombre, SUM(pp.cantidad) AS vendidos
FROM PEDIDO p
JOIN PRODUCTO_PEDIDO pp ON p.id_pedido = pp.id_pedido
JOIN PRODUCTO pr ON pp.id_producto = pr.id_producto
GROUP BY fecha, pr.nombre;

-- 17. Total recaudado en el día actual
SELECT SUM(pr.precio * pp.cantidad) AS total_hoy
FROM PEDIDO p
JOIN PRODUCTO_PEDIDO pp ON p.id_pedido = pp.id_pedido
JOIN PRODUCTO pr ON pp.id_producto = pr.id_producto
WHERE DATE(p.fecha_hora) = CURDATE();

-- 18. Promedio de productos por pedido
SELECT AVG(cantidad_productos) AS promedio
FROM (
    SELECT COUNT(*) AS cantidad_productos
    FROM PRODUCTO_PEDIDO
    GROUP BY id_pedido
) AS sub;

-- 19. Productos que solo están en combos
SELECT p.nombre
FROM PRODUCTO p
WHERE p.solo_en_combo = TRUE;

-- 20. Total de combos vendidos por tipo
SELECT c.nombre, SUM(cp.cantidad) AS total_vendidos
FROM COMBO_PEDIDO cp
JOIN COMBO c ON cp.id_combo = c.id_combo
GROUP BY c.nombre;
