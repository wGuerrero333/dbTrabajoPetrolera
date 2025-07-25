CREATE TABLE Departamentos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100)
);

INSERT INTO Departamentos (ID, Nombre) VALUES
(1, 'Exploration'),
(2, 'Production'),
(3, 'Transportation'),
(4, 'R&D'),
(5, 'Distribution'),
(6, 'QHSE');

------------------------

CREATE TABLE Ubicaciones (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100)
);

INSERT INTO Ubicaciones (ID, Nombre) VALUES
(11, 'Kingstown'),
(12, 'Georgetown'),
(13, 'Port of Spain'),
(14, 'Bridgetown');



-------------------------
CREATE TABLE Empleados (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombres VARCHAR(100),
    Apellidos VARCHAR(100),
    Telefono VARCHAR(20)
);

INSERT INTO Empleados (ID, Nombres, Apellidos, Telefono) VALUES
(27, 'Jaime', 'Doemi', '31234567890'),
(28, 'Janeth', 'Smith', '30987654321');

--------------------------------
CREATE TABLE GruposActivos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100)
);

INSERT into GruposActivos (ID, Nombre) VALUES
(1, 'Hydraulic'),
(3, 'Electrical'),
(4, 'Mechanical'),
(5, 'Pneumatic'),
(6, 'Instrumentation'),
(7, 'Safety'),
(8, 'IT');
-------------------------

CREATE TABLE UbicacionesDepartamentos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    DepartamentoID INT,
    UbicacionID INT,
    FechaInicio DATE,
    FechaFin DATE,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(ID),
    FOREIGN KEY (UbicacionID) REFERENCES Ubicaciones(ID)
);

INSERT INTO UbicacionesDepartamentos (ID, DepartamentoID, UbicacionID, FechaInicio, FechaFin) VALUES
(3, 5, 2, '1996-04-29', NULL),
(4, 5, 1, '2002-03-04', NULL),
(7, 4, 2, '2005-05-04', NULL),
(11, 1, 2, '2005-11-11', NULL),
(8, 8, 8, '2023-01-01', '2023-12-31'),
(9, 9, 9, '2023-01-01', '2023-12-31'),
(10, 10, 10, '2023-01-01', '2023-12-31');

------------------------------------

CREATE TABLE Activos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Serial VARCHAR(100),
    Nombre VARCHAR(100),
    UbicacionDepartamentoID INT,
    EmpleadoID INT,
    GrupoActivoID INT,
    Descripcion TEXT,
    FechaGarantia DATE,
    FOREIGN KEY (UbicacionDepartamentoID) REFERENCES UbicacionesDepartamentos(ID),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleados(ID),
    FOREIGN KEY (GrupoActivoID) REFERENCES GruposActivos(ID)
);



INSERT INTO Activos (ID, Serial, Nombre, UbicacionDepartamentoID, EmpleadoID, GrupoActivoID, Descripcion, FechaGarantia) VALUES
(1, '05/04/0001', 'Toyota Hilux FAF321', 3, 5, 4, '', NULL),
(2, '04/03/0001', 'Suction Line 852', 7, 8, 3, '', '2020-03-02'),
(3, '01/01/0001', 'ZENY 3.5CFM Single-Stage 5 Pa Rotary Vane', 11, 22, 1, '', '2018-01-17'),
(4, '05/04/0002', 'Volvo FH16', 4, 26, 4, '', NULL),
(5, '04/03/0002', 'Suction Line 853', 8, 30, 3, '', '2020-03-02'),
(6, '01/01/0002', 'ZENY 3.5CFM Single-Stage 89', 12, 33, 1, '', '2018-01-17'),
(7, '05/04/0003', 'Toyota Hilux FAF345', 5, 35, 4, '', NULL),
(8, '04/03/0003', 'Tucson Line 854', 9, 40, 3, '', '2020-03-02'),
(9, '01/01/0003', 'ZENY 3.5CFM Single-Stage 10', 13, 45, 1, '', '2018-01-17'),
(10, '05/04/0004', 'Volvo Trailer', 6, 50, 4, '', NULL);

--------------------------------------------
CREATE TABLE TransferenciasActivos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ActivoID INT,
    SerialOrigen VARCHAR(100),
    SerialDestino VARCHAR(100),
    UbicacionDepartamentoOrigenID INT,
    UbicacionDepartamentoDestinoID INT,
    FechaTransferencia DATE,
    FOREIGN KEY (ActivoID) REFERENCES Activos(ID),
    FOREIGN KEY (UbicacionDepartamentoOrigenID) REFERENCES UbicacionesDepartamentos(ID),
    FOREIGN KEY (UbicacionDepartamentoDestinoID) REFERENCES UbicacionesDepartamentos(ID)
);

INSERT INTO TransferenciasActivos (ID, ActivoID, SerialOrigen, SerialDestino, UbicacionDepartamentoOrigenID, UbicacionDepartamentoDestinoID, FechaTransferencia) VALUES
(1, 1, '05/04/0001', '05/04/0001', 3, 4, '2023-01-01'),
(2, 2, '04/03/0001', '04/03/0001', 7, 8, '2023-01-01'),
(3, 3, '01/01/0001', '01/01/0001', 11, 12, '2023-01-01'),
(4, 4, '05/04/0002', '05/04/0002', 4, 5, '2023-01-01'),
(5, 5, '04/03/0002', '04/03/0002', 8, 9, '2023-01-01'),
(6, 6, '01/01/0002', '01/01/0002', 12, 13, '2023-01-01'),
(7, 7, '05/04/0003', '05/04/0003', 5, 6, '2023-01-01'),
(8, 8, '04/03/0003', '04/03/0003', 9, 10, '2023-01-01');

---------------


-- DB CREADA SATISFACTORIAMENTE 
-- los problemas surgia al no poner los ID al hacer los INSERT INTO daba error 1452 en WORBENCH

 -- 1. Crear una consulta que permita obtener el catálogo de activos. Cada registro deberá tener los
-- campos Asset name, Department name, Asset SN.

SELECT Nombre, UbicacionDepartamentoID, Serial
FROM Activos;


-- 2.Crear una consulta que permita filtrar el catálogo de activos del punto anterior a partir de la
--búsqueda aproximada de una palabra clave del Asset name.

SELECT Nombre ,Serial, UbicacionDepartamentoID
FROM Activos WHERE Nombre LIKE '%Volvo FH16';

--3.Crear una consulta que permita filtrar el catálogo de activos del punto anterior a partir de la
--búsqueda exacta del Department name.

SELECT Nombre ,Serial, UbicacionDepartamentoID
FROM Activos WHERE UbicacionDepartamentoID LIKE '%11';

-- 4. Crear una consulta que devuelva como resultado el número de registros encontrados en el
-- catálogo de activos.

SELECT COUNT(*) FROM Activos;

--5 --El modelo está diseñado para permitir la transferencia de activos entre departamentos, crear un
-- conjunto de sentencias que ejemplifiquen cómo se registraría esta transacción en la base de datos
-- diseñada (debe usar la tabla AssetTransferLogs).
--"Se modica el serial dado que el UbicacionDepartamentoDestinoID es una FK no deja modificarse"

update TransferenciasActivos
SET UbicacionDepartamentoDestinoID = 'Nuevo ID' 
WHERE ID = 1;

--6 Crear una consulta que permita ver todo el catálogo de transferencias realizadas.

SELECT *
FROM TransferenciasActivos
order by FechaTransferencia;

--7. Crear una consulta para obtener el nombre del departamento desde el cual se han realizado más
--transferencias



--8. Obtener los datos del empleado que más activos tiene asignados.

SELECT *
FROM Activos
ORDER BY EmpleadoID desc
limit 1;


 
