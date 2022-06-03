USE [master]
GO
/****** Object:  Database [SuperiorBD]    Script Date: 21/05/2022 18:57:34 ******/
CREATE DATABASE [SuperiorBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SuperiorBD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SuperiorBD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SuperiorBD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SuperiorBD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SuperiorBD] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SuperiorBD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SuperiorBD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SuperiorBD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SuperiorBD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SuperiorBD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SuperiorBD] SET ARITHABORT OFF 
GO
ALTER DATABASE [SuperiorBD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SuperiorBD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SuperiorBD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SuperiorBD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SuperiorBD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SuperiorBD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SuperiorBD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SuperiorBD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SuperiorBD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SuperiorBD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SuperiorBD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SuperiorBD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SuperiorBD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SuperiorBD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SuperiorBD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SuperiorBD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SuperiorBD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SuperiorBD] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SuperiorBD] SET  MULTI_USER 
GO
ALTER DATABASE [SuperiorBD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SuperiorBD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SuperiorBD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SuperiorBD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SuperiorBD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SuperiorBD] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SuperiorBD] SET QUERY_STORE = OFF
GO
USE [SuperiorBD]
GO
/****** Object:  Table [dbo].[Asistencia]    Script Date: 21/05/2022 18:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asistencia](
	[idAsistencia] [int] NOT NULL,
	[Persona_Rol] [int] NULL,
	[entrada] [datetime] NULL,
	[salida] [datetime] NULL,
 CONSTRAINT [PK_Asistencia] PRIMARY KEY CLUSTERED 
(
	[idAsistencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalle_Registro]    Script Date: 21/05/2022 18:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Registro](
	[idDetalle_Registro] [int] NOT NULL,
	[Registro] [int] NULL,
	[Producto] [int] NULL,
	[peso_detalle_registro] [decimal](18, 2) NULL,
	[cantidad] [bigint] NULL,
	[precio_total] [money] NULL,
 CONSTRAINT [PK_Detalle_Registro] PRIMARY KEY CLUSTERED 
(
	[idDetalle_Registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 21/05/2022 18:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[idPersona] [int] NOT NULL,
	[nombre] [varchar](255) NULL,
	[apellido_paterno] [varchar](255) NULL,
	[apellido_materno] [varchar](255) NULL,
	[razon_social] [varchar](255) NULL,
	[Tipo_Documento] [int] NOT NULL,
	[numero_documento] [varchar](15) NOT NULL,
	[direccion] [varchar](255) NOT NULL,
	[fecha_nacimiento] [date] NULL,
	[correo_electronico] [nvarchar](255) NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[idPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas_Roles]    Script Date: 21/05/2022 18:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas_Roles](
	[idPersona_Rol] [int] NOT NULL,
	[Persona] [int] NULL,
	[Rol] [int] NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Personas_Roles] PRIMARY KEY CLUSTERED 
(
	[idPersona_Rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 21/05/2022 18:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[idProducto] [int] NOT NULL,
	[nombre_producto] [nvarchar](255) NULL,
	[descripcion_producto] [nvarchar](255) NULL,
	[precio] [money] NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registros_Inventario]    Script Date: 21/05/2022 18:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registros_Inventario](
	[idRegistro_Inventario] [int] NOT NULL,
	[notas] [nvarchar](255) NULL,
	[fecha] [date] NULL,
	[Persona_Rol] [int] NULL,
	[precio_total] [money] NULL,
 CONSTRAINT [PK_Registros_Inventario] PRIMARY KEY CLUSTERED 
(
	[idRegistro_Inventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 21/05/2022 18:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[idRoles] [int] NOT NULL,
	[rol] [varchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[idRoles] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_Documento]    Script Date: 21/05/2022 18:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Documento](
	[idTipo_Documento] [int] NOT NULL,
	[tipo_documento] [varchar](255) NULL,
 CONSTRAINT [PK_Tipo_Documento] PRIMARY KEY CLUSTERED 
(
	[idTipo_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 21/05/2022 18:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[idUsuario] [int] NOT NULL,
	[nombre_usuario] [nvarchar](255) NULL,
	[password] [nvarchar](255) NULL,
	[Persona_Rol] [int] NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Asistencia]  WITH CHECK ADD  CONSTRAINT [FK_Asistencia_Personas_Roles] FOREIGN KEY([Persona_Rol])
REFERENCES [dbo].[Personas_Roles] ([idPersona_Rol])
GO
ALTER TABLE [dbo].[Asistencia] CHECK CONSTRAINT [FK_Asistencia_Personas_Roles]
GO
ALTER TABLE [dbo].[Detalle_Registro]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Registro_Productos] FOREIGN KEY([Producto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[Detalle_Registro] CHECK CONSTRAINT [FK_Detalle_Registro_Productos]
GO
ALTER TABLE [dbo].[Detalle_Registro]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Registro_Registros_Inventario] FOREIGN KEY([Registro])
REFERENCES [dbo].[Registros_Inventario] ([idRegistro_Inventario])
GO
ALTER TABLE [dbo].[Detalle_Registro] CHECK CONSTRAINT [FK_Detalle_Registro_Registros_Inventario]
GO
ALTER TABLE [dbo].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Tipo_Documento] FOREIGN KEY([Tipo_Documento])
REFERENCES [dbo].[Tipo_Documento] ([idTipo_Documento])
GO
ALTER TABLE [dbo].[Personas] CHECK CONSTRAINT [FK_Personas_Tipo_Documento]
GO
ALTER TABLE [dbo].[Personas_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Roles_Personas] FOREIGN KEY([Persona])
REFERENCES [dbo].[Personas] ([idPersona])
GO
ALTER TABLE [dbo].[Personas_Roles] CHECK CONSTRAINT [FK_Personas_Roles_Personas]
GO
ALTER TABLE [dbo].[Personas_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Roles_Roles] FOREIGN KEY([Rol])
REFERENCES [dbo].[Roles] ([idRoles])
GO
ALTER TABLE [dbo].[Personas_Roles] CHECK CONSTRAINT [FK_Personas_Roles_Roles]
GO
ALTER TABLE [dbo].[Registros_Inventario]  WITH CHECK ADD  CONSTRAINT [FK_Registros_Inventario_Personas_Roles] FOREIGN KEY([Persona_Rol])
REFERENCES [dbo].[Personas_Roles] ([idPersona_Rol])
GO
ALTER TABLE [dbo].[Registros_Inventario] CHECK CONSTRAINT [FK_Registros_Inventario_Personas_Roles]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Personas_Roles] FOREIGN KEY([Persona_Rol])
REFERENCES [dbo].[Personas_Roles] ([idPersona_Rol])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Personas_Roles]
GO
USE [master]
GO
ALTER DATABASE [SuperiorBD] SET  READ_WRITE 
GO
