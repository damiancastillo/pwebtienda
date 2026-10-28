DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda;
USE tienda;

-- 1. Categorías (necesaria primero por la FK)
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO categorias VALUES (1, 'General');

-- 2. Usuarios - YA CON ROL
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    pass VARCHAR(100) NOT NULL,
    rol VARCHAR(20) NOT NULL -- ADMIN, VENDEDOR, CLIENTE
);

-- 3. Productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    cilindrada INT DEFAULT 0,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    descripcion VARCHAR(255),
    id_categoria INT DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- 4. Ventas
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- 5. Pagos
CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(20) NOT NULL,
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);

-- 6. Pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT DEFAULT 1,
    estado VARCHAR(20) DEFAULT 'en_carrito',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- 7. Servicios
CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    tipo_servicio VARCHAR(50),
    fecha_cita DATE,
    estado VARCHAR(20) DEFAULT 'pendiente',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- 8. Repuestos
CREATE TABLE repuestos (
    id_repuesto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    compatible_con VARCHAR(100),
    precio DECIMAL(10,2),
    stock INT
);

-- DATOS DE PRUEBA - Ahora con roles
INSERT INTO usuarios (username, pass, rol) VALUES 
('admin', '123', 'ADMIN'),	
('vendedor', '123', 'VENDEDOR'),
('cliente', '123', 'CLIENTE');

INSERT INTO productos (nombre_producto, marca, modelo, cilindrada, precio, stock, descripcion) 
VALUES ('FZ-25', 'Yamaha', '2024', 250, 85000.00, 5, 'Moto urbana');