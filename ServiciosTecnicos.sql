USE ServiciosTecnicos
GO

-- AREA ADMINISTRADORES --

CREATE TABLE Administradores
(
Id_Administrador int,
Codigo_Administrador varchar(MAX)

CONSTRAINT PK_Id_Administrador PRIMARY KEY (Id_Administrador)
)
GO

-- AREA CONSUMIDORES --

CREATE TABLE Consumidores
(
Id_Consumidor int,
Perfil_Consumidor varchar(MAX),
Nombre_Consumidor varchar(100),
Apellido_Consumidor varchar(100),
Edad_Consumidor int,
Genero_Consumidor varchar(20),
Contacto_Consumidor int,
Correo_Consumidor varchar(100),
Estado_Consumidor varchar(20)

CONSTRAINT PK_Id_Consumidor PRIMARY KEY (Id_Consumidor)
)
GO
CREATE TABLE CodigosConsumidores
(
Id_Consumidor_CodigoConsumidor int,
CodigoConsumidor varchar(MAX)

CONSTRAINT PK_Id_Consumidor_CodigoConsumidor PRIMARY KEY (Id_Consumidor_CodigoConsumidor),

CONSTRAINT FK_Id_Consumidor_CodigoConsumidor FOREIGN KEY (Id_Consumidor_CodigoConsumidor)
REFERENCES Consumidores(Id_Consumidor)
)
GO
CREATE TABLE TiposDenunciasConsumidores
(
Id_TipoDenunciaConsumidor int identity(1,1),
TipoDenunciaConsumidor varchar(100)

CONSTRAINT PK_Id_TipoDenunciaConsumidor PRIMARY KEY (Id_TipoDenunciaConsumidor)
)
GO
CREATE TABLE DenunciasConsumidores
(
Id_DenunciaConsumidor int identity (1,1),
Id_DetalleAgenda_DenunciaConsumidor int,
Id_TipoDenunciaConsumidor_DenunciaConsumidor int,
Fecha_DenunciaConsumidor DateTime,
Descripcion_DenunciaConsumidor varchar(MAX),
Estado_DenunciaConsumidor varchar(20)

CONSTRAINT PK_Id_DenunciaConsumidor PRIMARY KEY (Id_DenunciaConsumidor),

CONSTRAINT FK_Id_DetalleAgenda_DenunciaConsumidor FOREIGN KEY (Id_DetalleAgenda_DenunciaConsumidor)
REFERENCES DetallesAgendas(Id_DetalleAgenda),

CONSTRAINT FK_Id_TipoDenunciaConsumidor_DenunciaConsumidor FOREIGN KEY (Id_TipoDenunciaConsumidor_DenunciaConsumidor)
REFERENCES TiposDenunciasConsumidores(Id_TipoDenunciaConsumidor)
)
GO
CREATE TABLE ReseniasTecnicos
(
Id_ReseniaTecnico int identity (1,1),
Id_Consumidor_ReseniaTecnico int,
Id_Tecnico_ReseniaTecnico int,
Fecha_ReseniaTecnico DateTime,
Puntaje_ReseniaTecnico int,
ReseniaTecnico varchar(MAX)

CONSTRAINT PK_Id_ReseniaTecnico PRIMARY KEY (Id_ReseniaTecnico),

CONSTRAINT FK_Id_Consumidor_ReseniaTecnico FOREIGN KEY (Id_Consumidor_ReseniaTecnico)
REFERENCES Consumidores(Id_Consumidor),

CONSTRAINT FK_Id_Tecnico_ReseniaTecnico FOREIGN KEY (Id_Tecnico_ReseniaTecnico)
REFERENCES Tecnicos(Id_Tecnico)
)
GO

-- AREA TECNICOS --

CREATE TABLE TiposMonedas
(
Id_TipoMoneda int identity(1,1),
TipoMoneda varchar(20)

CONSTRAINT PK_Id_TipoMoneda PRIMARY KEY (Id_TipoMoneda)
)
GO
CREATE TABLE Membresias
(
Id_Membresia int identity(1,1),
Id_TipoMoneda_Membresia int,
Nombre_Membresia varchar(50),
Precio_Membresia float,
Descripcion_Membresia varchar(MAX)

CONSTRAINT PK_Id_Membresia PRIMARY KEY (Id_Membresia),

CONSTRAINT FK_Id_TipoMoneda_Membresia FOREIGN KEY (Id_TipoMoneda_Membresia)
REFERENCES TiposMonedas(Id_TipoMoneda)
)
GO
CREATE TABLE ContratosTecnicos
(
Id_ContratoTecnico int identity(1,1),
Id_Tecnico_ContratoTecnico int,
Id_Membresia_ContratoTecnico int,
FechaInicio_ContratoTecnico DateTime,
FechaFin_ContratoTecnico DateTime,
Estado_ContratoTecnico varchar(20)

CONSTRAINT PK_Id_ContratoTecnico PRIMARY KEY (Id_ContratoTecnico),

CONSTRAINT FK_Id_Tecnico_ContratoTecnico FOREIGN KEY (Id_Tecnico_ContratoTecnico)
REFERENCES Tecnicos(Id_Tecnico),

CONSTRAINT FK_Id_Membresia_ContratoTecnico FOREIGN KEY (Id_Membresia_ContratoTecnico)
REFERENCES Membresias(Id_Membresia)
)
GO
CREATE TABLE Departamentos
(
Id_Departamento int identity(1,1),
Departamento varchar(50)

CONSTRAINT PK_Id_Departamento PRIMARY KEY (Id_Departamento)
)
GO
CREATE TABLE Distritos
(
Id_Distrito int identity(1,1),
Id_Departamento_Distrito int,
Distrito varchar(50)

CONSTRAINT PK_Id_Distrito PRIMARY KEY (Id_Distrito),

CONSTRAINT FK_Id_Departamento_Distrito FOREIGN KEY (Id_Departamento_Distrito)
REFERENCES Departamentos(Id_Departamento)
)
GO
CREATE TABLE Especialidades
(
Id_Especialidad int identity(1,1),
Especialidad varchar(100)

CONSTRAINT PK_Id_Especialidad PRIMARY KEY (Id_Especialidad)
)
GO
CREATE TABLE Tecnicos
(
Id_Tecnico int,
Id_Distrito_Tecnico int,
Id_Especialidad_Tecnico int,
Perfil_Tecnico varchar(MAX),
Nombre_Tecnico varchar(100),
Apellido_Tecnico varchar(100),
Edad_Tecnico int,
Genero_Tecnico varchar(20),
Contacto_Tecnico int,
Correo_Tecnico varchar(100),
Disponibilidad_Tecnico varchar(20),
Estado_Tecnico varchar(20)

CONSTRAINT PK_Id_Tecnico PRIMARY KEY (Id_Tecnico),

CONSTRAINT FK_Id_Distrito_Tecnico FOREIGN KEY (Id_Distrito_Tecnico)
REFERENCES Distritos(Id_Distrito),

CONSTRAINT FK_Id_Especialidad_Tecnico FOREIGN KEY (Id_Especialidad_Tecnico)
REFERENCES Especialidades(Id_Especialidad)
)
GO
CREATE TABLE CodigosTecnicos
(
Id_Tecnico_CodigoTecnico int,
CodigoTecnico nvarchar(MAX)

CONSTRAINT PK_Id_Tecnico_CodigoTecnico PRIMARY KEY (Id_Tecnico_CodigoTecnico),

CONSTRAINT FK_Id_Tecnico_CodigoTecnico FOREIGN KEY (Id_Tecnico_CodigoTecnico)
REFERENCES Tecnicos(Id_Tecnico)
)
GO
CREATE TABLE TiposDenunciasTecnicos
(
Id_TipoDenunciaTecnico int identity(1,1),
TipoDenunciaTecnico varchar(100)

CONSTRAINT PK_Id_TipoDenunciaTecnico PRIMARY KEY (Id_TipoDenunciaTecnico)
)
GO
CREATE TABLE DenunciasTecnicos
(
Id_DenunciaTecnico int identity (1,1),
Id_DetalleAgenda_DenunciaTecnico int,
Id_TipoDenunciaTecnico_DenunciaTecnico int,
Fecha_DenunciaTecnico DateTime,
Descripcion_DenunciaTecnico varchar(MAX),
Estado_DenunciaTecnico varchar(20)

CONSTRAINT PK_Id_DenunciaTecnico PRIMARY KEY (Id_DenunciaTecnico),

CONSTRAINT FK_Id_DetalleAgenda_DenunciaTecnico FOREIGN KEY (Id_DetalleAgenda_DenunciaTecnico)
REFERENCES DetallesAgendas(Id_DetalleAgenda),

CONSTRAINT FK_Id_TipoDenunciaTecnico_DenunciaTecnico FOREIGN KEY (Id_TipoDenunciaTecnico_DenunciaTecnico)
REFERENCES TiposDenunciasTecnicos(Id_TipoDenunciaTecnico)
)
GO
CREATE TABLE DatosAgendas
(
Id_DatoAgenda int identity (1,1),
Id_Tecnico_DatoAgenda int,
FechaCreacion_DatoAgenda DateTime

CONSTRAINT PK_Id_DatoAgenda PRIMARY KEY (Id_DatoAgenda),

CONSTRAINT FK_Id_Tecnico_DatoAgenda FOREIGN KEY (Id_Tecnico_DatoAgenda)
REFERENCES Tecnicos(Id_Tecnico)
)
GO
CREATE TABLE DetallesAgendas
(
Id_DetalleAgenda int identity(1,1),
Id_DatoAgenda_DetalleAgenda int,
Id_Consumidor_DetalleAgenda int,
FechaTrabajo_DetalleAgenda DateTime,
Direccion_DetalleAgenda varchar(MAX),
DescripcionTrabajo_DetalleAgenda varchar(MAX),
TiempoTrabajo_DetalleAgenda int,
PresupuestoManoDeObra_DetalleAgenda float,
PresupuestoMaterial_DetalleAgenda float,
MontoFinal_DetalleAgenda float,
Estado_DetalleAgenda varchar(20)

CONSTRAINT PK_Id_DetalleAgenda PRIMARY KEY (Id_DetalleAgenda),

CONSTRAINT FK_Id_DatoAgenda_DetalleAgenda FOREIGN KEY (Id_DatoAgenda_DetalleAgenda)
REFERENCES DatosAgendas(Id_DatoAgenda),

CONSTRAINT FK_Id_Consumidor_DetalleAgenda FOREIGN KEY (Id_Consumidor_DetalleAgenda)
REFERENCES Consumidores(Id_Consumidor)
)
GO
CREATE TABLE AntecedentesTecnicos
(
Id_AntecedenteTecnico int identity (1,1),
Id_Tecnico_AntecedenteTecnico int,
DNI_AntecedenteTecnico varchar(MAX),
AntecedenteTecnico varchar(MAX)

CONSTRAINT PK_Id_AntecedenteTecnico PRIMARY KEY (Id_AntecedenteTecnico),

CONSTRAINT FK_Id_Tecnico_AntecedenteTecnico FOREIGN KEY (Id_Tecnico_AntecedenteTecnico)
REFERENCES Tecnicos(Id_Tecnico)
)
GO

-- AREA COMUNICACION --

CREATE TABLE MiembrosSalas
(
Id_Sala_MiembroSala int,
Id_Tecnico_MiembroSala int,
Id_Consumidor_MiembroSala int,

CONSTRAINT FK_Id_Sala_MiembroSala FOREIGN KEY (Id_Sala_MiembroSala)
REFERENCES Salas(Id_Sala),

CONSTRAINT FK_Id_Tecnico_MiembroSala FOREIGN KEY(Id_Tecnico_MiembroSala)
REFERENCES Tecnicos(Id_Tecnico),

CONSTRAINT FK_Id_Consumidor_MiembroSala FOREIGN KEY(Id_Consumidor_MiembroSala)
REFERENCES Consumidores(Id_Consumidor)
)
GO
CREATE TABLE Salas
(
Id_Sala int identity(1,1),
Fecha_Sala DateTime

CONSTRAINT PK_Id_Sala PRIMARY KEY(Id_Sala)
)
GO
CREATE TABLE Mensajes
(
Id_Mensaje int identity(1,1),
Id_Sala_Mensaje int,
Id_Tecnico_Mensaje int,
Id_Consumidor_Mensaje int,
Fecha_Mensaje DateTime,
Mensaje varchar(MAX),
Contenido varchar(MAX)

CONSTRAINT PK_Id_Mensaje PRIMARY KEY(Id_Mensaje),

CONSTRAINT FK_Id_Sala_Mensaje FOREIGN KEY(Id_Sala_Mensaje)
REFERENCES Salas(Id_Sala),

CONSTRAINT FK_Id_Tecnico_Mensaje FOREIGN KEY(Id_Tecnico_Mensaje)
REFERENCES Tecnicos(Id_Tecnico),

CONSTRAINT FK_Id_Consumidor_Mensaje FOREIGN KEY(Id_Consumidor_Mensaje)
REFERENCES Consumidores(Id_Consumidor)
)
GO

-- PROCEDIMIENTOS ALMACENADOS WEB - INICIO --

-- ESTE --
CREATE PROCEDURE SP_IniciarSesion
(
@Id int
)
AS
BEGIN

	IF ((SELECT COUNT(*) FROM CodigosConsumidores WHERE Id_Consumidor_CodigoConsumidor = @Id AND
		(SELECT Estado_Consumidor FROM Consumidores WHERE Id_Consumidor = @Id) = 'ACTIVO') = 1)
	BEGIN
	
		SELECT SUBSTRING(CodigoConsumidor, 1, 24) AS Sal, SUBSTRING(CodigoConsumidor, 25, 48) AS Codigo, 'CONSUMIDOR' AS Rol
		FROM CodigosConsumidores WHERE Id_Consumidor_CodigoConsumidor = @Id
	
	END
	ELSE IF ((SELECT COUNT(*) FROM CodigosTecnicos WHERE Id_Tecnico_CodigoTecnico = @Id AND
			 (SELECT Estado_Tecnico FROM Tecnicos WHERE Id_Tecnico = @Id) = 'ACTIVO') = 1)
	BEGIN
	
		SELECT SUBSTRING(CodigoTecnico, 1, 24) AS Sal, SUBSTRING(CodigoTecnico, 25, 48) AS Codigo, 'TECNICO' AS Rol
		FROM CodigosTecnicos WHERE Id_Tecnico_CodigoTecnico = @Id
	
	END
	ELSE IF ((SELECT COUNT(*) FROM Administradores WHERE Id_Administrador = @Id) = 1)
	BEGIN
	
		SELECT SUBSTRING(Codigo_Administrador, 1, 24) AS Sal, SUBSTRING(Codigo_Administrador, 25, 48) AS Codigo, 'ADMINISTRADOR' AS ROL
		FROM Administradores WHERE Id_Administrador = @Id
	
	END
	ELSE
	BEGIN
	
		SELECT '' AS Sal, '' AS Codigo, '' AS Rol
	
	END
END
GO

-- PROCEDIMIENTOS ALMACENADOS WEB - TECNICOS --

CREATE PROCEDURE SP_InsertarDatos_Tecnicos
(
@Id_Tecnico int,
@Perfil_Tecnico varchar(MAX),
@Nombre_Tecnico varchar(100),
@Apellido_Tecnico varchar(100),
@Edad_Tecnico int,
@Genero_Tecnico varchar(20),
@Contacto_Tecnico int,
@Correo_Tecnico varchar(100),
@CodigoTecnico varchar(MAX),
@Departamento varchar(50),
@Distrito varchar(50),
@Especialidad varchar(100),
@DNI_AntecedenteTecnico varchar(MAX),
@AntecedenteTecnico varchar(MAX)
)
AS
BEGIN

	IF (((SELECT COUNT(*) FROM Distritos WHERE Distrito LIKE @Distrito + '%'
	     AND Id_Departamento_Distrito = (SELECT Id_Departamento FROM Departamentos WHERE Departamento LIKE @Departamento + '%')) = 1)
		 AND ((SELECT COUNT(*) FROM Especialidades WHERE Especialidad = @Especialidad) = 1))
	BEGIN
	
		DECLARE @Id_Distrito_Tecnico int = (SELECT Id_Distrito FROM Distritos WHERE Distrito LIKE @Distrito + '%'
											AND Id_Departamento_Distrito = (SELECT Id_Departamento FROM Departamentos
																			WHERE Departamento LIKE @Departamento + '%'))
	
		DECLARE @Id_Especialidad_Tecnico int = (SELECT Id_Especialidad FROM Especialidades WHERE
		                                        Especialidad = @Especialidad)
	
		INSERT INTO Tecnicos VALUES (@Id_Tecnico, @Id_Distrito_Tecnico, @Id_Especialidad_Tecnico,
		                             @Perfil_Tecnico, @Nombre_Tecnico, @Apellido_Tecnico, @Edad_Tecnico,
									 @Genero_Tecnico, @Contacto_Tecnico, @Correo_Tecnico, 'DISPONIBLE', 'ACTIVO')
	
		INSERT INTO CodigosTecnicos VALUES (@Id_Tecnico, @CodigoTecnico)
	
		INSERT INTO AntecedentesTecnicos VALUES (@Id_Tecnico, @DNI_AntecedenteTecnico, @AntecedenteTecnico)
	
	END
END
GO
CREATE PROCEDURE SP_MostrarDatos_Especialidades
AS
BEGIN

	SELECT Especialidad FROM Especialidades

END
GO

-- ESTE --
CREATE PROCEDURE SP_MostrarInformacionGeneral_Tecnicos
(
@Id_Tecnico_DatoAgenda int
)
AS
BEGIN

	DECLARE @TrabajosPendientes_DetalleAgenda int = (SELECT COUNT(Estado_DetalleAgenda) FROM DetallesAgendas
	                                                 WHERE Id_DatoAgenda_DetalleAgenda = (SELECT Id_DatoAgenda FROM DatosAgendas
													                                      WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
													 AND Estado_DetalleAgenda = 'PENDIENTE')
	
	SELECT Id_DatoAgenda_DetalleAgenda, SUM(MontoFinal_DetalleAgenda) AS MontoFinal_DetalleAgenda,
	COUNT(Id_Consumidor_DetalleAgenda) AS ConsumidoresAtendidos_DetalleAgenda,
	SUM(TiempoTrabajo_DetalleAgenda) AS TiempoTrabajo_DetalleAgenda,
	@TrabajosPendientes_DetalleAgenda AS TrabajosPendientes_DetalleAgenda FROM DetallesAgendas
	WHERE Id_DatoAgenda_DetalleAgenda = (SELECT Id_DatoAgenda FROM DatosAgendas
	                                     WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
	AND FORMAT(FechaTrabajo_DetalleAgenda,'MM') = FORMAT(GETDATE(), 'MM')
	AND Estado_DetalleAgenda = 'COMPLETADO'
	GROUP BY Id_DatoAgenda_DetalleAgenda

END
GO

-- ESTE --
CREATE PROCEDURE SP_MostrarCitasPendientesEnProceso_DetallesAgendas
(
@Id_Tecnico_DatoAgenda int,
@FechaTrabajo_DetalleAgenda Date,
@Estado_DetalleAgenda varchar(20)
)
AS
BEGIN

	IF (@Estado_DetalleAgenda = 'PENDIENTE')
	BEGIN
	
		SELECT Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor, Contacto_Consumidor, FechaTrabajo_DetalleAgenda,
		Direccion_DetalleAgenda, DescripcionTrabajo_DetalleAgenda, TiempoTrabajo_DetalleAgenda, PresupuestoManoDeObra_DetalleAgenda,
		PresupuestoMaterial_DetalleAgenda, MontoFinal_DetalleAgenda, Estado_DetalleAgenda FROM DetallesAgendas
		JOIN (SELECT Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor, Contacto_Consumidor FROM Consumidores)
		Tbl_Consumidores ON Id_Consumidor = Id_Consumidor_DetalleAgenda
		WHERE Id_DatoAgenda_DetalleAgenda = (SELECT Id_DatoAgenda FROM DatosAgendas
		                                     WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
		AND Estado_DetalleAgenda = @Estado_DetalleAgenda AND CAST(FechaTrabajo_DetalleAgenda AS DATE) = @FechaTrabajo_DetalleAgenda
	END
	ELSE IF (@Estado_DetalleAgenda = 'EN PROCESO')
	BEGIN
	
		SELECT Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor, Contacto_Consumidor, FechaTrabajo_DetalleAgenda,
		Direccion_DetalleAgenda, DescripcionTrabajo_DetalleAgenda, Estado_DetalleAgenda FROM DetallesAgendas
		JOIN (SELECT Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor, Contacto_Consumidor FROM Consumidores)
		Tbl_Consumidores ON Id_Consumidor = Id_Consumidor_DetalleAgenda
		WHERE Id_DatoAgenda_DetalleAgenda = (SELECT Id_DatoAgenda FROM DatosAgendas
		                                     WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
		AND Estado_DetalleAgenda = @Estado_DetalleAgenda

	END
END
GO

-- ESTE --
CREATE PROCEDURE SP_MostrarCitasPendientes_DetallesAgendas
(
@Id_Tecnico_DatoAgenda int
)
AS
BEGIN

	SELECT Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor, Contacto_Consumidor, FechaTrabajo_DetalleAgenda,
	Direccion_DetalleAgenda, DescripcionTrabajo_DetalleAgenda, TiempoTrabajo_DetalleAgenda, PresupuestoManoDeObra_DetalleAgenda,
	PresupuestoMaterial_DetalleAgenda, MontoFinal_DetalleAgenda, Estado_DetalleAgenda FROM DetallesAgendas
	JOIN (SELECT Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor, Contacto_Consumidor FROM Consumidores)
	Tbl_Consumidores ON Id_Consumidor = Id_Consumidor_DetalleAgenda
	WHERE Id_DatoAgenda_DetalleAgenda = (SELECT Id_DatoAgenda FROM DatosAgendas
	                                     WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
	AND Estado_DetalleAgenda = 'PENDIENTE'

END
GO
CREATE PROCEDURE SP_InsertarDatos_Salas
(
@Id_Tecnico_Mensaje int,
@Id_Consumidor_Mensaje int
)
AS
BEGIN

	INSERT INTO Salas values (GETDATE())
	
	INSERT INTO MiembrosSalas values ((SELECT MAX(Id_Sala) FROM Salas), @Id_Tecnico_Mensaje, @Id_Consumidor_Mensaje)

END
GO
CREATE PROCEDURE SP_InsertarDatos_Mensajes
(
@Id_Tecnico_Mensaje int,
@Id_Consumidor_Mensaje int,
@Mensaje varchar(MAX),
@Contenido varchar(MAX),
@Roll varchar(20)
)
AS
BEGIN

	DECLARE @Id_Sala_Mensaje int = (SELECT Id_Sala_MiembroSala FROM MiembrosSalas
									WHERE Id_Tecnico_MiembroSala = @Id_Tecnico_Mensaje
									AND Id_Consumidor_MiembroSala = @Id_Consumidor_Mensaje)

	IF (@Roll = 'TECNICO')
	BEGIN
														       
	    INSERT INTO Mensajes values (@Id_Sala_Mensaje, @Id_Tecnico_Mensaje, NULL, GETDATE(), @Mensaje, @Contenido)
	
	END
	ELSE IF (@Roll = 'CONSUMIDOR')
	BEGIN
	
		INSERT INTO Mensajes values (@Id_Sala_Mensaje, NULL, @Id_Consumidor_Mensaje, GETDATE(), @Mensaje, @Contenido)
	
	END
END
GO

-- ESTE --
CREATE PROCEDURE SP_MostrarDatos_Mensajes
(
@Id_Tecnico_Mensaje int,
@Id_Consumidor_Mensaje int
)
AS
BEGIN

	SELECT Id_Tecnico_Mensaje, Id_Consumidor_Mensaje, Fecha_Mensaje, Mensaje, Contenido FROM Mensajes
	WHERE Id_Sala_Mensaje = (SELECT Id_Sala_MiembroSala FROM MiembrosSalas
	                         WHERE Id_Tecnico_MiembroSala = @Id_Tecnico_Mensaje
							 AND Id_Consumidor_MiembroSala = @Id_Consumidor_Mensaje)

END
GO

-- ESTE --
CREATE PROCEDURE SP_MostrarDatos_MiembrosSalas
(
@Id_Tecnico_MiembroSala int,
@Id_Consumidor_MiembroSala int,
@Roll varchar(20)
)
AS
BEGIN

	IF (@Roll = 'TECNICO')
	BEGIN
	
		SELECT Id_Sala, Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor FROM Salas
		JOIN (SELECT * FROM MiembrosSalas) TBLMiembrosSalas
		ON Id_Sala = Id_Sala_MiembroSala 
		JOIN (SELECT Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor FROM Consumidores) AS TBL_Consumidores
		ON Id_Consumidor = Id_Consumidor_MiembroSala
		WHERE Id_Tecnico_MiembroSala = @Id_Tecnico_MiembroSala
	
	END
	ELSE IF (@Roll = 'CONSUMIDOR')
	BEGIN
	
	    SELECT Id_Sala, Id_Tecnico, Nombre_Tecnico, Apellido_Tecnico FROM Salas
		JOIN (SELECT * FROM MiembrosSalas) AS TBLMiembrosSalas
		ON Id_Sala = Id_Sala_MiembroSala 
		JOIN (SELECT Id_Tecnico, Nombre_Tecnico, Apellido_Tecnico FROM Tecnicos) AS TBL_Tecnicos
		ON Id_Tecnico = Id_Tecnico_MiembroSala
		WHERE Id_Consumidor_MiembroSala = @Id_Consumidor_MiembroSala
	
	END
END
GO
CREATE PROCEDURE SP_InsertarDatos_DetallesAgendas
(
@Id_Tecnico_DatoAgenda int,
@Id_Consumidor_DetalleAgenda int,
@FechaTrabajo_DetalleAgenda DateTime,
@Direccion_DetalleAgenda varchar(MAX),
@DescripcionTrabajo_DetalleAgenda varchar(MAX),
@TiempoTrabajo_DetalleAgenda int,
@PresupuestoManoDeObra_DetalleAgenda float,
@PresupuestoMaterial_DetalleAgenda float,
@MontoFinal_DetalleAgenda float,
@Estado_DetalleAgenda varchar(20),
@Roll varchar(20)
)
AS
BEGIN

	DECLARE @Id_DatoAgenda_DetalleAgenda int = (SELECT Id_DatoAgenda FROM DatosAgendas
	                                            WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
	
	DECLARE @Id_DetalleAgenda int = (SELECT MAX(Id_DetalleAgenda) FROM DetallesAgendas
	                                 WHERE Id_DatoAgenda_DetalleAgenda = @Id_DatoAgenda_DetalleAgenda
									 AND Id_Consumidor_DetalleAgenda = @Id_Consumidor_DetalleAgenda)
	
	IF (@Roll = 'CONSUMIDOR')
	BEGIN
		
	    INSERT INTO DetallesAgendas values (@Id_DatoAgenda_DetalleAgenda, @Id_Consumidor_DetalleAgenda, NULL, @Direccion_DetalleAgenda,
		                                    @DescripcionTrabajo_DetalleAgenda, NULL, NULL, NULL, NULL, 'EN PROCESO')
	
	END
	ELSE IF (@Roll = 'TECNICO')
	BEGIN
	
	    IF (@Estado_DetalleAgenda = 'DENEGADO')
	    BEGIN
	    
	        UPDATE DetallesAgendas SET Estado_DetalleAgenda = @Estado_DetalleAgenda WHERE Id_DetalleAgenda = @Id_DetalleAgenda
	    
	    END
	    ELSE IF (@Estado_DetalleAgenda = 'PENDIENTE')
	    BEGIN
	    
	        UPDATE DetallesAgendas SET FechaTrabajo_DetalleAgenda = @FechaTrabajo_DetalleAgenda, TiempoTrabajo_DetalleAgenda = @TiempoTrabajo_DetalleAgenda,
	                                   PresupuestoManoDeObra_DetalleAgenda = @PresupuestoManoDeObra_DetalleAgenda, PresupuestoMaterial_DetalleAgenda = @PresupuestoMaterial_DetalleAgenda,
	    					           MontoFinal_DetalleAgenda = @MontoFinal_DetalleAgenda, Estado_DetalleAgenda = @Estado_DetalleAgenda WHERE Id_DetalleAgenda = @Id_DetalleAgenda
	    
	    END
	    ELSE IF (@Estado_DetalleAgenda = 'COMPLETADO')
	    BEGIN
	    
	        UPDATE DetallesAgendas SET Estado_DetalleAgenda = @Estado_DetalleAgenda WHERE Id_DetalleAgenda = @Id_DetalleAgenda
	    
	    END
	END
END
GO

-- ESTE --
CREATE PROCEDURE SP_MostrarReporteDetallado_Tecnicos
(
@Id_Tecnico_DatoAgenda int,
@TipoReporte varchar(20)
)
AS
BEGIN

	DECLARE @TrabajosPendientes_DetalleAgenda int
	DECLARE @PromedioPuntaje_ReseñaTecnico int
	DECLARE @CantidadReseñas_ReseñaTecnico int
	
	IF (@TipoReporte = 'MENSUAL')
	BEGIN
	
		SET @TrabajosPendientes_DetalleAgenda = (SELECT COUNT(Estado_DetalleAgenda) FROM DetallesAgendas
		                                         WHERE Id_DatoAgenda_DetalleAgenda = (SELECT Id_DatoAgenda FROM DatosAgendas
														                              WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
												 AND Estado_DetalleAgenda = 'PENDIENTE')
		
		SET @PromedioPuntaje_ReseñaTecnico = (SELECT AVG(Puntaje_ReseniaTecnico) FROM ReseniasTecnicos
		                                      WHERE Id_Tecnico_ReseniaTecnico = @Id_Tecnico_DatoAgenda
											  AND FORMAT(Fecha_ReseniaTecnico, 'MM') = FORMAT(GETDATE(), 'MM'))
		
		SET @CantidadReseñas_ReseñaTecnico = (SELECT COUNT(ReseniaTecnico) FROM ReseniasTecnicos
		                                      WHERE Id_Tecnico_ReseniaTecnico = @Id_Tecnico_DatoAgenda
											  AND FORMAT(Fecha_ReseniaTecnico, 'MM') = FORMAT(GETDATE(), 'MM'))
		
		SELECT Id_DatoAgenda_DetalleAgenda,
		AVG(MontoFinal_DetalleAgenda) AS PromedioMontoFinal_DetalleAgenda,
		SUM(MontoFinal_DetalleAgenda) AS MontoFinal_DetalleAgenda,
		COUNT(Id_Consumidor_DetalleAgenda) AS ConsumidoresAtendidos_DetalleAgenda,
		SUM(TiempoTrabajo_DetalleAgenda) AS TiempoTrabajo_DetalleAgenda,
		@TrabajosPendientes_DetalleAgenda AS TrabajosPendientes_DetalleAgenda,
		@PromedioPuntaje_ReseñaTecnico AS PromedioPuntaje_ReseñaTecnico,
		@CantidadReseñas_ReseñaTecnico AS CantidadReseñas_ReseñaTecnico FROM DetallesAgendas
		WHERE Id_DatoAgenda_DetalleAgenda = (SELECT Id_DatoAgenda FROM DatosAgendas
		                                     WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
		AND FORMAT(FechaTrabajo_DetalleAgenda, 'MM') = FORMAT(GETDATE(), 'MM')
		AND Estado_DetalleAgenda = 'COMPLETADO'
		GROUP BY Id_DatoAgenda_DetalleAgenda

	END
	ELSE IF (@TipoReporte = 'TOTAL')
	BEGIN
	
		SET @TrabajosPendientes_DetalleAgenda = (SELECT COUNT(Estado_DetalleAgenda) FROM DetallesAgendas
		                                         WHERE Id_DatoAgenda_DetalleAgenda = (SELECT Id_DatoAgenda FROM DatosAgendas
														                              WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
										         AND Estado_DetalleAgenda = 'PENDIENTE')
		
		SET @PromedioPuntaje_ReseñaTecnico = (SELECT AVG(Puntaje_ReseniaTecnico) FROM ReseniasTecnicos
		                                      WHERE Id_Tecnico_ReseniaTecnico = @Id_Tecnico_DatoAgenda)
		
		SET @CantidadReseñas_ReseñaTecnico = (SELECT COUNT(ReseniaTecnico) FROM ReseniasTecnicos
		                                      WHERE Id_Tecnico_ReseniaTecnico = @Id_Tecnico_DatoAgenda)
		
		SELECT Id_DatoAgenda_DetalleAgenda,
		AVG(MontoFinal_DetalleAgenda) AS PromedioMontoFinal_DetalleAgenda,
		SUM(MontoFinal_DetalleAgenda) AS MontoFinal_DetalleAgenda,
		COUNT(Id_Consumidor_DetalleAgenda) AS ConsumidoresAtendidos_DetalleAgenda,
		SUM(TiempoTrabajo_DetalleAgenda) AS TiempoTrabajo_DetalleAgenda,
		@TrabajosPendientes_DetalleAgenda AS TrabajosPendientes_DetalleAgenda,
		@PromedioPuntaje_ReseñaTecnico AS PromedioPuntaje_ReseñaTecnico,
		@CantidadReseñas_ReseñaTecnico AS CantidadReseñas_ReseñaTecnico FROM DetallesAgendas
		WHERE Id_DatoAgenda_DetalleAgenda = (SELECT Id_DatoAgenda FROM DatosAgendas
		                                     WHERE Id_Tecnico_DatoAgenda = @Id_Tecnico_DatoAgenda)
		AND Estado_DetalleAgenda = 'COMPLETADO'
		GROUP BY Id_DatoAgenda_DetalleAgenda

	END
END
GO

-- DISPARADORES WEB - TECNICOS --

CREATE TRIGGER TG_InsertarDatos_Tecnicos ON Tecnicos FOR INSERT
AS
	SET NOCOUNT ON

	INSERT INTO DatosAgendas values ((SELECT inserted.Id_Tecnico FROM inserted), GETDATE())

GO

-- PROCEDIMIENTOS ALMACENADOS WEB - CONSUMIDORES --

CREATE PROCEDURE SP_InsertarDatos_Consumidores
(
@Id_Consumidor int,
@Perfil_Consumidor varchar(MAX),
@Nombre_Consumidor varchar(100),
@Apellido_Consumidor varchar(100),
@Edad_Consumidor int,
@Genero_Consumidor varchar(20),
@Contacto_Consumidor int,
@Correo_Consumidor varchar(100),
@CodigoConsumidor varchar(MAX)
)
AS
BEGIN


	INSERT INTO Consumidores values (@Id_Consumidor, @Perfil_Consumidor, @Nombre_Consumidor, @Apellido_Consumidor, @Edad_Consumidor,
	                                 @Genero_Consumidor, @Contacto_Consumidor, @Correo_Consumidor, 'ACTIVO')
	
	INSERT INTO CodigosConsumidores values (@Id_Consumidor, @CodigoConsumidor)

END
GO
CREATE PROCEDURE SP_InsertarDatos_Denuncias
(
@Id_DetalleAgenda int,
@Id_TipoDenuncia int,
@Descripcion varchar(MAX),
@Roll varchar(20)
)
AS
BEGIN

	IF (@Roll = 'TECNICO')
	BEGIN

		INSERT INTO DenunciasTecnicos VALUES (@Id_DetalleAgenda, @Id_TipoDenuncia, GETDATE(), UPPER(@Descripcion), 'PENDIENTE')

	END
	ELSE IF (@Roll = 'CONSUMIDOR')
	BEGIN

		INSERT INTO DenunciasConsumidores VALUES (@Id_DetalleAgenda, @Id_TipoDenuncia, GETDATE(), UPPER(@Descripcion), 'PENDIENTE')

	END
END
GO
CREATE PROCEDURE SP_InsertarDatos_ReseniasTecnicos
(
@Id_Consumidor_ReseniaTecnico int,
@Id_Tecnico_ReseniaTecnico int,
@Puntaje_ReseniaTecnico int,
@ReseniaTecnico varchar(MAX)
)
AS
BEGIN

	INSERT INTO ReseniasTecnicos VALUES (@Id_Consumidor_ReseniaTecnico, @Id_Tecnico_ReseniaTecnico, GETDATE(), @Puntaje_ReseniaTecnico, @ReseniaTecnico)

END
GO

/* Contar la cantidad de mensajes en funcion de un año especifico */
CREATE FUNCTION FT_CantidadMensajesPorAnio(@Anio int) RETURNS TABLE
AS
	RETURN (SELECT COUNT(Id_Mensaje) AS MensajesTotales FROM Mensajes  
			WHERE YEAR(Fecha_Mensaje) = @Anio)
GO

/* Contar la cantidad de tecnicos disponibles por distrito */
CREATE VIEW VW_TotalTecnicosDisponiblesPorDistrito
AS

	SELECT Id_Distrito_Tecnico, Disponibilidad_Tecnico,
	COUNT(Id_Tecnico) AS TotalTecnicos FROM Tecnicos 
	WHERE Disponibilidad_Tecnico = 'DISPONIBLE' 
    GROUP BY Id_Distrito_Tecnico, Disponibilidad_Tecnico

GO

/* Contar la cantidad de tecnicos disponibles en un determinado distrito */
CREATE FUNCTION FT_TecnicosDisponiblesPorDistrito(@Id_Distrito_Tecnico int) RETURNS INT
AS
BEGIN

   DECLARE @CantidadTecnicos int = (SELECT TotalTecnicos FROM VW_TotalTecnicosDisponiblesPorDistrito
									WHERE Id_Distrito_Tecnico = @Id_Distrito_Tecnico)

   RETURN @CantidadTecnicos
END
GO

/* Mostrar las salas iniciadas en un determinado año */
CREATE FUNCTION FT_SalasCreadasPorAnio (@Anio int) RETURNS TABLE
AS
	RETURN (SELECT * FROM Salas
			WHERE YEAR(Fecha_Sala) = @Anio)
GO

/* Contar la cantidad de tecnicos por departamento */
CREATE VIEW VW_CantidadTecnicosPorDepartamento
AS 
	SELECT  Departamento, Distrito, COUNT(Id_Tecnico) AS TotalTecnicos FROM Departamentos AS TBL_Departamentos
	JOIN (SELECT * FROM Distritos) AS TBL_Distritos
	ON TBL_Departamentos.Id_Departamento = TBL_Distritos.Id_Departamento_Distrito 
	JOIN (SELECT Id_Tecnico, Id_Distrito_Tecnico FROM Tecnicos) AS TBL_Tecnicos
	ON TBL_Distritos.Id_Distrito = TBL_Tecnicos.Id_Distrito_Tecnico
	GROUP BY Departamento, Distrito
GO

/* Buscar el depertamento y el distrito con mayor numero de tecnicos disponibles */
SELECT Departamento, Distrito FROM VW_CantidadTecnicosPorDepartamento 
WHERE TotalTecnicos = (SELECT MAX(TotalTecnicos) FROM  VW_CantidadTecnicosPorDepartamento)
GO

/* Contar la cantidad de resenias por tecnico */
CREATE VIEW VW_CantidadReseniasTecnicos
AS
	SELECT Id_Tecnico, Nombre_Tecnico, Departamento, Distrito,
	COUNT(Id_ReseniaTecnico) AS TotalResenias FROM Departamentos as TBL_Departamentos
	JOIN (SELECT * FROM Distritos) AS TBL_Distritos
	ON TBL_Departamentos.Id_Departamento = TBL_Distritos.Id_Departamento_Distrito
	JOIN (SELECT Id_Tecnico, Nombre_Tecnico, Id_Distrito_Tecnico FROM Tecnicos) AS TBL_Tecnicos
	ON TBL_Distritos.Id_Distrito = TBL_Tecnicos.Id_Distrito_Tecnico 
	JOIN (SELECT Id_ReseniaTecnico, Id_Tecnico_ReseniaTecnico FROM ReseniasTecnicos) AS TBL_ReseniasTecnicos
	ON TBL_Tecnicos.Id_Tecnico = TBL_ReseniasTecnicos.Id_Tecnico_ReseniaTecnico
	GROUP BY Id_Tecnico, Nombre_Tecnico, Departamento, Distrito
GO

/* Buscar los tecnicos con el mayor numero de resenias */
SELECT * FROM VW_CantidadReseniasTecnicos
WHERE TotalResenias = (SELECT MAX(TotalResenias) FROM VW_CantidadReseniasTecnicos)
GO

/*  Contar todos los tecnicos activos por departamento */
CREATE VIEW VW_CantidadTecnicosActivosPorDepartamento
AS

	SELECT Id_Departamento, Departamento, Estado_Tecnico, COUNT(Id_Tecnico) AS TotalTecnicos FROM Departamentos AS TBL_Departamentos 
	JOIN (SELECT * FROM  Distritos) as TBL_Distritos
	ON TBL_Departamentos.Id_Departamento = TBL_Distritos.Id_Departamento_Distrito 
	JOIN (SELECT Id_Tecnico, Id_Distrito_Tecnico, Estado_Tecnico FROM Tecnicos) as TBL_Tecnicos
	ON TBL_Distritos.Id_Distrito = TBL_Tecnicos.Id_Distrito_Tecnico
	WHERE Estado_Tecnico = 'ACTIVO'
	GROUP BY Id_Departamento, Departamento, Estado_Tecnico

GO

/* Busca la cantidad de tecnicos por departamento */
CREATE FUNCTION FT_BuscarCantidadTecnicosPorDepartamento (@Id_Departamento int) RETURNS TABLE 
AS
	RETURN (SELECT Id_Departamento, Departamento, TotalTecnicos FROM VW_CantidadTecnicosActivosPorDepartamento
			WHERE Id_Departamento = @Id_Departamento)
GO

/* Busca el departamento con mayor numero de tecnicos activos */
SELECT Departamento FROM VW_CantidadTecnicosActivosPorDepartamento 
WHERE TotalTecnicos = (SELECT MAX(TotalTecnicos) FROM VW_CantidadTecnicosActivosPorDepartamento)
GO

/* Cantidad de miembros por salas */
CREATE VIEW VW_CantidadMiembrosPorSalas
AS 

	SELECT Id_sala, COUNT(Id_Sala_MiembroSala) AS CantidadMiembros FROM Salas AS TBL_Salas
	JOIN (SELECT Id_Sala_MiembroSala FROM MiembrosSalas) AS TBL_MiembrosSalas
	ON TBL_Salas.Id_Sala = TBL_MiembrosSalas.Id_Sala_MiembroSala
	GROUP BY Id_sala

GO

/* Busca la cantidad de miembros por sala */
CREATE FUNCTION FT_BuscarCantidadMiembrosPorSala (@Id_Sala int) RETURNS TABLE
AS
	RETURN (SELECT CantidadMiembros FROM VW_CantidadMiembrosPorSalas 
			WHERE Id_Sala = @Id_Sala)
GO

/* Busca la sala con la menor cantidad de miembros */
SELECT * FROM VW_CantidadMiembrosPorSalas 
WHERE CantidadMiembros = (SELECT MIN(CantidadMiembros) FROM VW_CantidadMiembrosPorSalas)
GO