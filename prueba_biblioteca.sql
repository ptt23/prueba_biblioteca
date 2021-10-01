
-- Se crea la BBDD bliblioteca
CREATE DATABASE bliblioteca
-- Nos dirigimos a BBDD bliblioteca
\c bliblioteca

-- Se crea la tabla Socios
CREATE TABLE socios (
    rut VARCHAR (25),
    nombre VARCHAR (25),
    apellido VARCHAR (25),
    direccion VARCHAR UNIQUE,
    telefono INT UNIQUE,
    PRIMARY KEY (rut)
);
-- SE INSERTAN DATOS EN TABLA SOCIOS
INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES
('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1', 911111111);
INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES
('2222222-2', 'ANA', 'PÉREZ', 'PASAJE 2', 922222222);
INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES
('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2', 933333333);
INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES
('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3', 944444444);
INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES
('5555555-5', 'SILVANA', 'MUNOZ', 'PASAJE 3', 955555555);

-- Se crea la tabla libros
CREATE TABLE libros (
    isbn VARCHAR (25),
    titulo VARCHAR (25),
    numero_pag INT,
    dias_prestamos INT,
    PRIMARY KEY (isbn)
);

-- SE INSERTAN DATOS EN TABLA LIBROS
INSERT INTO libros (isbn, titulo, numero_pag, dias_prestamos) VALUES
('111-1111111-111', 'CUENTOS DE TERROR', 344, 7);
INSERT INTO libros (isbn, titulo, numero_pag, dias_prestamos) VALUES
('222-2222222-222', 'POESÍAS CONTEMPORANEAS', 167, 7);
INSERT INTO libros (isbn, titulo, numero_pag, dias_prestamos) VALUES
('333-3333333-333', 'HISTORIA DE ASIA', 511, 14);
INSERT INTO libros (isbn, titulo, numero_pag, dias_prestamos) VALUES
('444-4444444-444', 'MANUAL DE MECÁNICA', 298, 14);

-- Se crea tabla autor
CREATE TABLE autor (
    cod_autor INT,
    nombre VARCHAR (25),
    apellido VARCHAR (25),
    year_nacimiento INT,
    year_muerte INT NULL,
    PRIMARY KEY (cod_autor)
);

-- SE INSERTAN DATOS EN TABLA AUTOR
INSERT INTO autor (cod_autor, nombre, apellido, year_nacimiento,year_muerte) VALUES
(1, 'Andrés', 'Ulloa', 1968, 2020);
INSERT INTO autor (cod_autor, nombre, apellido, year_nacimiento,year_muerte) VALUES
(2, 'Sergio', 'Mardones', 1972, 2020);
INSERT INTO autor (cod_autor, nombre, apellido, year_nacimiento,year_muerte) VALUES
(3, 'Jose', 'Salgado', 1982, NULL);
INSERT INTO autor (cod_autor, nombre, apellido, year_nacimiento,year_muerte) VALUES
(4, 'Ana', 'Salgado', 1950, NULL);
INSERT INTO autor (cod_autor, nombre, apellido, year_nacimiento,year_muerte) VALUES
(5, 'Martin ', 'Porta', 1976, NULL);

-- Se crea la tabla autor_libros
CREATE TABLE autor_libros (
    isbn_id_autor_libros VARCHAR(25),
    cod_autor_libro INT,
    tipo_autor VARCHAR (25),
    FOREIGN KEY (isbn_id_autor_libros) REFERENCES libros(isbn),
    FOREIGN KEY (cod_autor_libro) REFERENCES autor(cod_autor)
);

-- SE INSERTAN DATOS EN TABLA AUTOR_LIBROS
INSERT INTO libros (isbn_id_autor_libros, cod_autor_libro, tipo_autor) VALUES
('111-1111111-111', 3, 'PRINCIPAL');
INSERT INTO libros (isbn_id_autor_libros, cod_autor_libro, tipo_autor) VALUES
('111-1111111-111', 4, 'COAUTOR');
INSERT INTO libros (isbn_id_autor_libros, cod_autor_libro, tipo_autor) VALUES
('222-2222222-222', 1, 'PRINCIPAL');
INSERT INTO libros (isbn_id_autor_libros, cod_autor_libro, tipo_autor) VALUES
('333-3333333-333', 2, 'PRINCIPAL');
INSERT INTO libros (isbn_id_autor_libros, cod_autor_libro, tipo_autor) VALUES
('444-4444444-444', 5, 'PRINCIPAL');

-- Se crea la tabla datos_prestamos
CREATE TABLE datos_prestamos (
    isbn_id VARCHAR (25),
    rut_id VARCHAR (25),
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    FOREIGN KEY (isbn_id) REFERENCES libros (isbn),
    FOREIGN KEY (rut_id) REFERENCES socios (rut)
);
-- SE INSERTAN DATOS EN TABLA DATOS_PRESTAMOS
INSERT INTO  datos_prestamos (isbn_id, rut_id, fecha_prestamo, fecha_devolucion) VALUES
('111-1111111-111', '1111111-1', '20-01-2020', '27-01-2020');
INSERT INTO  datos_prestamos (isbn_id, rut_id, fecha_prestamo, fecha_devolucion) VALUES
('222-2222222-222', '5555555-5', '20-01-2020', '30-01-2020');
INSERT INTO  datos_prestamos (isbn_id, rut_id, fecha_prestamo, fecha_devolucion) VALUES
('333-3333333-333', '3333333-3', '22-01-2020', '30-01-2020');
INSERT INTO  datos_prestamos (isbn_id, rut_id, fecha_prestamo, fecha_devolucion) VALUES
('444-4444444-444', '4444444-4', '23-01-2020', '30-01-2020');
INSERT INTO  datos_prestamos (isbn_id, rut_id, fecha_prestamo, fecha_devolucion) VALUES
('111-1111111-111', '2222222-2', '27-01-2020', '04-02-2020');
INSERT INTO  datos_prestamos (isbn_id, rut_id, fecha_prestamo, fecha_devolucion) VALUES
('444-4444444-444', '1111111-1', '31-01-2020', '12-02-2020');
INSERT INTO  datos_prestamos (isbn_id, rut_id, fecha_prestamo, fecha_devolucion) VALUES
('222-2222222-222', '3333333-3', '31-01-2020', '12-02-2020');


-- CONSULTAS

-- Mostrar todos los libros que posean menos de 300 páginas. 
SELECT * FROM libros
WHERE numero_pag > 300;

--Mostrar todos los autores que hayan nacido después del 01-01-1970

SELECT * FROM autor 
WHERE year_nacimiento > 1970;

-- ¿Cuál es el libro más solicitado? 
SELECT isbn_id FROM datos_prestamos
GROUP BY isbn_id 
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM datos_prestamos GROUP BY isbn_id);

-- Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.
