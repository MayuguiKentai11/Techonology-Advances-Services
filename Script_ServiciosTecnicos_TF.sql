/****** Object:  Database [ServiciosTecnicos]    Script Date: 23/11/2023 19:28:01 ******/
CREATE DATABASE [ServiciosTecnicos]
GO

USE [ServiciosTecnicos]
GO

/****** Object:  UserDefinedFunction [dbo].[FT_TecnicosDisponiblesPorDistrito]    Script Date: 23/11/2023 19:28:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FT_TecnicosDisponiblesPorDistrito](@Id_Distrito_Tecnico int) RETURNS INT
AS
BEGIN

   DECLARE @CantidadTecnicos int = (SELECT TotalTecnicos FROM VW_TotalTecnicosDisponiblesPorDistrito
									WHERE Id_Distrito_Tecnico = @Id_Distrito_Tecnico)

   RETURN @CantidadTecnicos
END
GO
/****** Object:  Table [dbo].[Mensajes]    Script Date: 23/11/2023 19:28:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mensajes](
	[Id_Mensaje] [int] IDENTITY(1,1) NOT NULL,
	[Id_Sala_Mensaje] [int] NULL,
	[Id_Tecnico_Mensaje] [int] NULL,
	[Id_Consumidor_Mensaje] [int] NULL,
	[Fecha_Mensaje] [datetime] NULL,
	[Mensaje] [varchar](max) NULL,
	[Contenido] [varchar](max) NULL,
 CONSTRAINT [PK_Id_Mensaje] PRIMARY KEY CLUSTERED 
(
	[Id_Mensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[FT_CantidadMensajesPorAnio]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FT_CantidadMensajesPorAnio](@Anio int) RETURNS TABLE
AS
	RETURN (SELECT COUNT(Id_Mensaje) AS MensajesTotales FROM Mensajes  
			WHERE YEAR(Fecha_Mensaje) = @Anio)
GO
/****** Object:  Table [dbo].[Tecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tecnicos](
	[Id_Tecnico] [int] NOT NULL,
	[Id_Distrito_Tecnico] [int] NULL,
	[Id_Especialidad_Tecnico] [int] NULL,
	[Perfil_Tecnico] [varchar](max) NULL,
	[Nombre_Tecnico] [varchar](100) NULL,
	[Apellido_Tecnico] [varchar](100) NULL,
	[Edad_Tecnico] [int] NULL,
	[Genero_Tecnico] [varchar](20) NULL,
	[Contacto_Tecnico] [int] NULL,
	[Correo_Tecnico] [varchar](100) NULL,
	[Disponibilidad_Tecnico] [varchar](20) NULL,
	[Estado_Tecnico] [varchar](20) NULL,
 CONSTRAINT [PK_Id_Tecnico] PRIMARY KEY CLUSTERED 
(
	[Id_Tecnico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_TotalTecnicosDisponiblesPorDistrito]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_TotalTecnicosDisponiblesPorDistrito]
AS

	SELECT Id_Distrito_Tecnico, Disponibilidad_Tecnico,
	COUNT(Id_Tecnico) AS TotalTecnicos FROM Tecnicos 
	WHERE Disponibilidad_Tecnico = 'DISPONIBLE' 
    GROUP BY Id_Distrito_Tecnico, Disponibilidad_Tecnico

GO
/****** Object:  Table [dbo].[Salas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salas](
	[Id_Sala] [int] IDENTITY(1,1) NOT NULL,
	[Fecha_Sala] [datetime] NULL,
 CONSTRAINT [PK_Id_Sala] PRIMARY KEY CLUSTERED 
(
	[Id_Sala] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[FT_SalasCreadasPorAnio]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FT_SalasCreadasPorAnio] (@Anio int) RETURNS TABLE
AS
	RETURN (SELECT * FROM Salas
			WHERE YEAR(Fecha_Sala) = @Anio)
GO
/****** Object:  Table [dbo].[Departamentos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamentos](
	[Id_Departamento] [int] IDENTITY(1,1) NOT NULL,
	[Departamento] [varchar](50) NULL,
 CONSTRAINT [PK_Id_Departamento] PRIMARY KEY CLUSTERED 
(
	[Id_Departamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Distritos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distritos](
	[Id_Distrito] [int] IDENTITY(1,1) NOT NULL,
	[Id_Departamento_Distrito] [int] NULL,
	[Distrito] [varchar](50) NULL,
 CONSTRAINT [PK_Id_Distrito] PRIMARY KEY CLUSTERED 
(
	[Id_Distrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_CantidadTecnicosPorDepartamento]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CantidadTecnicosPorDepartamento]
AS 
	SELECT  Departamento, Distrito, COUNT(Id_Tecnico) AS TotalTecnicos FROM Departamentos AS TBL_Departamentos
	JOIN (SELECT * FROM Distritos) AS TBL_Distritos
	ON TBL_Departamentos.Id_Departamento = TBL_Distritos.Id_Departamento_Distrito 
	JOIN (SELECT Id_Tecnico, Id_Distrito_Tecnico FROM Tecnicos) AS TBL_Tecnicos
	ON TBL_Distritos.Id_Distrito = TBL_Tecnicos.Id_Distrito_Tecnico
	GROUP BY Departamento, Distrito
GO
/****** Object:  Table [dbo].[ReseniasTecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReseniasTecnicos](
	[Id_ReseniaTecnico] [int] IDENTITY(1,1) NOT NULL,
	[Id_Consumidor_ReseniaTecnico] [int] NULL,
	[Id_Tecnico_ReseniaTecnico] [int] NULL,
	[Fecha_ReseniaTecnico] [datetime] NULL,
	[Puntaje_ReseniaTecnico] [int] NULL,
	[ReseniaTecnico] [varchar](max) NULL,
 CONSTRAINT [PK_Id_ReseniaTecnico] PRIMARY KEY CLUSTERED 
(
	[Id_ReseniaTecnico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_CantidadReseniasTecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CantidadReseniasTecnicos]
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
/****** Object:  View [dbo].[VW_CantidadTecnicosActivosPorDepartamento]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CantidadTecnicosActivosPorDepartamento]
AS

	SELECT Id_Departamento, Departamento, Estado_Tecnico, COUNT(Id_Tecnico) AS TotalTecnicos FROM Departamentos AS TBL_Departamentos 
	JOIN (SELECT * FROM  Distritos) as TBL_Distritos
	ON TBL_Departamentos.Id_Departamento = TBL_Distritos.Id_Departamento_Distrito 
	JOIN (SELECT Id_Tecnico, Id_Distrito_Tecnico, Estado_Tecnico FROM Tecnicos) as TBL_Tecnicos
	ON TBL_Distritos.Id_Distrito = TBL_Tecnicos.Id_Distrito_Tecnico
	WHERE Estado_Tecnico = 'ACTIVO'
	GROUP BY Id_Departamento, Departamento, Estado_Tecnico

GO
/****** Object:  UserDefinedFunction [dbo].[FT_BuscarCantidadTecnicosPorDepartamento]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FT_BuscarCantidadTecnicosPorDepartamento] (@Id_Departamento int) RETURNS TABLE 
AS
	RETURN (SELECT Id_Departamento, Departamento, TotalTecnicos FROM VW_CantidadTecnicosActivosPorDepartamento
			WHERE Id_Departamento = @Id_Departamento)
GO
/****** Object:  Table [dbo].[MiembrosSalas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MiembrosSalas](
	[Id_Sala_MiembroSala] [int] NULL,
	[Id_Tecnico_MiembroSala] [int] NULL,
	[Id_Consumidor_MiembroSala] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_CantidadMiembrosPorSalas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CantidadMiembrosPorSalas]
AS 

	SELECT Id_sala, COUNT(Id_Sala_MiembroSala) AS CantidadMiembros FROM Salas AS TBL_Salas
	JOIN (SELECT Id_Sala_MiembroSala FROM MiembrosSalas) AS TBL_MiembrosSalas
	ON TBL_Salas.Id_Sala = TBL_MiembrosSalas.Id_Sala_MiembroSala
	GROUP BY Id_sala

GO
/****** Object:  UserDefinedFunction [dbo].[FT_BuscarCantidadMiembrosPorSala]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FT_BuscarCantidadMiembrosPorSala] (@Id_Sala int) RETURNS TABLE
AS
	RETURN (SELECT CantidadMiembros FROM VW_CantidadMiembrosPorSalas 
			WHERE Id_Sala = @Id_Sala)
GO
/****** Object:  Table [dbo].[Administradores]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administradores](
	[Id_Administrador] [int] NOT NULL,
	[Codigo_Administrador] [varchar](max) NULL,
 CONSTRAINT [PK_Id_Administrador] PRIMARY KEY CLUSTERED 
(
	[Id_Administrador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AntecedentesTecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AntecedentesTecnicos](
	[Id_AntecedenteTecnico] [int] IDENTITY(1,1) NOT NULL,
	[Id_Tecnico_AntecedenteTecnico] [int] NULL,
	[DNI_AntecedenteTecnico] [varchar](max) NULL,
	[AntecedenteTecnico] [varchar](max) NULL,
 CONSTRAINT [PK_Id_AntecedenteTecnico] PRIMARY KEY CLUSTERED 
(
	[Id_AntecedenteTecnico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CodigosConsumidores]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CodigosConsumidores](
	[Id_Consumidor_CodigoConsumidor] [int] NOT NULL,
	[CodigoConsumidor] [varchar](max) NULL,
 CONSTRAINT [PK_Id_Consumidor_CodigoConsumidor] PRIMARY KEY CLUSTERED 
(
	[Id_Consumidor_CodigoConsumidor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CodigosTecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CodigosTecnicos](
	[Id_Tecnico_CodigoTecnico] [int] NOT NULL,
	[CodigoTecnico] [nvarchar](max) NULL,
 CONSTRAINT [PK_Id_Tecnico_CodigoTecnico] PRIMARY KEY CLUSTERED 
(
	[Id_Tecnico_CodigoTecnico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Consumidores]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Consumidores](
	[Id_Consumidor] [int] NOT NULL,
	[Perfil_Consumidor] [varchar](max) NULL,
	[Nombre_Consumidor] [varchar](100) NULL,
	[Apellido_Consumidor] [varchar](100) NULL,
	[Edad_Consumidor] [int] NULL,
	[Genero_Consumidor] [varchar](20) NULL,
	[Contacto_Consumidor] [int] NULL,
	[Correo_Consumidor] [varchar](100) NULL,
	[Estado_Consumidor] [varchar](20) NULL,
 CONSTRAINT [PK_Id_Consumidor] PRIMARY KEY CLUSTERED 
(
	[Id_Consumidor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContratosTecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContratosTecnicos](
	[Id_ContratoTecnico] [int] IDENTITY(1,1) NOT NULL,
	[Id_Tecnico_ContratoTecnico] [int] NULL,
	[Id_Membresia_ContratoTecnico] [int] NULL,
	[FechaInicio_ContratoTecnico] [datetime] NULL,
	[FechaFin_ContratoTecnico] [datetime] NULL,
	[Estado_ContratoTecnico] [varchar](20) NULL,
 CONSTRAINT [PK_Id_ContratoTecnico] PRIMARY KEY CLUSTERED 
(
	[Id_ContratoTecnico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatosAgendas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatosAgendas](
	[Id_DatoAgenda] [int] IDENTITY(1,1) NOT NULL,
	[Id_Tecnico_DatoAgenda] [int] NULL,
	[FechaCreacion_DatoAgenda] [datetime] NULL,
 CONSTRAINT [PK_Id_DatoAgenda] PRIMARY KEY CLUSTERED 
(
	[Id_DatoAgenda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DenunciasConsumidores]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DenunciasConsumidores](
	[Id_DenunciaConsumidor] [int] IDENTITY(1,1) NOT NULL,
	[Id_DetalleAgenda_DenunciaConsumidor] [int] NULL,
	[Id_TipoDenunciaConsumidor_DenunciaConsumidor] [int] NULL,
	[Fecha_DenunciaConsumidor] [datetime] NULL,
	[Descripcion_DenunciaConsumidor] [varchar](max) NULL,
	[Estado_DenunciaConsumidor] [varchar](20) NULL,
 CONSTRAINT [PK_Id_DenunciaConsumidor] PRIMARY KEY CLUSTERED 
(
	[Id_DenunciaConsumidor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DenunciasTecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DenunciasTecnicos](
	[Id_DenunciaTecnico] [int] IDENTITY(1,1) NOT NULL,
	[Id_DetalleAgenda_DenunciaTecnico] [int] NULL,
	[Id_TipoDenunciaTecnico_DenunciaTecnico] [int] NULL,
	[Fecha_DenunciaTecnico] [datetime] NULL,
	[Descripcion_DenunciaTecnico] [varchar](max) NULL,
	[Estado_DenunciaTecnico] [varchar](20) NULL,
 CONSTRAINT [PK_Id_DenunciaTecnico] PRIMARY KEY CLUSTERED 
(
	[Id_DenunciaTecnico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallesAgendas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallesAgendas](
	[Id_DetalleAgenda] [int] IDENTITY(1,1) NOT NULL,
	[Id_DatoAgenda_DetalleAgenda] [int] NULL,
	[Id_Consumidor_DetalleAgenda] [int] NULL,
	[FechaTrabajo_DetalleAgenda] [datetime] NULL,
	[Direccion_DetalleAgenda] [varchar](max) NULL,
	[DescripcionTrabajo_DetalleAgenda] [varchar](max) NULL,
	[TiempoTrabajo_DetalleAgenda] [int] NULL,
	[PresupuestoManoDeObra_DetalleAgenda] [float] NULL,
	[PresupuestoMaterial_DetalleAgenda] [float] NULL,
	[MontoFinal_DetalleAgenda] [float] NULL,
	[Estado_DetalleAgenda] [varchar](20) NULL,
 CONSTRAINT [PK_Id_DetalleAgenda] PRIMARY KEY CLUSTERED 
(
	[Id_DetalleAgenda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Especialidades]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especialidades](
	[Id_Especialidad] [int] IDENTITY(1,1) NOT NULL,
	[Especialidad] [varchar](100) NULL,
 CONSTRAINT [PK_Id_Especialidad] PRIMARY KEY CLUSTERED 
(
	[Id_Especialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Membresias]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Membresias](
	[Id_Membresia] [int] IDENTITY(1,1) NOT NULL,
	[Id_TipoMoneda_Membresia] [int] NULL,
	[Nombre_Membresia] [varchar](50) NULL,
	[Precio_Membresia] [float] NULL,
	[Descripcion_Membresia] [varchar](max) NULL,
 CONSTRAINT [PK_Id_Membresia] PRIMARY KEY CLUSTERED 
(
	[Id_Membresia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposDenunciasConsumidores]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposDenunciasConsumidores](
	[Id_TipoDenunciaConsumidor] [int] IDENTITY(1,1) NOT NULL,
	[TipoDenunciaConsumidor] [varchar](100) NULL,
 CONSTRAINT [PK_Id_TipoDenunciaConsumidor] PRIMARY KEY CLUSTERED 
(
	[Id_TipoDenunciaConsumidor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposDenunciasTecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposDenunciasTecnicos](
	[Id_TipoDenunciaTecnico] [int] IDENTITY(1,1) NOT NULL,
	[TipoDenunciaTecnico] [varchar](100) NULL,
 CONSTRAINT [PK_Id_TipoDenunciaTecnico] PRIMARY KEY CLUSTERED 
(
	[Id_TipoDenunciaTecnico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposMonedas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposMonedas](
	[Id_TipoMoneda] [int] IDENTITY(1,1) NOT NULL,
	[TipoMoneda] [varchar](20) NULL,
 CONSTRAINT [PK_Id_TipoMoneda] PRIMARY KEY CLUSTERED 
(
	[Id_TipoMoneda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (70458211, N'6OphZj3V1EfYqvxfDYUDnQ==S9V0D7/5caIiIH6CWs/X+w==')
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (71148992, N'VCXbFBpwN9kP2BOKWkgR8Q==4h3CDUqxidcLFb7X31/jJg==')
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (73694200, N'yRc3CbIYv41RsNMCLA0C7g==NtIXNRSAQXCQbpFGEjPXnA==')
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (74415256, N'lraKSZ2uWq8/Kpt2p1OTpQ==pa4TJW235IUOZ8UDe1hZLw==')
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (74489267, N'+mQY3vYBAlOOMRPWAymwrw==uAymFsPzZnaUMgilNzFW1g==')
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (74891021, N'vBp8KMq453IP+ep8Lxagzg==VCktnGxky/rVBGq0u3MScg==')
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (76666318, N'h77piN+MvHSos1miDjmXkA==ABEdhdgZzauEm9GUELV5Cg==')
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (76978121, N'GSKB71AhdUY2EjYS5UcDug==dQfK8ewgKvCyukcqOsj0sA==')
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (76984210, N'YrEipqBdM5bUz4EpFX+d1A==7MluEl/nW2pqBGDvSrJC5Q==')
INSERT [dbo].[Administradores] ([Id_Administrador], [Codigo_Administrador]) VALUES (77910300, N'6mq6+sME6qCQPqHDybFOvg==j4GdB27GtPHOTeQDYbp4Kw==')
GO
SET IDENTITY_INSERT [dbo].[AntecedentesTecnicos] ON 

INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (1, 76507123, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-76507123.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-76507123.pdf')
INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (2, 74675125, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-74675125.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-74675125.pdf')
INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (3, 71169821, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-71169821.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-71169821.pdf')
INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (4, 79452135, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-79452135.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-79452135.pdf')
INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (5, 71465988, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-71465988.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-71465988.pdf')
INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (6, 72158645, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-72158645.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-72158645.pdf')
INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (7, 76648921, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-76648921.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-76648921.pdf')
INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (8, 71169845, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-71169845.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-71169845.pdf')
INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (9, 71465980, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-71465980.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-71465980.pdf')
INSERT [dbo].[AntecedentesTecnicos] ([Id_AntecedenteTecnico], [Id_Tecnico_AntecedenteTecnico], [DNI_AntecedenteTecnico], [AntecedenteTecnico]) VALUES (10, 76698421, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\DNI\DNI-76698421.pdf', N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Antecedente\Antecedente-76698421.pdf')
SET IDENTITY_INSERT [dbo].[AntecedentesTecnicos] OFF
GO
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (70155892, N'54HGGicVPxwxSYvhm2Mshg==5p1hM7U1RDqv7gxk5HjllQ==')
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (70542145, N'k42UmfX2FwmN/aLQqnUgMA==+AEPWAyDLqx9xsxAG0ZWKA==')
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (70698450, N'/0vYuWCrA3b2QtaVINixDA==kllWCePI5nEIptDyv/ODYA==')
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (73698202, N'n+yP/HoU8QttQC30X3PPGA==n32SpO71ICYyZ1DdbrwIMw==')
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (74499210, N'CqIlOioound8SskLUM6XYA==3aKjxrE9Z3Oni8EZLxxBVQ==')
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (76648920, N'j+LP/B1jrGkyY5pbtVKY+g==BTwTew8kiiMKWuY/FcPQzw==')
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (77662123, N'Up9tG65LCHcUWIxGPU1nkA==0RLhAMyWzdAwRbGcvb/qdw==')
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (78892100, N'de+7fBMrub/I5FuTl6yAew==2L3yaNbY2t0TXYwKJ11Z3w==')
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (79312151, N'+yOYrBK4Z6/yaz4VRwkR1g==dYd1uOY5kLgdZsmmcyreCA==')
INSERT [dbo].[CodigosConsumidores] ([Id_Consumidor_CodigoConsumidor], [CodigoConsumidor]) VALUES (79984510, N'roHJPBsy/6ZHbophhsK+LQ==IImYmw9HndOaU7urZ1lN5Q==')
GO
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (71169821, N'Iqv5DmydcSVA+Hivh0rKGA==zSILypPfS5YWBp5VeT+sHw==')
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (71169845, N'Wsx1mE4iTQz240KWVShmZQ==oWX+RkCOv6cgAWp8la+dFw==')
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (71465980, N'O7ARrGmwl55KncrHBHUZDQ==+IB6zSJyNauTHsp4/I6ivA==')
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (71465988, N'D4h4dXx9zlYgkXvEJKFJVA==LuqusWi8Z3iUenxMvAtB5g==')
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (72158645, N'7y7feXpkESf+ZW61PSKWdA==lpx4aBGhoo3nr2ng0HPLPA==')
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (74675125, N'xfxUNlAfbYFGzML+4Afq8w==stEhllpf/yyoJ19IE4bA7Q==')
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (76507123, N'5r4IzXzJJkjzgqgteeFMKg==/xsarA5xqdsuUOkRDNGstA==')
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (76648921, N'mu9cW1RzHMdwx1OfsFvSpQ==H2P97Q9jIFJ3oodetQRlVQ==')
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (76698421, N'dz9Mn5zAwjwwgoSlBRrYQg==ef7xK42qpWdaLAHg/2fKuw==')
INSERT [dbo].[CodigosTecnicos] ([Id_Tecnico_CodigoTecnico], [CodigoTecnico]) VALUES (79452135, N'LsGzizxQe6DLptMiaHkwZA==jmU1dbX/nQF9K1TlhCrDyA==')
GO
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (70155892, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-70155892.jpeg', N'YAN PIERRE', N'CASTILLO GUZMAN', 23, N'MASCULINO', 966472112, N'YanCastillo3556@hotmail.com', N'ACTIVO')
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (70542145, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-70542145.jpeg', N'JUAN CARLOS', N'ARAUJO OROSCO', 21, N'MASCULINO', 999465211, N'JuanCar6982@hotmail.com', N'ACTIVO')
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (70698450, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-70698450.jpeg', N'ANILU IRMA', N'AYALA GALVAN', 36, N'FEMENINO', 900845936, N'AnIrma356@hotmail.com', N'ACTIVO')
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (73698202, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-73698202.jpeg', N'MARIA TERESA', N'PRADO FALCON', 24, N'FEMENINO', 995151254, N'AriPrado123@hotmail.com', N'ACTIVO')
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (74499210, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-74499210.jpeg', N'RICHARD ENRIQUE', N'DIAZ VILLANUEVA', 31, N'MASCULINO', 914968721, N'RichiDiaz0294@hotmail.com', N'ACTIVO')
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (76648920, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-76648920.jpeg', N'GEANELLA CAROLINE', N'CORONEL SALAS', 39, N'FEMENINO', 933547812, N'GeanCaro049@hotmail.com', N'ACTIVO')
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (77662123, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-77662123.jpeg', N'ANA CECILIA', N'BRICEÑO ORTEGA', 32, N'FEMENINO', 977881260, N'AnaCel257@hotmail.com', N'ACTIVO')
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (78892100, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-78892100.jpeg', N'DENISE BELINDA', N'CALIZAYA CATACORA', 18, N'FEMENINO', 947632512, N'DeniBel971@hotmail.com', N'ACTIVO')
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (79312151, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-79312151.jpeg', N'JULIO CESAR', N'CABALLERO AREVALO', 19, N'MASCULINO', 964789215, N'JuliCesar6632@hotmail.com', N'ACTIVO')
INSERT [dbo].[Consumidores] ([Id_Consumidor], [Perfil_Consumidor], [Nombre_Consumidor], [Apellido_Consumidor], [Edad_Consumidor], [Genero_Consumidor], [Contacto_Consumidor], [Correo_Consumidor], [Estado_Consumidor]) VALUES (79984510, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Consumidores\Perfil\Perfil-79984510.jpeg', N'JOSE HUMBERTO', N'BURGA RODRIGUEZ', 47, N'MASCULINO', 911596120, N'JosHumb2567@hotmail.com', N'ACTIVO')
GO
SET IDENTITY_INSERT [dbo].[ContratosTecnicos] ON 

INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (1, 71169821, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), NULL, N'VIGENTE')
INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (2, 71169845, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), CAST(N'2024-04-25T18:58:30.413' AS DateTime), N'VIGENTE')
INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (3, 71465980, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), CAST(N'2024-04-25T18:58:30.413' AS DateTime), N'VIGENTE')
INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (4, 71465988, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), CAST(N'2024-04-25T18:58:30.413' AS DateTime), N'VIGENTE')
INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (5, 72158645, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), CAST(N'2024-04-25T18:58:30.413' AS DateTime), N'VIGENTE')
INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (6, 74675125, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), CAST(N'2024-04-25T18:58:30.413' AS DateTime), N'VIGENTE')
INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (7, 76507123, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), CAST(N'2024-04-25T18:58:30.413' AS DateTime), N'VIGENTE')
INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (8, 76648921, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), CAST(N'2024-04-25T18:58:30.413' AS DateTime), N'VIGENTE')
INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (9, 76698421, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), CAST(N'2024-04-25T18:58:30.413' AS DateTime), N'VIGENTE')
INSERT [dbo].[ContratosTecnicos] ([Id_ContratoTecnico], [Id_Tecnico_ContratoTecnico], [Id_Membresia_ContratoTecnico], [FechaInicio_ContratoTecnico], [FechaFin_ContratoTecnico], [Estado_ContratoTecnico]) VALUES (10, 79452135, 1, CAST(N'2023-10-25T18:58:30.413' AS DateTime), CAST(N'2024-04-25T18:58:30.413' AS DateTime), N'VIGENTE')
SET IDENTITY_INSERT [dbo].[ContratosTecnicos] OFF
GO
SET IDENTITY_INSERT [dbo].[DatosAgendas] ON 

INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (1, 76507123, CAST(N'2023-10-25T18:58:30.413' AS DateTime))
INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (2, 74675125, CAST(N'2023-10-25T19:06:56.610' AS DateTime))
INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (3, 71169821, CAST(N'2023-10-25T19:09:13.940' AS DateTime))
INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (4, 79452135, CAST(N'2023-10-25T19:12:01.557' AS DateTime))
INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (5, 71465988, CAST(N'2023-10-25T19:14:55.030' AS DateTime))
INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (6, 72158645, CAST(N'2023-10-26T16:40:31.210' AS DateTime))
INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (7, 76648921, CAST(N'2023-10-26T16:42:19.010' AS DateTime))
INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (8, 71169845, CAST(N'2023-10-26T16:44:02.063' AS DateTime))
INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (9, 71465980, CAST(N'2023-10-26T16:46:41.533' AS DateTime))
INSERT [dbo].[DatosAgendas] ([Id_DatoAgenda], [Id_Tecnico_DatoAgenda], [FechaCreacion_DatoAgenda]) VALUES (10, 76698421, CAST(N'2023-10-26T16:48:23.373' AS DateTime))
SET IDENTITY_INSERT [dbo].[DatosAgendas] OFF
GO
SET IDENTITY_INSERT [dbo].[DenunciasConsumidores] ON 

INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (1, 1, 1, CAST(N'2023-10-28T17:09:34.690' AS DateTime), N'EL TÉCNICO COBRÓ UN PRECIO MUCHO MÁS ALTO DE LO ACORDADO INICIALMENTE POR EL SERVICIO PRESTADO. ESTA PRÁCTICA ES INACEPTABLE Y QUIERO REPORTAR ESTA ESTAFA EN LOS PRECIOS.', N'PENDIENTE')
INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (2, 2, 2, CAST(N'2023-10-28T17:09:34.693' AS DateTime), N'EL TÉCNICO SE HIZO PASAR POR OTRA PERSONA O ENTIDAD, LO QUE ME GENERÓ DESCONFIANZA Y PREOCUPACIÓN POR MI SEGURIDAD. NECESITO QUE SE INVESTIGUE ESTA SUPLANTACIÓN DE IDENTIDAD.', N'PENDIENTE')
INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (3, 3, 3, CAST(N'2023-10-28T17:09:34.693' AS DateTime), N'EL TÉCNICO PROGRAMÓ UNA CITA PARA REPARAR UN PROBLEMA EN MI HOGAR, PERO NUNCA APARECIÓ. SU INASISTENCIA ME CAUSÓ INCONVENIENTES Y PÉRDIDA DE TIEMPO.', N'PENDIENTE')
INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (4, 4, 4, CAST(N'2023-10-28T17:09:34.693' AS DateTime), N'EL TRABAJO REALIZADO POR EL TÉCNICO FUE DE MUY MALA CALIDAD. LOS PROBLEMAS QUE TENÍA EN MI HOGAR NO SE SOLUCIONARON ADECUADAMENTE Y AHORA TENGO QUE BUSCAR OTRO PROFESIONAL PARA CORREGIR LOS ERRORES.', N'PENDIENTE')
INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (5, 5, 5, CAST(N'2023-10-28T17:09:34.693' AS DateTime), N'EL TÉCNICO MOSTRÓ FALTA DE EXPERIENCIA DURANTE EL TRABAJO. SUS ACCIONES DEMOSTRARON INCOMPETENCIA Y FALTA DE HABILIDAD PARA ABORDAR EL PROBLEMA QUE ENFRENTABA EN MI HOGAR.', N'PENDIENTE')
INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (6, 6, 6, CAST(N'2023-10-28T17:09:34.693' AS DateTime), N'SOSPECHO QUE EL TÉCNICO ROBÓ OBJETOS DE VALOR DE MI HOGAR MIENTRAS REALIZABA EL SERVICIO. NECESITO QUE SE INVESTIGUE ESTA SITUACIÓN Y SE TOMEN MEDIDAS APROPIADAS.', N'PENDIENTE')
INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (7, 7, 7, CAST(N'2023-10-28T17:09:34.693' AS DateTime), N'EL TÉCNICO ME AGREDIÓ FÍSICAMENTE DURANTE UNA DISCUSIÓN SOBRE EL SERVICIO PRESTADO. ESTA VIOLENCIA ES INACEPTABLE Y REQUIERO ASISTENCIA PARA ABORDAR ESTA SITUACIÓN.', N'PENDIENTE')
INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (8, 8, 8, CAST(N'2023-10-28T17:09:34.693' AS DateTime), N'EL TÉCNICO ME AMENAZÓ VERBALMENTE, LO CUAL ME HIZO SENTIR INSEGURO EN MI PROPIO HOGAR. ESTAS AMENAZAS SON GRAVES Y DEBEN SER TRATADAS CON SERIEDAD.', N'PENDIENTE')
INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (9, 9, 9, CAST(N'2023-10-28T17:09:34.693' AS DateTime), N'EL PRECIO COBRADO POR EL TÉCNICO FUE EXCESIVAMENTE ALTO PARA EL SERVICIO PRESTADO. ESTA TARIFA DESPROPORCIONADA ES INJUSTA Y QUIERO PRESENTAR UNA DENUNCIA AL RESPECTO.', N'PENDIENTE')
INSERT [dbo].[DenunciasConsumidores] ([Id_DenunciaConsumidor], [Id_DetalleAgenda_DenunciaConsumidor], [Id_TipoDenunciaConsumidor_DenunciaConsumidor], [Fecha_DenunciaConsumidor], [Descripcion_DenunciaConsumidor], [Estado_DenunciaConsumidor]) VALUES (10, 10, 10, CAST(N'2023-10-28T17:09:34.693' AS DateTime), N'EL TÉCNICO INTENTÓ EXTORSIONARME EXIGIENDO UN PAGO ADICIONAL BAJO AMENAZAS Y COACCIÓN. ESTA EXTORSIÓN ES UN DELITO Y NECESITO AYUDA PARA RESOLVER ESTA SITUACIÓN URGENTE.', N'PENDIENTE')
SET IDENTITY_INSERT [dbo].[DenunciasConsumidores] OFF
GO
SET IDENTITY_INSERT [dbo].[DenunciasTecnicos] ON 

INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (1, 1, 1, CAST(N'2023-10-28T17:16:50.677' AS DateTime), N'EL CLIENTE ME ROBÓ DURANTE LA PRESTACIÓN DEL SERVICIO, LO CUAL ES UNA VIOLACIÓN GRAVE DE LA CONFIANZA Y LA SEGURIDAD EN MI LUGAR DE TRABAJO.', N'PENDIENTE')
INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (2, 2, 2, CAST(N'2023-10-28T17:16:50.680' AS DateTime), N'EL CLIENTE ME AGREDIÓ FÍSICAMENTE MIENTRAS REALIZABA MI TRABAJO. ESTA VIOLENCIA ES INACEPTABLE Y DEBE SER INVESTIGADA ADECUADAMENTE.', N'PENDIENTE')
INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (3, 3, 3, CAST(N'2023-10-28T17:16:50.680' AS DateTime), N'EL CLIENTE ME AMENAZÓ CON CONSECUENCIAS GRAVES SI NO CUMPLÍA CON SUS DEMANDAS FUERA DEL ALCANCE DEL SERVICIO CONTRATADO.', N'PENDIENTE')
INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (4, 4, 4, CAST(N'2023-10-28T17:16:50.680' AS DateTime), N'EL CLIENTE INTENTÓ EXTORSIONARME, EXIGIENDO SERVICIOS ADICIONALES GRATUITOS A CAMBIO DE NO DEJAR UNA MALA RESEÑA O PRESENTAR QUEJAS FALSAS.', N'PENDIENTE')
INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (5, 5, 5, CAST(N'2023-10-28T17:16:50.680' AS DateTime), N'EL CLIENTE SE NEGÓ A PAGAR EL MONTO ACORDADO POR EL SERVICIO PRESTADO, LO QUE CONSTITUYE UN INCUMPLIMIENTO DE CONTRATO POR PARTE DEL CLIENTE.', N'PENDIENTE')
INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (6, 6, 6, CAST(N'2023-10-28T17:16:50.680' AS DateTime), N'EL CLIENTE ME ACOSÓ CON LLAMADAS, MENSAJES Y VISITAS CONSTANTES, CREANDO UN AMBIENTE HOSTIL Y PERTURBADOR PARA MÍ COMO PROFESIONAL.', N'PENDIENTE')
INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (7, 7, 7, CAST(N'2023-10-28T17:16:50.680' AS DateTime), N'EL CLIENTE ME DISCRIMINÓ DEBIDO A MI ORIGEN, GÉNERO, ORIENTACIÓN SEXUAL U OTRA CARACTERÍSTICA PERSONAL, LO QUE ES INACEPTABLE EN CUALQUIER ENTORNO LABORAL.', N'PENDIENTE')
INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (8, 8, 8, CAST(N'2023-10-28T17:16:50.680' AS DateTime), N'EL CLIENTE MOSTRÓ COMPORTAMIENTO RACISTA HACIA MÍ, CREANDO UN AMBIENTE DE TRABAJO HOSTIL Y POCO SEGURO PARA MÍ COMO PROFESIONAL.', N'PENDIENTE')
INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (9, 9, 9, CAST(N'2023-10-28T17:16:50.680' AS DateTime), N'EL CLIENTE ME INSULTÓ CON LENGUAJE OFENSIVO Y DESPECTIVO, AFECTANDO NEGATIVAMENTE MI BIENESTAR EMOCIONAL COMO PROFESIONAL.', N'PENDIENTE')
INSERT [dbo].[DenunciasTecnicos] ([Id_DenunciaTecnico], [Id_DetalleAgenda_DenunciaTecnico], [Id_TipoDenunciaTecnico_DenunciaTecnico], [Fecha_DenunciaTecnico], [Descripcion_DenunciaTecnico], [Estado_DenunciaTecnico]) VALUES (10, 10, 10, CAST(N'2023-10-28T17:16:50.680' AS DateTime), N' EL CLIENTE UTILIZÓ PRÁCTICAS ENGAÑOSAS PARA OBTENER SERVICIOS GRATUITOS O A UN PRECIO SIGNIFICATIVAMENTE REDUCIDO, LO QUE CONSTITUYE UNA ESTAFA EN LA ADQUISICIÓN DEL SERVICIO CONTRATADO.', N'PENDIENTE')
SET IDENTITY_INSERT [dbo].[DenunciasTecnicos] OFF
GO
SET IDENTITY_INSERT [dbo].[Departamentos] ON 

INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (1, N'LIMA')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (2, N'ICA')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (3, N'TUMBES')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (4, N'TACNA')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (5, N'AYACUCHO')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (6, N'PIURA')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (7, N'AREQUIPA')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (8, N'PUNO')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (9, N'CUSCO')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (10, N'CAJAMARCA')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (11, N'MOQUEGUA')
INSERT [dbo].[Departamentos] ([Id_Departamento], [Departamento]) VALUES (12, N'UCAYALI')
SET IDENTITY_INSERT [dbo].[Departamentos] OFF
GO
SET IDENTITY_INSERT [dbo].[DetallesAgendas] ON 

INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (1, 1, 70155892, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. TÚPAC AMARU Nº 7841, MZ C, LOTE 10 – URBANIZACIÓN SAN JUAN BAUTISTA 1ERA. ETAPA', N'TENGO FUGA DE AGUA EN EL CAÑO.', 1, 50, 50, 100, N'COMPLETADO')
INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (2, 2, 70542145, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. UNIVERSITARIA, LT 1, MZ E, URB. EL RETABLO II', N'SE ME PRESENTO UN CORTO CIRCUITO EN EL INTERRUPTOR.', 1, 50, 50, 100, N'COMPLETADO')
INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (3, 3, 70698450, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. CARLOS ALBERTO IZAGUIRRE SUB LOTE 1A MZ B (AV. GERARDO UNGER 3807)', N'QUIERO MEJORAR LAS COLUMNAS DE MI CASA.', 1, 50, 50, 100, N'COMPLETADO')
INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (4, 4, 73698202, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. GENERAL GARZON 1337', N'QUIERO CAMBIAR LA PINTURA DE MI CUARTO.', 1, 50, 50, 100, N'COMPLETADO')
INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (5, 5, 74499210, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. LAS PALMERAS 3854 (IZAGUIRRE CON ANTUNEZ DE MAYOLO)', N'LA CASA DEL ARBOL ESTA EN MAL ESTADO.', 1, 50, 50, 100, N'COMPLETADO')
INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (6, 6, 76648920, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. PRÓCERES DE LA INDEPENDENCIA ESQ CA. LAS FLORE', N'HACER MANTENIMIENTO A MI JARDIN.', 1, 50, 50, 100, N'COMPLETADO')
INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (7, 7, 77662123, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. PROLONGACION MALECON CHECA - MZ L SUB LOTE 1-1A ', N'MI CARRO BOTA ACEITE.', 1, 50, 50, 100, N'COMPLETADO')
INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (8, 8, 78892100, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. ANGAMOS ESTE 1805 SURQUILLO', N'QUIERO LEVANTAR UN SEGUNDO PISO EN MI CASA.', 1, 50, 50, 100, N'COMPLETADO')
INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (9, 9, 79312151, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. PACHACUTEC 3287 - MZ F3 LOTE 14 - PRIMER HOGAR POLICIAL', N'QUIERO LIMPIAR MI CASA PORQUE ESTA CON POLVO.', 1, 50, 50, 100, N'COMPLETADO')
INSERT [dbo].[DetallesAgendas] ([Id_DetalleAgenda], [Id_DatoAgenda_DetalleAgenda], [Id_Consumidor_DetalleAgenda], [FechaTrabajo_DetalleAgenda], [Direccion_DetalleAgenda], [DescripcionTrabajo_DetalleAgenda], [TiempoTrabajo_DetalleAgenda], [PresupuestoManoDeObra_DetalleAgenda], [PresupuestoMaterial_DetalleAgenda], [MontoFinal_DetalleAgenda], [Estado_DetalleAgenda]) VALUES (10, 10, 79984510, CAST(N'2023-11-23T19:00:09.670' AS DateTime), N'AV. LOS HEROES 668-B (URBANIZACION SAN JUAN DE MIRAFLORES PARCELA D MZ B LOTE 13 DPTO 668 EDF.PIS./REF.1)', N'MI REFRIGERADORA ESTA MALOGRADA.', 1, 50, 50, 100, N'COMPLETADO')
SET IDENTITY_INSERT [dbo].[DetallesAgendas] OFF
GO
SET IDENTITY_INSERT [dbo].[Distritos] ON 

INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (1, 1, N'LA VICTORIA')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (2, 1, N'MIRAFLORES')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (3, 1, N'SAN ISIDRO')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (4, 1, N'SAN BORJA')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (5, 1, N'SURCO')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (6, 1, N'CARABAYLLO')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (7, 1, N'COMAS')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (8, 1, N'LOS OLIVOS')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (9, 1, N'JESUS MARIA')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (10, 1, N'VILLA EL SALVADOR')
INSERT [dbo].[Distritos] ([Id_Distrito], [Id_Departamento_Distrito], [Distrito]) VALUES (11, 1, N'VILLA MARIA DEL TRIUNFO')
SET IDENTITY_INSERT [dbo].[Distritos] OFF
GO
SET IDENTITY_INSERT [dbo].[Especialidades] ON 

INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (1, N'GASFITERO')
INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (2, N'ELECTRICISTA')
INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (3, N'ALBAÑIL')
INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (4, N'PINTOR')
INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (5, N'CARPINTERO')
INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (6, N'JARDINERO')
INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (7, N'MECANICO')
INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (8, N'MAESTRO DE OBRAS')
INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (9, N'LIMPIEZA')
INSERT [dbo].[Especialidades] ([Id_Especialidad], [Especialidad]) VALUES (10, N'ELECTRODOMESTICOS')
SET IDENTITY_INSERT [dbo].[Especialidades] OFF
GO
SET IDENTITY_INSERT [dbo].[Membresias] ON 

INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (1, NULL, N'BASICA', NULL, N'PUBLICA TUS SERVICIOS E INTERACTÚA A TRAVÉS DE UN CHAT PERSONALIZADO CON TUS CLIENTES. ADEMÁS DE INFORMES DETALLADOS PARA EL SEGUIMIENTO DE TU TRABAJO MENSUAL.')
INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (2, 1, N'ESTANDAR', 3, N'VISIBILIDAD MEJORADA EN LA PUBLICACION DEL SERVICIO QUE OFRECE, CON OPCIÓN PARA PERSONALIZAR EL PERFIL Y MOSTRAR PORTAFOLIO DE TRABAJOS ANTERIORES.')
INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (3, 2, N'PREMIUM', 9, N'PRIORIDAD EN LA ASIGNACIÓN DE TRABAJOS, VISIBILIDAD DESTACADA EN LAS BÚSQUEDAS DE CLIENTES, Y ACCESO A HERRAMIENTAS AVANZADAS DE GESTIÓN DE CLIENTES Y PAGOS.')
INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (4, 3, N'PRO', 4.2, N'ACCESO A CLIENTES EXCLUSIVOS Y PROYECTOS DE ALTO VALOR, ASIGNACIÓN PREFERENCIAL DE TRABAJOS, Y CAPACITACIONES ESPECIALIZADAS PARA MEJORAR HABILIDADES TÉCNICAS Y DE SERVICIO AL CLIENTE.')
INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (5, 4, N'ELITE', 42.36, N'ACCESO EXCLUSIVO A LOS CLIENTES MÁS PRESTIGIOSOS Y PROYECTOS DE ALTA GAMA, CON SOPORTE PERSONALIZADO, SERVICIOS DE MARKETING ADICIONAL Y TARIFAS PREFERENCIALES EN LA PLATAFORMA.')
INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (6, 5, N'24/7', 2167.74, N'DISPONIBILIDAD PARA TRABAJAR LAS 24 HORAS DEL DÍA, LOS 7 DÍAS DE LA SEMANA, PARA ATENDER EMERGENCIAS Y PROBLEMAS URGENTES DE LOS CLIENTES.')
INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (7, 6, N'ESPECIALISTA', 1.95, N'RECONOCIMIENTO COMO EXPERTO EN UNA CATEGORÍA ESPECÍFICA (POR EJEMPLO, PLOMERÍA, ELECTRICIDAD, ETC.) CON TARIFAS PREMIUM Y ACCESO A CLIENTES QUE BUSCAN SERVICIOS ESPECIALIZADOS.')
INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (8, 7, N'CERTIFICADA', 3.25, N'CERTIFICACIÓN OFICIAL DE HABILIDADES Y EXPERIENCIA, PROPORCIONANDO CONFIANZA ADICIONAL A LOS CLIENTES Y OPORTUNIDADES EXCLUSIVAS DE EMPLEO.')
INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (9, 8, N'EVALUADA', 350.55, N'EVALUACIÓN PERIÓDICA DE LA CALIDAD DEL SERVICIO Y SATISFACCIÓN DEL CLIENTE, CON BONIFICACIONES Y RECOMPENSAS PARA LOS TÉCNICOS MEJOR CALIFICADOS.')
INSERT [dbo].[Membresias] ([Id_Membresia], [Id_TipoMoneda_Membresia], [Nombre_Membresia], [Precio_Membresia], [Descripcion_Membresia]) VALUES (10, 9, N'PREMIUM PLUS', 2.1, N'ACCESO A UN PROGRAMA DE FIDELIDAD PARA CLIENTES RECURRENTES, OFRECIENDO DESCUENTOS ESPECIALES Y SERVICIOS ADICIONALES A LARGO PLAZO, FOMENTANDO LA LEALTAD DEL CLIENTE Y GARANTIZANDO FLUJOS DE TRABAJO CONSISTENTES PARA EL TÉCNICO.')
SET IDENTITY_INSERT [dbo].[Membresias] OFF
GO
SET IDENTITY_INSERT [dbo].[Mensajes] ON 

INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (1, 1, NULL, 70155892, CAST(N'2023-10-26T17:35:59.020' AS DateTime), N'HOLA BUENAS TARDES', NULL)
INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (2, 2, NULL, 70542145, CAST(N'2023-10-26T17:36:08.843' AS DateTime), N'HOLA BUENAS TARDES', NULL)
INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (3, 3, NULL, 70698450, CAST(N'2023-10-26T17:36:08.843' AS DateTime), N'HOLA BUENAS TARDES', NULL)
INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (4, 4, NULL, 73698202, CAST(N'2023-10-26T17:36:08.843' AS DateTime), N'HOLA BUENAS TARDES', NULL)
INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (5, 5, NULL, 74499210, CAST(N'2023-10-26T17:36:08.843' AS DateTime), N'HOLA BUENAS TARDES', NULL)
INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (6, 6, NULL, 76648920, CAST(N'2023-10-26T17:36:08.843' AS DateTime), N'HOLA BUENAS TARDES', NULL)
INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (7, 7, NULL, 77662123, CAST(N'2023-10-26T17:36:08.843' AS DateTime), N'HOLA BUENAS TARDES', NULL)
INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (8, 8, NULL, 78892100, CAST(N'2023-10-26T17:36:08.843' AS DateTime), N'HOLA BUENAS TARDES', NULL)
INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (9, 9, NULL, 79312151, CAST(N'2023-10-26T17:36:08.843' AS DateTime), N'HOLA BUENAS TARDES', NULL)
INSERT [dbo].[Mensajes] ([Id_Mensaje], [Id_Sala_Mensaje], [Id_Tecnico_Mensaje], [Id_Consumidor_Mensaje], [Fecha_Mensaje], [Mensaje], [Contenido]) VALUES (10, 10, NULL, 79984510, CAST(N'2023-10-26T17:36:08.843' AS DateTime), N'HOLA BUENAS TARDES', NULL)
SET IDENTITY_INSERT [dbo].[Mensajes] OFF
GO
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (1, 71169821, 70155892)
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (2, 71169845, 70542145)
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (3, 71465980, 70698450)
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (4, 71465988, 73698202)
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (5, 72158645, 74499210)
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (6, 74675125, 76648920)
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (7, 76507123, 77662123)
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (8, 76648921, 78892100)
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (9, 76698421, 79312151)
INSERT [dbo].[MiembrosSalas] ([Id_Sala_MiembroSala], [Id_Tecnico_MiembroSala], [Id_Consumidor_MiembroSala]) VALUES (10, 79452135, 79984510)
GO
SET IDENTITY_INSERT [dbo].[ReseniasTecnicos] ON 

INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (1, 70155892, 71169821, CAST(N'2023-10-28T03:20:32.933' AS DateTime), 5, N'REALIZO UN BUEN TRABAJO. LO RECOMIENDO.')
INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (2, 70542145, 71169845, CAST(N'2023-10-28T03:20:34.880' AS DateTime), 3, N'LOS PRECIOS SON MUY ELEVADOS.')
INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (3, 70698450, 71465980, CAST(N'2023-10-28T03:20:36.603' AS DateTime), 3, N'EL TRABAJO LO HACE A MEDIAS.')
INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (4, 73698202, 71465988, CAST(N'2023-10-28T03:20:38.110' AS DateTime), 4, N'DEMORA MUCHO EN ACABAR EL TRABAJO PERO LO HACE BIEN.')
INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (5, 74499210, 72158645, CAST(N'2023-10-28T03:20:39.710' AS DateTime), 3, N'NO HACE REBAJAS.')
INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (6, 76648920, 74675125, CAST(N'2023-10-28T03:20:41.177' AS DateTime), 5, N'REALIZO UN BUEN TRABAJO Y SOBRETODO LO TERMINO RAPIDO.')
INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (7, 77662123, 76507123, CAST(N'2023-10-28T03:20:42.503' AS DateTime), 4, N'MUY BUEN TRABAJO.')
INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (8, 78892100, 76648921, CAST(N'2023-10-28T03:20:43.863' AS DateTime), 5, N'EXCELENTE SERVICIO')
INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (9, 79312151, 76698421, CAST(N'2023-10-28T03:20:45.213' AS DateTime), 3, N'ES IMPUNTUAL.')
INSERT [dbo].[ReseniasTecnicos] ([Id_ReseniaTecnico], [Id_Consumidor_ReseniaTecnico], [Id_Tecnico_ReseniaTecnico], [Fecha_ReseniaTecnico], [Puntaje_ReseniaTecnico], [ReseniaTecnico]) VALUES (10, 79984510, 79452135, CAST(N'2023-10-28T03:20:46.517' AS DateTime), 5, N'TRABAJA MUY BIEN.')
SET IDENTITY_INSERT [dbo].[ReseniasTecnicos] OFF
GO
SET IDENTITY_INSERT [dbo].[Salas] ON 

INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (1, CAST(N'2023-10-26T17:32:15.267' AS DateTime))
INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (2, CAST(N'2023-10-26T17:32:17.010' AS DateTime))
INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (3, CAST(N'2023-10-26T17:32:18.463' AS DateTime))
INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (4, CAST(N'2023-10-26T17:32:20.020' AS DateTime))
INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (5, CAST(N'2023-10-26T17:32:21.487' AS DateTime))
INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (6, CAST(N'2023-10-26T17:32:22.703' AS DateTime))
INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (7, CAST(N'2023-10-26T17:32:23.837' AS DateTime))
INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (8, CAST(N'2023-10-26T17:32:25.137' AS DateTime))
INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (9, CAST(N'2023-10-26T17:32:26.697' AS DateTime))
INSERT [dbo].[Salas] ([Id_Sala], [Fecha_Sala]) VALUES (10, CAST(N'2023-10-26T17:32:28.057' AS DateTime))
SET IDENTITY_INSERT [dbo].[Salas] OFF
GO
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (71169821, 10, 3, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-71169821.jpeg', N'PEDRO DANIEL', N'BARDALES MORALES', 23, N'MASCULINO', 988715002, N'PedroBM234@hotmail.com', N'DISPONIBLE', N'ACTIVO')
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (71169845, 5, 8, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-71169845.jpeg', N'CESAR ADRIANO', N'ROMERO VELAZCO', 54, N'MASCULINO', 914687450, N'CesarAdr234@hotmail.com', N'DISPONIBLE', N'ACTIVO')
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (71465980, 8, 9, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-71465980.jpeg', N'SEBASTIAN ISAAC', N'ROJAS BELLIDO', 41, N'MASCULINO', 978216512, N'SebasIsac958@hotmail.com', N'DISPONIBLE', N'ACTIVO')
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (71465988, 1, 5, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-71465988.jpeg', N'FELIPE JOAQUIN', N'DIAZ ALARCON', 45, N'MASCULINO', 900174524, N'FelipDAL45@hotmail.com', N'DISPONIBLE', N'ACTIVO')
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (72158645, 10, 6, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-72158645.jpeg', N'MARTIN ALONSO', N'SALAZAR TAIPE', 35, N'MASCULINO', 980165964, N'MartAlonso234@hotmail.com', N'DISPONIBLE', N'ACTIVO')
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (74675125, 1, 2, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-74675125.jpeg', N'JUAN EMILIO', N'SANCHEZ PEREZ', 32, N'MASCULINO', 945381100, N'JuanP345@hotmail.com', N'DISPONIBLE', N'ACTIVO')
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (76507123, 1, 1, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-76507123.jpeg', N'AARON ELIAS', N'ACUÑA ALARCON', 20, N'MASCULINO', 944935036, N'Aaron3434@hotmail.com', N'DISPONIBLE', N'ACTIVO')
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (76648921, 1, 7, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-76648921.jpeg', N'PIERO JESUS', N'HERNANDEZ QUESADA', 48, N'MASCULINO', 990042587, N'PierJesus321@hotmail.com', N'DISPONIBLE', N'ACTIVO')
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (76698421, 5, 10, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-76698421.jpeg', N'ISRAEL ARMANDO', N'ARELLANO FUENTES', 41, N'MASCULINO', 976542054, N'IsraArman792@hotmail.com', N'DISPONIBLE', N'ACTIVO')
INSERT [dbo].[Tecnicos] ([Id_Tecnico], [Id_Distrito_Tecnico], [Id_Especialidad_Tecnico], [Perfil_Tecnico], [Nombre_Tecnico], [Apellido_Tecnico], [Edad_Tecnico], [Genero_Tecnico], [Contacto_Tecnico], [Correo_Tecnico], [Disponibilidad_Tecnico], [Estado_Tecnico]) VALUES (79452135, 8, 4, N'C:\Estudio\Programacion C#\Desarrollo - Web\Servicios tecnicos\PresentationLayer\Files\Servicios tecnicos\Tecnicos\Perfil\Perfil-79452135.jpeg', N'JOSE MARIA', N'TOLEDO PINEDA', 28, N'MASCULINO', 945678120, N'JoseMarTP546@hotmail.com', N'DISPONIBLE', N'ACTIVO')
GO
SET IDENTITY_INSERT [dbo].[TiposDenunciasConsumidores] ON 

INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (1, N'ESTAFA EN PRECIOS')
INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (2, N'SUPLANTACION DE IDENTIDAD')
INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (3, N'INASISTENCIA')
INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (4, N'TRABAJO MAL HECHO')
INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (5, N'INEXPERIENCIA')
INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (6, N'ROBO')
INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (7, N'AGRESION')
INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (8, N'AMENAZA')
INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (9, N'PRECIO EXCESIVAMENTE ALTO')
INSERT [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor], [TipoDenunciaConsumidor]) VALUES (10, N'EXTORSION')
SET IDENTITY_INSERT [dbo].[TiposDenunciasConsumidores] OFF
GO
SET IDENTITY_INSERT [dbo].[TiposDenunciasTecnicos] ON 

INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (1, N'ROBO')
INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (2, N'AGRESION')
INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (3, N'AMENAZA')
INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (4, N'EXTORSION')
INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (5, N'INCUMPLIMIENTO DE PAGO')
INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (6, N'ACOSO')
INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (7, N'DISCRIMINACION')
INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (8, N'RACISMO')
INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (9, N'INSULTOS')
INSERT [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico], [TipoDenunciaTecnico]) VALUES (10, N'ESTAFA EN ADQUIRIR EL SERVICIO')
SET IDENTITY_INSERT [dbo].[TiposDenunciasTecnicos] OFF
GO
SET IDENTITY_INSERT [dbo].[TiposMonedas] ON 

INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (1, N'DOLARES AMERICANOS')
INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (2, N'SOLES')
INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (3, N'EUROS')
INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (4, N'PESOS MEXICANOS')
INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (5, N'PESOS CHILENOS')
INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (6, N'LIBRAS ESTERLINAS')
INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (7, N'DOLARES CANADIENSES')
INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (8, N'YENES')
INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (9, N'FRANCOS SUIZOS')
INSERT [dbo].[TiposMonedas] ([Id_TipoMoneda], [TipoMoneda]) VALUES (10, N'RENMINBI')
SET IDENTITY_INSERT [dbo].[TiposMonedas] OFF
GO
ALTER TABLE [dbo].[AntecedentesTecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_Tecnico_AntecedenteTecnico] FOREIGN KEY([Id_Tecnico_AntecedenteTecnico])
REFERENCES [dbo].[Tecnicos] ([Id_Tecnico])
GO
ALTER TABLE [dbo].[AntecedentesTecnicos] CHECK CONSTRAINT [FK_Id_Tecnico_AntecedenteTecnico]
GO
ALTER TABLE [dbo].[CodigosConsumidores]  WITH CHECK ADD  CONSTRAINT [FK_Id_Consumidor_CodigoConsumidor] FOREIGN KEY([Id_Consumidor_CodigoConsumidor])
REFERENCES [dbo].[Consumidores] ([Id_Consumidor])
GO
ALTER TABLE [dbo].[CodigosConsumidores] CHECK CONSTRAINT [FK_Id_Consumidor_CodigoConsumidor]
GO
ALTER TABLE [dbo].[CodigosTecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_Tecnico_CodigoTecnico] FOREIGN KEY([Id_Tecnico_CodigoTecnico])
REFERENCES [dbo].[Tecnicos] ([Id_Tecnico])
GO
ALTER TABLE [dbo].[CodigosTecnicos] CHECK CONSTRAINT [FK_Id_Tecnico_CodigoTecnico]
GO
ALTER TABLE [dbo].[ContratosTecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_Membresia_ContratoTecnico] FOREIGN KEY([Id_Membresia_ContratoTecnico])
REFERENCES [dbo].[Membresias] ([Id_Membresia])
GO
ALTER TABLE [dbo].[ContratosTecnicos] CHECK CONSTRAINT [FK_Id_Membresia_ContratoTecnico]
GO
ALTER TABLE [dbo].[ContratosTecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_Tecnico_ContratoTecnico] FOREIGN KEY([Id_Tecnico_ContratoTecnico])
REFERENCES [dbo].[Tecnicos] ([Id_Tecnico])
GO
ALTER TABLE [dbo].[ContratosTecnicos] CHECK CONSTRAINT [FK_Id_Tecnico_ContratoTecnico]
GO
ALTER TABLE [dbo].[DatosAgendas]  WITH CHECK ADD  CONSTRAINT [FK_Id_Tecnico_DatoAgenda] FOREIGN KEY([Id_Tecnico_DatoAgenda])
REFERENCES [dbo].[Tecnicos] ([Id_Tecnico])
GO
ALTER TABLE [dbo].[DatosAgendas] CHECK CONSTRAINT [FK_Id_Tecnico_DatoAgenda]
GO
ALTER TABLE [dbo].[DenunciasConsumidores]  WITH CHECK ADD  CONSTRAINT [FK_Id_DetalleAgenda_DenunciaConsumidor] FOREIGN KEY([Id_DetalleAgenda_DenunciaConsumidor])
REFERENCES [dbo].[DetallesAgendas] ([Id_DetalleAgenda])
GO
ALTER TABLE [dbo].[DenunciasConsumidores] CHECK CONSTRAINT [FK_Id_DetalleAgenda_DenunciaConsumidor]
GO
ALTER TABLE [dbo].[DenunciasConsumidores]  WITH CHECK ADD  CONSTRAINT [FK_Id_TipoDenunciaConsumidor_DenunciaConsumidor] FOREIGN KEY([Id_TipoDenunciaConsumidor_DenunciaConsumidor])
REFERENCES [dbo].[TiposDenunciasConsumidores] ([Id_TipoDenunciaConsumidor])
GO
ALTER TABLE [dbo].[DenunciasConsumidores] CHECK CONSTRAINT [FK_Id_TipoDenunciaConsumidor_DenunciaConsumidor]
GO
ALTER TABLE [dbo].[DenunciasTecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_DetalleAgenda_DenunciaTecnico] FOREIGN KEY([Id_DetalleAgenda_DenunciaTecnico])
REFERENCES [dbo].[DetallesAgendas] ([Id_DetalleAgenda])
GO
ALTER TABLE [dbo].[DenunciasTecnicos] CHECK CONSTRAINT [FK_Id_DetalleAgenda_DenunciaTecnico]
GO
ALTER TABLE [dbo].[DenunciasTecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_TipoDenunciaTecnico_DenunciaTecnico] FOREIGN KEY([Id_TipoDenunciaTecnico_DenunciaTecnico])
REFERENCES [dbo].[TiposDenunciasTecnicos] ([Id_TipoDenunciaTecnico])
GO
ALTER TABLE [dbo].[DenunciasTecnicos] CHECK CONSTRAINT [FK_Id_TipoDenunciaTecnico_DenunciaTecnico]
GO
ALTER TABLE [dbo].[DetallesAgendas]  WITH CHECK ADD  CONSTRAINT [FK_Id_Consumidor_DetalleAgenda] FOREIGN KEY([Id_Consumidor_DetalleAgenda])
REFERENCES [dbo].[Consumidores] ([Id_Consumidor])
GO
ALTER TABLE [dbo].[DetallesAgendas] CHECK CONSTRAINT [FK_Id_Consumidor_DetalleAgenda]
GO
ALTER TABLE [dbo].[DetallesAgendas]  WITH CHECK ADD  CONSTRAINT [FK_Id_DatoAgenda_DetalleAgenda] FOREIGN KEY([Id_DatoAgenda_DetalleAgenda])
REFERENCES [dbo].[DatosAgendas] ([Id_DatoAgenda])
GO
ALTER TABLE [dbo].[DetallesAgendas] CHECK CONSTRAINT [FK_Id_DatoAgenda_DetalleAgenda]
GO
ALTER TABLE [dbo].[Distritos]  WITH CHECK ADD  CONSTRAINT [FK_Id_Departamento_Distrito] FOREIGN KEY([Id_Departamento_Distrito])
REFERENCES [dbo].[Departamentos] ([Id_Departamento])
GO
ALTER TABLE [dbo].[Distritos] CHECK CONSTRAINT [FK_Id_Departamento_Distrito]
GO
ALTER TABLE [dbo].[Membresias]  WITH CHECK ADD  CONSTRAINT [FK_Id_TipoMoneda_Membresia] FOREIGN KEY([Id_TipoMoneda_Membresia])
REFERENCES [dbo].[TiposMonedas] ([Id_TipoMoneda])
GO
ALTER TABLE [dbo].[Membresias] CHECK CONSTRAINT [FK_Id_TipoMoneda_Membresia]
GO
ALTER TABLE [dbo].[Mensajes]  WITH CHECK ADD  CONSTRAINT [FK_Id_Consumidor_Mensaje] FOREIGN KEY([Id_Consumidor_Mensaje])
REFERENCES [dbo].[Consumidores] ([Id_Consumidor])
GO
ALTER TABLE [dbo].[Mensajes] CHECK CONSTRAINT [FK_Id_Consumidor_Mensaje]
GO
ALTER TABLE [dbo].[Mensajes]  WITH CHECK ADD  CONSTRAINT [FK_Id_Sala_Mensaje] FOREIGN KEY([Id_Sala_Mensaje])
REFERENCES [dbo].[Salas] ([Id_Sala])
GO
ALTER TABLE [dbo].[Mensajes] CHECK CONSTRAINT [FK_Id_Sala_Mensaje]
GO
ALTER TABLE [dbo].[Mensajes]  WITH CHECK ADD  CONSTRAINT [FK_Id_Tecnico_Mensaje] FOREIGN KEY([Id_Tecnico_Mensaje])
REFERENCES [dbo].[Tecnicos] ([Id_Tecnico])
GO
ALTER TABLE [dbo].[Mensajes] CHECK CONSTRAINT [FK_Id_Tecnico_Mensaje]
GO
ALTER TABLE [dbo].[MiembrosSalas]  WITH CHECK ADD  CONSTRAINT [FK_Id_Consumidor_MiembroSala] FOREIGN KEY([Id_Consumidor_MiembroSala])
REFERENCES [dbo].[Consumidores] ([Id_Consumidor])
GO
ALTER TABLE [dbo].[MiembrosSalas] CHECK CONSTRAINT [FK_Id_Consumidor_MiembroSala]
GO
ALTER TABLE [dbo].[MiembrosSalas]  WITH CHECK ADD  CONSTRAINT [FK_Id_Sala_MiembroSala] FOREIGN KEY([Id_Sala_MiembroSala])
REFERENCES [dbo].[Salas] ([Id_Sala])
GO
ALTER TABLE [dbo].[MiembrosSalas] CHECK CONSTRAINT [FK_Id_Sala_MiembroSala]
GO
ALTER TABLE [dbo].[MiembrosSalas]  WITH CHECK ADD  CONSTRAINT [FK_Id_Tecnico_MiembroSala] FOREIGN KEY([Id_Tecnico_MiembroSala])
REFERENCES [dbo].[Tecnicos] ([Id_Tecnico])
GO
ALTER TABLE [dbo].[MiembrosSalas] CHECK CONSTRAINT [FK_Id_Tecnico_MiembroSala]
GO
ALTER TABLE [dbo].[ReseniasTecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_Consumidor_ReseniaTecnico] FOREIGN KEY([Id_Consumidor_ReseniaTecnico])
REFERENCES [dbo].[Consumidores] ([Id_Consumidor])
GO
ALTER TABLE [dbo].[ReseniasTecnicos] CHECK CONSTRAINT [FK_Id_Consumidor_ReseniaTecnico]
GO
ALTER TABLE [dbo].[ReseniasTecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_Tecnico_ReseniaTecnico] FOREIGN KEY([Id_Tecnico_ReseniaTecnico])
REFERENCES [dbo].[Tecnicos] ([Id_Tecnico])
GO
ALTER TABLE [dbo].[ReseniasTecnicos] CHECK CONSTRAINT [FK_Id_Tecnico_ReseniaTecnico]
GO
ALTER TABLE [dbo].[Tecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_Distrito_Tecnico] FOREIGN KEY([Id_Distrito_Tecnico])
REFERENCES [dbo].[Distritos] ([Id_Distrito])
GO
ALTER TABLE [dbo].[Tecnicos] CHECK CONSTRAINT [FK_Id_Distrito_Tecnico]
GO
ALTER TABLE [dbo].[Tecnicos]  WITH CHECK ADD  CONSTRAINT [FK_Id_Especialidad_Tecnico] FOREIGN KEY([Id_Especialidad_Tecnico])
REFERENCES [dbo].[Especialidades] ([Id_Especialidad])
GO
ALTER TABLE [dbo].[Tecnicos] CHECK CONSTRAINT [FK_Id_Especialidad_Tecnico]
GO
/****** Object:  StoredProcedure [dbo].[SP_IniciarSesion]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_IniciarSesion]
(
@Id int
)
as
begin

if ((SELECT COUNT(*) FROM CodigosConsumidores WHERE Id_Consumidor_CodigoConsumidor = @Id AND
	 (SELECT Estado_Consumidor FROM Consumidores WHERE Id_Consumidor = @Id) = 'ACTIVO') = 1)
    begin

	SELECT SUBSTRING(CodigoConsumidor, 1, 24) AS Sal, SUBSTRING(CodigoConsumidor, 25, 48) AS Codigo, 'CONSUMIDOR' AS Rol
	FROM CodigosConsumidores WHERE Id_Consumidor_CodigoConsumidor = @Id

	end
else if ((SELECT COUNT(*) FROM CodigosTecnicos WHERE Id_Tecnico_CodigoTecnico = @Id AND
		  (SELECT Estado_Tecnico FROM Tecnicos WHERE Id_Tecnico = @Id) = 'ACTIVO') = 1)
    begin

	SELECT SUBSTRING(CodigoTecnico, 1, 24) AS Sal, SUBSTRING(CodigoTecnico, 25, 48) AS Codigo, 'TECNICO' AS Rol
	FROM CodigosTecnicos WHERE Id_Tecnico_CodigoTecnico = @Id

	end
else if ((SELECT COUNT(*) FROM Administradores WHERE Id_Administrador = @Id) = 1)
    begin

	SELECT SUBSTRING(Codigo_Administrador, 1, 24) AS Sal, SUBSTRING(Codigo_Administrador, 25, 48) AS Codigo, 'ADMINISTRADOR' AS ROL
	FROM Administradores WHERE Id_Administrador = @Id

	end
else
    begin

	SELECT '' AS Sal, '' AS Codigo, '' AS Rol

	end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertarDatos_Consumidores]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- PROCEDIMIENTOS ALMACENADOS WEB - CONSUMIDORES --

CREATE PROCEDURE [dbo].[SP_InsertarDatos_Consumidores]
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
/****** Object:  StoredProcedure [dbo].[SP_InsertarDatos_Denuncias]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertarDatos_Denuncias]
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
/****** Object:  StoredProcedure [dbo].[SP_InsertarDatos_DetallesAgendas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertarDatos_DetallesAgendas]
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

if (@Roll = 'CONSUMIDOR')
    BEGIN

    INSERT INTO DetallesAgendas values (@Id_DatoAgenda_DetalleAgenda, @Id_Consumidor_DetalleAgenda, NULL, @Direccion_DetalleAgenda,
	                                    @DescripcionTrabajo_DetalleAgenda, NULL, NULL, NULL, NULL, 'EN PROCESO')

    END
else if (@Roll = 'TECNICO')
    BEGIN

    if (@Estado_DetalleAgenda = 'DENEGADO')
        BEGIN
    
        UPDATE DetallesAgendas SET Estado_DetalleAgenda = @Estado_DetalleAgenda WHERE Id_DetalleAgenda = @Id_DetalleAgenda
    
    	END
    else if (@Estado_DetalleAgenda = 'PENDIENTE')
        BEGIN
    
        UPDATE DetallesAgendas SET FechaTrabajo_DetalleAgenda = @FechaTrabajo_DetalleAgenda, TiempoTrabajo_DetalleAgenda = @TiempoTrabajo_DetalleAgenda,
                                   PresupuestoManoDeObra_DetalleAgenda = @PresupuestoManoDeObra_DetalleAgenda, PresupuestoMaterial_DetalleAgenda = @PresupuestoMaterial_DetalleAgenda,
    					           MontoFinal_DetalleAgenda = @MontoFinal_DetalleAgenda, Estado_DetalleAgenda = @Estado_DetalleAgenda WHERE Id_DetalleAgenda = @Id_DetalleAgenda
    
    	END
    else if (@Estado_DetalleAgenda = 'COMPLETADO')
        BEGIN
    
        UPDATE DetallesAgendas SET Estado_DetalleAgenda = @Estado_DetalleAgenda WHERE Id_DetalleAgenda = @Id_DetalleAgenda
    
        END
    END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertarDatos_Mensajes]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertarDatos_Mensajes]
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

if (@Roll = 'TECNICO')
    BEGIN
													       
    INSERT INTO Mensajes values (@Id_Sala_Mensaje, @Id_Tecnico_Mensaje, NULL, GETDATE(), @Mensaje, @Contenido)

    END
else if (@Roll = 'CONSUMIDOR')
    BEGIN

	INSERT INTO Mensajes values (@Id_Sala_Mensaje, NULL, @Id_Consumidor_Mensaje, GETDATE(), @Mensaje, @Contenido)

	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertarDatos_ReseniasTecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertarDatos_ReseniasTecnicos]
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
/****** Object:  StoredProcedure [dbo].[SP_InsertarDatos_Salas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertarDatos_Salas]
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
/****** Object:  StoredProcedure [dbo].[SP_InsertarDatos_Tecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertarDatos_Tecnicos]
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

if (((SELECT COUNT(*) FROM Distritos WHERE Distrito LIKE @Distrito + '%'
     AND Id_Departamento_Distrito = (SELECT Id_Departamento FROM Departamentos WHERE Departamento LIKE @Departamento + '%')) = 1)
	 AND ((SELECT COUNT(*) FROM Especialidades WHERE Especialidad = @Especialidad) = 1))
    BEGIN

    DECLARE @Id_Distrito_Tecnico int = (SELECT Id_Distrito FROM Distritos WHERE Distrito LIKE @Distrito + '%'
										AND Id_Departamento_Distrito = (SELECT Id_Departamento FROM Departamentos
																		WHERE Departamento LIKE @Departamento + '%'))

	DECLARE @Id_Especialidad_Tecnico int = (SELECT Id_Especialidad FROM Especialidades WHERE
	                                        Especialidad = @Especialidad)

	INSERT INTO Tecnicos values (@Id_Tecnico, @Id_Distrito_Tecnico, @Id_Especialidad_Tecnico,
	                             @Perfil_Tecnico, @Nombre_Tecnico, @Apellido_Tecnico, @Edad_Tecnico,
								 @Genero_Tecnico, @Contacto_Tecnico, @Correo_Tecnico, 'DISPONIBLE', 'ACTIVO')

    INSERT INTO CodigosTecnicos values (@Id_Tecnico, @CodigoTecnico)

	INSERT INTO AntecedentesTecnicos values (@Id_Tecnico, @DNI_AntecedenteTecnico, @AntecedenteTecnico)

	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_MostrarCitasPendientes_DetallesAgendas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MostrarCitasPendientes_DetallesAgendas]
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
/****** Object:  StoredProcedure [dbo].[SP_MostrarCitasPendientesEnProceso_DetallesAgendas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MostrarCitasPendientesEnProceso_DetallesAgendas]
(
@Id_Tecnico_DatoAgenda int,
@FechaTrabajo_DetalleAgenda Date,
@Estado_DetalleAgenda varchar(20)
)
AS
BEGIN

if (@Estado_DetalleAgenda = 'PENDIENTE')
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
else if (@Estado_DetalleAgenda = 'EN PROCESO')
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
/****** Object:  StoredProcedure [dbo].[SP_MostrarDatos_Especialidades]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MostrarDatos_Especialidades]
AS
BEGIN

SELECT Especialidad FROM Especialidades

END
GO
/****** Object:  StoredProcedure [dbo].[SP_MostrarDatos_Mensajes]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MostrarDatos_Mensajes]
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
/****** Object:  StoredProcedure [dbo].[SP_MostrarDatos_MiembrosSalas]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MostrarDatos_MiembrosSalas]
(
@Id_Tecnico_MiembroSala int,
@Id_Consumidor_MiembroSala int,
@Roll varchar(20)
)
AS
BEGIN

if (@Roll = 'TECNICO')
    BEGIN

	SELECT Id_Sala, Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor FROM Salas
	JOIN (SELECT * FROM MiembrosSalas) TBLMiembrosSalas
	ON Id_Sala = Id_Sala_MiembroSala 
	JOIN (SELECT Id_Consumidor, Nombre_Consumidor, Apellido_Consumidor FROM Consumidores) TBL_Consumidores
	ON Id_Consumidor = Id_Consumidor_MiembroSala
	WHERE Id_Tecnico_MiembroSala = @Id_Tecnico_MiembroSala

    END
else if (@Roll = 'CONSUMIDOR')
    BEGIN

    SELECT Id_Sala, Id_Tecnico, Nombre_Tecnico, Apellido_Tecnico FROM Salas
	JOIN (SELECT * FROM MiembrosSalas) TBLMiembrosSalas
	ON Id_Sala = Id_Sala_MiembroSala 
	JOIN (SELECT Id_Tecnico, Nombre_Tecnico, Apellido_Tecnico FROM Tecnicos) TBL_Tecnicos
	ON Id_Tecnico = Id_Tecnico_MiembroSala
	WHERE Id_Consumidor_MiembroSala = @Id_Consumidor_MiembroSala

    END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_MostrarInformacionGeneral_Tecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MostrarInformacionGeneral_Tecnicos]
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
/****** Object:  StoredProcedure [dbo].[SP_MostrarReporteDetallado_Tecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MostrarReporteDetallado_Tecnicos]
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
/****** Object:  Trigger [dbo].[TG_InsertarDatos_Tecnicos]    Script Date: 23/11/2023 19:28:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TG_InsertarDatos_Tecnicos]
ON [dbo].[Tecnicos] FOR INSERT
AS
SET NOCOUNT ON

INSERT INTO DatosAgendas values ((SELECT inserted.Id_Tecnico FROM inserted), GETDATE())

GO
ALTER TABLE [dbo].[Tecnicos] ENABLE TRIGGER [TG_InsertarDatos_Tecnicos]
GO
ALTER DATABASE [ServiciosTecnicos] SET  READ_WRITE 
GO