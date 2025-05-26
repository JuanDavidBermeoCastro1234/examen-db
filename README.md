# Examen final MySQL 1 - Grupo U2
El propósito de este examen es diseñar una base de datos que permita gestionar eficientemente los
productos, combos, pedidos y clientes de una pizzería. El sistema debe almacenar información sobre
pizzas, panzarottis, otros productos no elaborados (bebidas, postres, etc.), adiciones y el menú
disponible. Además, se deberán registrar los pedidos de los clientes, que pueden ser para consumir
en el lugar o para recoger.
Problema
La pizzería actualmente no tiene un sistema centralizado para gestionar sus productos y pedidos, lo
que genera confusión al manejar inventarios, combos y opciones de pedidos. También resulta difícil
hacer un seguimiento de los productos más vendidos o personalizar pedidos. Por lo tanto, se
requiere un sistema que permita gestionar de manera eficiente el menú, las combinaciones de
productos, las ventas, y los pedidos.
Características Principales
●​ Gestión de Productos: Registro completo de pizzas, panzarottis, bebidas, postres y otros
productos no elaborados. Se debe tener en cuenta los ingredientes que poseen los
productos.
●​ Gestión de Adiciones: Permitir a los clientes agregar adiciones (extra queso, salsas, etc.) a
sus productos.
●​ Gestión de Combos: Manejar combos que incluyen múltiples productos a un precio especial.
●​ Gestión de Pedidos: Registro de pedidos para consumir en la pizzería o para recoger, con
opción de personalización mediante adiciones.
●​ Gestión del Menú: Definir y actualizar el menú con las opciones disponibles.
Requisitos del Modelo Lógico y Físico
●​ El modelo lógico debe reflejar correctamente las entidades, relaciones, atributos y
cardinalidades, cubriendo todas las características principales.
●​ El modelo físico debe ser implementado en una base de datos MySQL, incluyendo las tablas
necesarias con sus claves primarias y foráneas.
●​ Evidencia fotográfica o uso de plataformas como drawSQL o StarUML debe ser
proporcionada, ya sea en forma de capturas de pantalla o enlaces a los diagramas (No se
reciben archivos para abrir en ningún software).
Tecnologías y Herramientas
●​ Base de Datos: MySQL para gestionar la información.
●​ Lenguaje de Consulta: SQL para las consultas necesarias.
●​ Herramientas de Diseño: MySQL Workbench u otras herramientas de diseño de bases de
datos.
Se debe crear un repositorio de GitHub (privado y compartido con las cuentas que el trailer indique)
que contenga:
1.​ Archivo SQL de la Estructura: Este archivo contendrá la definición completa de la base de
datos, incluyendo la creación de todas las tablas, así como las claves primarias y foráneasnecesarias para mantener la integridad referencial. Se asegurará que la estructura sea
implementable en un entorno MySQL.
2.​ Archivo SQL de los Datos: Este archivo incluirá los scripts para insertar datos de prueba en
las tablas creadas previamente. Los datos deberán representar escenarios realistas que
permitan validar el funcionamiento del sistema, incluyendo información sobre médicos,
empleados y pacientes.
3.​ README: Este documento proporcionará una descripción general del proyecto, incluyendo
instrucciones sobre cómo ejecutar los archivos SQL en un entorno MySQL. Además, incluirá
soluciones a las consultas SQL planteadas en el proyecto, explicando la lógica detrás de
cada consulta y cómo se relaciona con la estructura de la base de datos. Esto asegurará que
los evaluadores comprendan la funcionalidad del sistema y puedan verificar la correcta
implementación de las consultas.
​
Consultas a realizar (deben organizarse en el
Readme):
1.​ Productos más vendidos (pizza, panzarottis, bebidas, etc.)
2.​ Total de ingresos generados por cada combo
3.​ Pedidos realizados para recoger vs. comer en la pizzería
4.​ Adiciones más solicitadas en pedidos personalizados
5.​ Cantidad total de productos vendidos por categoría
6.​ Promedio de pizzas pedidas por cliente
7.​ Total de ventas por día de la semana
8.​ Cantidad de panzarottis vendidos con extra queso
9.​ Pedidos que incluyen bebidas como parte de un combo
10.​ Clientes que han realizado más de 5 pedidos en el último mes
11.​ Ingresos totales generados por productos no elaborados (bebidas, postres, etc.)
12.​ Promedio de adiciones por pedido
13.​ Total de combos vendidos en el último mes
14.​ Clientes con pedidos tanto para recoger como para consumir en el lugar
15.​ Total de productos personalizados con adiciones
16.​ Pedidos con más de 3 productos diferentes
17.​ Promedio de ingresos generados por día
18.​ Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos
19.​ Porcentaje de ventas provenientes de productos no elaborados
20.​ Día de la semana con mayor número de pedidos para recoger



