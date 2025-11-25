CREATE DATABASE DB_GYM;
GO

USE DB_GYM;
GO

-- Crear tabla de entrenadores
CREATE TABLE Entrenador (
    Id_Entrenador INT PRIMARY KEY IDENTITY(1,1), 
    Nombre NVARCHAR(150) NOT NULL,
    Telefono VARCHAR(12), 
    Correo NVARCHAR(150) UNIQUE, 
    Especialidad NVARCHAR(100), 
    Fecha_Contratacion DATE DEFAULT GETDATE()
);
GO

-- Crear tabla de tipos de pagos
CREATE TABLE Pagos (
    Id_Pago INT PRIMARY KEY IDENTITY(1,1), 
    Tipo NVARCHAR(50) NOT NULL,
    Costo DECIMAL(10,2) NOT NULL, 
    Descripcion NVARCHAR(150) 
);
GO

-- Crear tabla de clases
CREATE TABLE Clases (
    Id_Clase INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Clase NVARCHAR(100) NOT NULL,
    Dia_Semana NVARCHAR(15) NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Id_Entrenador INT NOT NULL FOREIGN KEY REFERENCES Entrenador(Id_Entrenador), 
    Cupo INT CHECK (Cupo > 0)
);
GO

-- Crear tabla de socios
CREATE TABLE Socios (
    Id_Socio INT PRIMARY KEY IDENTITY(1,1), 
    Nombre NVARCHAR(200) NOT NULL, 
    Telefono VARCHAR(12),
    Correo NVARCHAR(150) UNIQUE, 
    Direccion NVARCHAR(250),
    Alergia NVARCHAR(100),
    Enfermedad NVARCHAR(150), 
    Fecha_Registro DATE DEFAULT GETDATE(),
    Id_Pago INT FOREIGN KEY REFERENCES Pagos(Id_Pago),
    Estado NVARCHAR(20) DEFAULT 'Activo' CHECK (Estado IN ('Activo', 'Inactivo', 'Suspendido')),
    Fecha_Ultimo_Pago DATE
);
GO

-- Crear tabla de asistencias
CREATE TABLE Asistencias (
    Id_Asistencia INT PRIMARY KEY IDENTITY(1,1),
    Id_Clase INT NOT NULL FOREIGN KEY REFERENCES Clases(Id_Clase),
    Fecha_Asistencia DATE DEFAULT GETDATE(),
    Estado NVARCHAR(20) CHECK (Estado IN ('Presente', 'Ausente')),
    CONSTRAINT CHK_Fecha_Asistencia CHECK (Fecha_Asistencia <= CAST(GETDATE() AS DATE))
);
GO

-- Crear tabla para relacion muchos a muchos entre socios y asistencias
CREATE TABLE SocioxAsistencia(
    Id_Socio INT NOT NULL,
    Id_Asistencia INT NOT NULL,
    CONSTRAINT PK_SocioAsistencia PRIMARY KEY (Id_Socio, Id_Asistencia),
    CONSTRAINT FK_Socio FOREIGN KEY (Id_Socio) REFERENCES Socios(Id_Socio),
    CONSTRAINT FK_Asistencia FOREIGN KEY (Id_Asistencia) REFERENCES Asistencias(Id_Asistencia)
);
GO

-- Insertar entrenadores de ejemplo
INSERT INTO Entrenador (Nombre, Telefono, Correo, Especialidad, Fecha_Contratacion) VALUES
('Jorge Castillo', '+50371239876', 'jorge.castillo@gym.com', 'Calistenia', '2019-02-20'),
('Fernanda Ramos', '+50378905432', 'fernanda.ramos@gym.com', 'Zumba', '2021-11-05'),
('Lucia Hernandez', '+50378451289', 'lucia.hernandez@gym.com', 'Yoga', '2020-07-25'),
('Miguel Campos', '+50370345892', 'miguel.campos@gym.com', 'Boxeo', '2018-09-01'),
('Valeria Garcia', '+50378123490', 'valeria.garcia@gym.com', 'Pilates', '2021-12-19');
GO

-- Insertar tipos de pagos
INSERT INTO Pagos (Tipo, Costo, Descripcion) VALUES
('Diario', 3.00, 'Acceso al gimnasio por 1 dia'),
('Mensual', 25.00, 'Acceso completo por 30 dias');
GO

-- Insertar clases 
INSERT INTO Clases (Nombre_Clase, Dia_Semana, Hora_Inicio, Cupo, Id_Entrenador) VALUES
('Yoga', 'Lunes', '07:00', 20, 3),
('Calistenia', 'Martes', '18:00', 15, 2),
('Zumba', 'Miercoles', '17:30', 25, 4),
('Boxeo', 'Jueves', '18:30', 10, 5),
('Pilates', 'Viernes', '17:00', 18, 1);
GO

-- Insertar socios 
INSERT INTO Socios (Nombre, Telefono, Correo, Direccion, Alergia, Enfermedad, Fecha_Registro, Id_Pago)
VALUES
('Carlos','73610000','carlos@mail.com','Calle Los Pinos #766','Lacteos','Diabetes','2024-01-24',1),
('Maria','78650001','maria@mail.com','Calle Primavera #547','Gluten','Migrana','2024-07-20',2),
('Luis','71760002','luis@mail.com','Boulevard San Juan #55','Polen','Artritis','2024-03-11',1),
('Ana','72740003','ana@mail.com','Av. America #222','Polvo','Asma','2024-08-28',2),
('Jose','76480004','jose@mail.com','Calle Luna #451','Lacteos','Diabetes','2024-10-17',1),
('Lucia','72390005','lucia@mail.com','Av. Reforma #978','Nueces','Hipertension','2024-12-27',2),
('Miguel','75660006','miguel@mail.com','Calle Central #298','Gluten','Migrana','2024-04-13',1),
('Carmen','72240007','carmen@mail.com','Av. America #960','Polvo','Artritis','2024-06-21',2),
('Juan','79600008','juan@mail.com','Av. Libertad #74','Polen','Asma','2024-05-14',1),
('Sofia','78590009','sofia@mail.com','Calle El Sol #436','Lacteos','Hipertension','2024-11-05',2),
('Andres','78220010','andres@mail.com','Calle Los Pinos #314','Nueces','Asma','2024-09-29',1),
('Paula','70820011','paula@mail.com','Av. Las Flores #837','Polen','Migrana','2024-02-10',2),
('Diego','74240012','diego@mail.com','Calle Primavera #376','Polvo','Diabetes','2024-06-17',1),
('Laura','72350013','laura@mail.com','Calle Central #18','Gluten','Asma','2024-07-15',2),
('Jorge','78970014','jorge@mail.com','Av. Libertad #643','Nueces','Migrana','2024-12-19',1),
('Elena','77280015','elena@mail.com','Av. America #200','Lacteos','Artritis','2024-08-25',2),
('Pedro','77950016','pedro@mail.com','Calle El Sol #17','Polen','Hipertension','2024-06-09',1),
('Valeria','76960017','valeria@mail.com','Calle Los Pinos #148','Polvo','Diabetes','2024-11-22',2),
('Ricardo','74210018','ricardo@mail.com','Boulevard San Juan #72','Nueces','Migrana','2024-11-09',1),
('Isabel','78310019','isabel@mail.com','Calle Primavera #588','Gluten','Diabetes','2024-12-06',2),
('Manuel','70560020','manuel@mail.com','Av. Reforma #989','Polen','Artritis','2024-09-27',1),
('Gabriela','73100021','gabriela@mail.com','Av. Libertad #604','Polvo','Migrana','2024-07-01',2),
('Hector','78680022','hector@mail.com','Calle Los Pinos #24','Lacteos','Asma','2024-08-09',1),
('Adriana','73450023','adriana@mail.com','Calle Primavera #755','Polen','Hipertension','2024-05-03',2),
('Rafael','75100024','rafael@mail.com','Calle Luna #313','Polvo','Diabetes','2024-10-22',1),
('Diana','79990025','diana@mail.com','Calle Central #551','Gluten','Migrana','2024-06-28',2),
('Fernando','73250026','fernando@mail.com','Av. Las Flores #875','Nueces','Artritis','2024-04-30',1),
('Marta','75940027','marta@mail.com','Av. America #283','Lacteos','Asma','2024-11-11',2),
('Raul','76050028','raul@mail.com','Calle El Sol #260','Gluten','Migrana','2024-01-21',1),
('Patricia','70520029','patricia@mail.com','Calle Luna #879','Polvo','Hipertension','2024-03-01',2);
GO

-- Insertar asistencias 
INSERT INTO Asistencias (Id_Clase, Fecha_Asistencia, Estado)
VALUES
-- Diciembre 2024 
( 1, '2024-12-01', 'Presente'),   
( 3, '2024-12-02', 'Ausente'),    
( 2, '2024-12-04', 'Presente'),   
( 5, '2024-12-05', 'Presente'),   
( 1, '2024-12-06', 'Ausente'),    
( 4, '2024-12-07', 'Presente'),   
( 4, '2024-12-08', 'Ausente'),    
( 5, '2024-12-10', 'Presente'),   
( 2, '2024-12-11', 'Presente'),  
( 3, '2024-12-12', 'Ausente'),   

-- Enero 2025
( 3, '2025-01-05', 'Presente'),   
( 1, '2025-01-07', 'Ausente'),    
( 2, '2025-01-09', 'Presente'),  
( 5, '2025-01-10', 'Presente'),  
( 4, '2025-01-11', 'Ausente'),  
( 1, '2025-01-12', 'Presente'),  
( 4, '2025-01-13', 'Ausente'),   
( 3, '2025-01-14', 'Presente'),   
( 2, '2025-01-16', 'Presente'),   
( 5, '2025-01-18', 'Ausente'),    

-- Febrero 2025
( 1, '2025-02-02', 'Presente'),  
( 3, '2025-02-03', 'Presente'),  
( 4, '2025-02-04', 'Ausente'),   
( 2, '2025-02-05', 'Presente'),  
( 5, '2025-02-06', 'Presente'),   
( 2, '2025-02-07', 'Ausente'),    
( 3, '2025-02-08', 'Presente'),   
( 4, '2025-02-09', 'Ausente'),    
( 5, '2025-02-10', 'Presente'),   
( 1, '2025-02-11', 'Presente');   
GO

-- Insertar relaciones socios-asistencias
INSERT INTO SocioxAsistencia (Id_Socio, Id_Asistencia) VALUES
(2, 3),
(7, 12),
(13, 8),
(19, 17),
(22, 24),
(3, 6),
(11, 19),
(24, 13),
(8, 22),
(17, 7),
(6, 11),
(14, 28),
(27, 14),
(9, 26),
(23, 9),
(12, 23),
(18, 16),
(26, 18),
(4, 29),
(28, 4),
(16, 27),
(29, 2),
(1, 21),
(21, 1),
(2, 14),
(7, 8),
(13, 19),
(19, 3),
(22, 12),
(3, 24),
(11, 7),
(24, 17),
(8, 11),
(17, 22),
(6, 28),
(14, 6),
(27, 13),
(9, 9),
(23, 26),
(12, 16),
(18, 18),
(26, 23),
(4, 4),
(28, 29),
(16, 2),
(29, 21),
(1, 1),
(21, 14),
(2, 8),
(7, 19);
GO

--Creando login de Estudiante y profesor
USE master;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'Estudiante')
BEGIN
	CREATE login Estudiante 
	WITH PASSWORD = 'UCA@2025',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION =ON;	
END
ELSE
	PRINT 'Ya existe el login Estudiante';
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'Profesor')
BEGIN
    CREATE login Profesor
	WITH PASSWORD = 'UCA@2025',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION =ON;	
END
ELSE
    PRINT 'Ya existe el login Profesor';
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'AdmiPowerBI')
BEGIN
    CREATE login AdmiPowerBI 
	WITH PASSWORD = 'UCA@2025',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION =ON;	
END
ELSE
    PRINT 'Ya existe el login AdminPowerBI';
GO

-- Creacion de usuarios
USE DB_GYM;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'Estudiante')
BEGIN
    CREATE USER Estudiante FOR LOGIN Estudiante;
END
ELSE
    PRINT 'Ya existe el usuario "Estudiante" en DB_GYM';
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'Profesor')
BEGIN
    CREATE USER Profesor FOR LOGIN Profesor;
END
ELSE
    PRINT 'Ya existe el usuario "Profesor" en DB_GYM';
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'AdmiPowerBI')
BEGIN
    CREATE USER AdmiPowerBI FOR LOGIN AdmiPowerBI;
END
ELSE
    PRINT 'Ya existe el usuario "AdmiPowerBI" en DB_GYM';
GO

-- creacion de roles para los usuarios
-- Rol para estudiante
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'student')
BEGIN
    PRINT 'Creando ROLE ...';
    CREATE ROLE student;
END
ELSE
    PRINT 'Ya existe el rol "estudiante" en DB_GYM';
GO

--Rol para profesor (Solo Lectura)
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'Profesor')
BEGIN
    PRINT 'Creando ROLE ...';
    CREATE ROLE Profesor;
END
ELSE
    PRINT 'Ya existe el rol "Profesor" en DB_GYM';
GO

--Rol para PowerBI (Solo Lectura)
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'DataAdmin')
BEGIN
    PRINT 'Creando ROLE ...';
    CREATE ROLE DataAdmin;
END
ELSE
    PRINT 'Ya existe el rol "DataAdmin" en DB_GYM';
GO

--Asignacion de permisos a los roles 
ALTER ROLE student ADD MEMBER Estudiante;
ALTER ROLE profesor ADD MEMBER Profesor;
ALTER ROLE DataAdmin ADD MEMBER AdmiPowerBI;
GO

-- Otorgar permisos
GRANT SELECT ON SCHEMA::dbo TO profesor;
GRANT SELECT ON Clases TO student;
GRANT SELECT ON ALL TABLES TO DataAdmin;
GO

-- Creacion de indices
CREATE NONCLUSTERED INDEX IX_Asistencias_Fecha 
ON Asistencias(Fecha_Asistencia);

CREATE NONCLUSTERED INDEX IX_Socios_Correo 
ON Socios(Correo);

CREATE NONCLUSTERED INDEX IX_Clases_Dia_Hora 
ON Clases(Dia_Semana, Hora_Inicio);
GO

-- Estrategia de respaldo
BACKUP DATABASE DB_GYM 
TO DISK = 'C:\Backups\DB_GYM_Full.bak'
WITH FORMAT, INIT, NAME = 'Respaldo Completo DB_GYM';
GO

-- CONSULTAS
-- Ver socios por tipo de pago y total por metodo
SELECT
    s.Nombre,
    s.Telefono,
    p.Tipo AS Metodo_Pago,
    p.Costo,
    COUNT(*) OVER (PARTITION BY p.Tipo) AS Total_Socios
FROM Socios s 
INNER JOIN Pagos p ON s.Id_Pago = p.Id_Pago
ORDER BY p.Tipo, s.Nombre;

-- Ver socios con mayor riesgo de cancelar sus pagos (por ausencias)
SELECT
    s.Nombre,
    s.Telefono,
    p.Tipo AS Metodo_Pago,
    COUNT(CASE WHEN a.Estado = 'Ausente' THEN 1 END) AS Total_Ausencias,
    DENSE_RANK() OVER (
        PARTITION BY p.Tipo 
        ORDER BY COUNT(CASE WHEN a.Estado = 'Ausente' THEN 1 END) DESC
    ) AS Ranking_Riesgo
FROM Socios s 
INNER JOIN Pagos p ON s.Id_Pago = p.Id_Pago
INNER JOIN SocioxAsistencia sa ON s.Id_Socio = sa.Id_Socio
INNER JOIN Asistencias a ON a.Id_Asistencia = sa.Id_Asistencia
GROUP BY s.Id_Socio, s.Nombre, s.Telefono, p.Tipo
ORDER BY Total_Ausencias DESC;

-- Ver cantidad de socios por clase y cupos disponibles
SELECT 
    C.Nombre_Clase,
    C.Dia_Semana,
    C.Hora_Inicio,
    E.Nombre AS Entrenador,
    COUNT(SA.Id_Socio) OVER (PARTITION BY C.Id_Clase) AS Cupos_ocupados,
    C.Cupo,
    C.Cupo - COUNT(SA.Id_Socio) OVER (PARTITION BY C.Id_Clase) AS Cupos_Disponibles
FROM Clases C
INNER JOIN Entrenador E ON C.Id_Entrenador = E.Id_Entrenador
LEFT JOIN Asistencias A ON C.Id_Clase = A.Id_Clase
LEFT JOIN SocioxAsistencia SA ON A.Id_Asistencia = SA.Id_Asistencia
WHERE A.Estado = 'Presente' OR A.Estado IS NULL
ORDER BY C.Nombre_Clase, C.Dia_Semana;

-- Ver con que entrenador ha ido cada socio mas veces
SELECT 
    E.Nombre AS Entrenador,
    S.Nombre AS Socio,
    C.Nombre_Clase,
    COUNT(*) OVER (PARTITION BY E.Id_Entrenador, S.Id_Socio) AS Clases_Juntos,
    ROW_NUMBER() OVER (PARTITION BY S.Id_Socio ORDER BY COUNT(A.Id_Asistencia) DESC) AS Ranking_Entrenador
FROM Socios S
INNER JOIN SocioxAsistencia SA ON S.Id_Socio = SA.Id_Socio
INNER JOIN Asistencias A ON SA.Id_Asistencia = A.Id_Asistencia
INNER JOIN Clases C ON A.Id_Clase = C.Id_Clase
INNER JOIN Entrenador E ON C.Id_Entrenador = E.Id_Entrenador
WHERE A.Estado = 'Presente'
GROUP BY E.Nombre, S.Nombre, C.Nombre_Clase, E.Id_Entrenador, S.Id_Socio
ORDER BY S.Nombre, Ranking_Entrenador;

-- Ver socios que nunca han faltado
SELECT 
    s.Id_Socio,
    s.Nombre,
    COUNT(a.Id_Asistencia) AS Total_Asistencias,
    COUNT(CASE WHEN a.Estado = 'Ausente' THEN 1 END) AS Total_Ausencias
FROM Socios s
LEFT JOIN SocioxAsistencia sa ON s.Id_Socio = sa.Id_Socio
LEFT JOIN Asistencias a ON sa.Id_Asistencia = a.Id_Asistencia
GROUP BY s.Id_Socio, s.Nombre
HAVING COUNT(CASE WHEN a.Estado = 'Ausente' THEN 1 END) = 0
      AND COUNT(a.Id_Asistencia) > 0  
ORDER BY s.Nombre;

-- Ver porcentaje de asistencia de cada socio
SELECT 
    s.Nombre,
    COUNT(a.Id_Asistencia) AS Total_Clases,
    COUNT(CASE WHEN a.Estado='Presente' THEN 1 END) AS Asistencias,
    COUNT(CASE WHEN a.Estado='Ausente' THEN 1 END) AS Ausencias,
    CAST(
        (CAST(COUNT(CASE WHEN a.Estado='Presente' THEN 1 END) AS FLOAT) /
         NULLIF(COUNT(a.Id_Asistencia),0)) * 100
        AS DECIMAL(5,2)
    ) AS Porcentaje_Asistencia
FROM Socios s
LEFT JOIN SocioxAsistencia sa ON s.Id_Socio = sa.Id_Socio
LEFT JOIN Asistencias a ON sa.Id_Asistencia = a.Id_Asistencia
GROUP BY s.Nombre
ORDER BY Porcentaje_Asistencia DESC;