/* Contar la cantidad de mensajes en funcion de un año especifico */
CREATE FUNCTION FNCountMessagesByYear(@year int) 
RETURNS TABLE
AS
RETURN(
    SELECT COUNT(Id_Mensaje) as MensajesTotales
  FROM Mensajes  
  Where YEAR(Fecha_Mensaje) = @year
)


Select * From dbo.FNCountMessagesByYear(2023)


/* Contar la cantidad de tecnicos disponibles en un determinado distrito */

CREATE VIEW VTotalTechniciesAvaible  AS
SELECT COUNT(Id_Tecnico) as TotalTecnicos, Disponibilidad_Tecnico, Id_Distrito_Tecnico 
FROM Tecnicos 
WHERE Disponibilidad_Tecnico = 'DISPONIBLE' 
GROUP BY Disponibilidad_Tecnico, Id_Distrito_Tecnico

GO
CREATE FUNCTION FNTenchiniciesByDistrict(@id int) 
RETURNS INT 
BEGIN 
   declare @TotalTechnicies int
   set @TotalTechnicies = ( SELECT TotalTecnicos 
   FROM VTotalTechniciesAvaible Where Id_Distrito_Tecnico = @id)
   RETURN @TotalTechnicies
END


/* Mostrar las salas iniciadas en un determinado año */
CREATE FUNCTION FNTotalSalasByYEAR (@year int)
RETURNS TABLE 
RETURN (
     SELECT * FROM Salas
     where Year(Fecha_Sala) = @year
)


/* Buscar el depertamento con mayor numero de tecnicos disponibles */
go
CREATE VIEW VTotalTechnicies AS 
SELECT  Departamento, Distrito, COUNT(id_tecnico) as TotalTecnicos 
FROM Departamentos as De 
JOIN Distritos as DI on DE.Id_Departamento = DI.Id_Departamento_Distrito 
JOIN Tecnicos as T on DI.Id_Distrito = T.Id_Distrito_Tecnico
GROUP BY  Departamento, Distrito

SELECT Departamento, Distrito  
FROM VTotalTechnicies 
WHERE TotalTecnicos = (SELECT MAX(TotalTecnicos) FROM  VTotalTechnicies)

/* Buscar el tecnico con el mayor numero de resenias */

go
CREATE VIEW VTotalReviewsByTechnicies AS
SELECT Count(id_ReseniaTecnico) as TotalResenias, Nombre_Tecnico, Estado_Tecnico, Departamento, Distrito 
FROM Departamentos as DE 
JOIN Distritos as DI on DE.Id_Departamento = DI.Id_Departamento_Distrito
JOIN Tecnicos as T on DI.Id_Distrito = T.Id_Distrito_Tecnico 
JOIN ReseniasTecnicos as RT on T.Id_Tecnico = RT.Id_Tecnico_ReseniaTecnico
GROUP BY  Nombre_Tecnico, Estado_Tecnico, Departamento, Distrito 

SELECT * FROM VTotalReviewsByTechnicies
WHERE TotalResenias = (SELECT MAX(TotalResenias) FROM VTotalReviewsByTechnicies)


/*  Contar todos los tecnicos disponibles por departamento */
go
CREATE VIEW VTotalTechniciesAvaibleByDepartment AS 
SELECT  
    Departamento, 
    Estado_Tecnico,  
    COUNT(id_tecnico) as TotalTecnicos 
FROM 
    Departamentos as DE 
    JOIN Distritos as DI on DE.Id_Departamento= DI.Id_Departamento_Distrito 
    JOIN Tecnicos as T on DI.Id_Distrito = T.Id_Distrito_Tecnico
WHERE 
    Estado_Tecnico = 'ACTIVO'
GROUP BY  
    Departamento, Estado_Tecnico

go
CREATE FUNCTION FNTechniciesByDepartment(@department varchar(50)) 
RETURNS TABLE 
RETURN (
    SELECT Departamento, TotalTecnicos 
    FROM VTotalTechniciesAvaibleByDepartment
    WHERE Departamento = @department
)

Select * from dbo.FNTechniciesByDepartment('LIMA')


/* Departamentos con el mayor numero de tecnicos activos */

SELECT Departamento FROM VTotalTechniciesAvaibleByDepartment 
where TotalTecnicos = (SELECT MAX(TotalTecnicos) FROM VTotalTechniciesAvaibleByDepartment )

/* Cantidad de miembros para una determinada sala */
go
CREATE VIEW VTotalMembers AS 
SELECT COUNT(Id_Tecnico) as TotalMembers, Id_sala 
FROM Tecnicos as T
JOIN MiembrosSalas as MS on T.Id_Tecnico = MS.Id_Tecnico_MiembroSala
JOIN Salas as S on MS.Id_Sala_MiembroSala = S.Id_Sala
GROUP BY Id_sala
go
CREATE FUNCTION FNTotalMembersByRoom(@sala int)
RETURNS TABLE
RETURN (
   SELECT TotalMembers 
   FROM VTotalMembers 
   WHERE Id_Sala = @sala

)


SELECT * FROM dbo.FNTotalMembersByRoom(5)


/* Sala con el menor numero de miembros */

SELECT * FROM VTotalMembers 
WHERE TotalMembers = (SELECT MIN(TotalMembers) FROM VTotalMembers)