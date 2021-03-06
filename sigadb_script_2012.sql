USE [master]
GO
/****** Object:  Database [SIGA]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE DATABASE [SIGA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SIGA', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER_12\MSSQL\DATA\SIGA.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SIGA_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER_12\MSSQL\DATA\SIGA_log.ldf' , SIZE = 1600KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SIGA] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SIGA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SIGA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SIGA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SIGA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SIGA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SIGA] SET ARITHABORT OFF 
GO
ALTER DATABASE [SIGA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SIGA] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SIGA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SIGA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SIGA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SIGA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SIGA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SIGA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SIGA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SIGA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SIGA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SIGA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SIGA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SIGA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SIGA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SIGA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SIGA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SIGA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SIGA] SET RECOVERY FULL 
GO
ALTER DATABASE [SIGA] SET  MULTI_USER 
GO
ALTER DATABASE [SIGA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SIGA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SIGA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SIGA] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SIGA', N'ON'
GO
USE [SIGA]
GO
/****** Object:  StoredProcedure [dbo].[Usuario.Get]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Usuario.Get]
	 @UserID			INT				= 0
	,@PrimerNombre		varchar(50)		= ''
	,@ApellidoPaterno	varchar(50)		= ''
	,@Email				varchar(200)	= ''
	,@TipoUsuario		varchar(50)		= ''

as

/* Test Section

	exec [dbo].[Usuario.Get]
		 @UserID			= ''
		,@PrimerNombre		= ''
		,@ApellidoPaterno	= ''
		,@Email				= ''
		,@TipoUsuario		= 'Todos'

*/


select
	 ROW_NUMBER() OVER (ORDER BY u.User_Id) as record_number
	,u.User_Id
	,per.Per_Id
	,tu.TipoUser_Id
	,pro.Prof_Id
	,Per.Per_Dni
	,tu.TipoUser_Nivel
	,tu.TipoUser_Descrip
	,per.Per_Nombre
	,per.Per_ApePaterno
	,per.Per_ApeMaterno
	,per.Per_Sexo
	,per.Per_Dir
	,per.Per_Cel
	,per.Per_Tel
	,per.Per_Email
	,u.User_Nombre
	,u.User_Pass
	,u.User_Inactivo
	,pro.Prof_Especialidad
	,al.Alu_Apoderado
	,al.Alu_FechaIngreso
	,al.Alu_FechaRegistro

into #UsuarioDetails
from [dbo].[Usuario] u
inner join [dbo].[TipoUsuario] tu
	on u.TipoUser_Id = tu.TipoUser_Id
inner join [dbo].[Persona] per
	on per.Per_Id = u.Per_Id
left join [dbo].[Profesor] pro
	on u.[User_Id] = pro.[User_Id]
left join [dbo].[Alumno] al
	on u.[User_Id] = al.[User_Id]
left join [dbo].[Administrador] ad
	on u.[User_Id] = ad.[User_Id]

where 
		(
			@TipoUsuario	= 'Todos'
			or
			tu.TipoUser_Descrip	=	@TipoUsuario
		)
	and (
			@PrimerNombre	= ''
			or
			per.Per_Nombre	like  '%' + @PrimerNombre + '%'
		)
	and (
			@ApellidoPaterno	= ''
			or
			per.Per_ApePaterno	like  '%' + @ApellidoPaterno + '%'
		)
	and (
			@Email	= ''
			or
			Per_Email like  '%' + @Email + '%'
		)
	and (
			@UserID	= 0
			or
			u.User_Id = @UserID
		)
	and Isnull(u.User_Inactivo,0) = 0
	

select * from #UsuarioDetails
GO
/****** Object:  Table [dbo].[Administrador]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Administrador](
	[Adm_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_Id] [int] NOT NULL,
	[Adm_Area] [varchar](50) NULL,
	[Adm_Rpm] [char](12) NULL,
	[Adm_Nextel] [char](12) NOT NULL,
 CONSTRAINT [PK_Administrador] PRIMARY KEY CLUSTERED 
(
	[Adm_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Alumno]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Alumno](
	[Alu_Id] [int] IDENTITY(1,1) NOT NULL,
	[User_Id] [int] NOT NULL,
	[Alu_Apoderado] [varchar](50) NULL,
	[Alu_Estado] [bit] NULL,
	[Alu_Foto] [varchar](200) NULL,
	[Alu_FechaIngreso] [datetime] NOT NULL,
	[Alu_FechaRegistro] [datetime] NOT NULL,
 CONSTRAINT [PK_Alumno] PRIMARY KEY CLUSTERED 
(
	[Alu_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Aula]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Aula](
	[Aul_Id] [int] IDENTITY(1,1) NOT NULL,
	[Aul_Capacidad] [varchar](50) NULL,
 CONSTRAINT [PK_Aula] PRIMARY KEY CLUSTERED 
(
	[Aul_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Author]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Biography] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Author] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Calificacion]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Calificacion](
	[User_Id] [int] NOT NULL,
	[Cur_Id] [int] NOT NULL,
	[Cal_Fech] [datetime] NULL,
	[Cal_Condicion] [varchar](50) NOT NULL,
	[Cal_Practica] [decimal](12, 2) NOT NULL,
	[Cal_Teorica] [decimal](12, 2) NOT NULL,
	[Cal_Oral] [decimal](12, 2) NULL,
	[Cal_Otros] [decimal](12, 2) NULL,
 CONSTRAINT [PK_Calificacion] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC,
	[Cur_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Curso]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Curso](
	[Cur_Id] [int] IDENTITY(1,1) NOT NULL,
	[Cur_Name] [varchar](50) NULL,
	[Cur_NumHoras] [int] NULL,
	[Cur_Precio] [nchar](10) NULL,
 CONSTRAINT [PK_Curso] PRIMARY KEY CLUSTERED 
(
	[Cur_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Horario]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Horario](
	[Hor_Id] [int] IDENTITY(1,1) NOT NULL,
	[Hor_HoraIni] [time](7) NULL,
	[Hor_Dia] [varchar](50) NULL,
	[Hor_Turno] [varchar](50) NULL,
	[Hor_HoraFin] [time](7) NULL,
 CONSTRAINT [PK_Horario] PRIMARY KEY CLUSTERED 
(
	[Hor_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Matricula]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Matricula](
	[Mat_Id] [int] IDENTITY(1,1) NOT NULL,
	[Cur_Id] [int] NOT NULL,
	[User_Id] [int] NOT NULL,
	[Rec_Id] [int] NOT NULL,
	[Mat_Tipo] [varchar](50) NULL,
	[Mat_Fecha] [datetime] NOT NULL,
	[Mat_Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Matricula] PRIMARY KEY CLUSTERED 
(
	[Mat_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Modulo]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Modulo](
	[Mod_Id] [int] IDENTITY(1,1) NOT NULL,
	[Mod_Nombre] [varchar](50) NOT NULL,
	[Mod_Tipo] [varchar](50) NOT NULL,
	[Mod_Unidad] [varchar](50) NULL,
	[Mod_NumHoras] [varchar](50) NULL,
	[Mod_NumMes] [varchar](50) NOT NULL,
	[Mod_NumCursos] [nchar](10) NULL,
	[Mod_Nivel] [int] NOT NULL,
 CONSTRAINT [PK_Modulo] PRIMARY KEY CLUSTERED 
(
	[Mod_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ModuloCurso]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuloCurso](
	[Mod_Id] [int] NOT NULL,
	[Cur_Id] [int] NOT NULL,
 CONSTRAINT [PK_ModuloCurso] PRIMARY KEY CLUSTERED 
(
	[Mod_Id] ASC,
	[Cur_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pago]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pago](
	[Pag_Id] [int] IDENTITY(1,1) NOT NULL,
	[Alu_Id] [int] NULL,
	[Pag_Fech] [datetime] NULL,
 CONSTRAINT [PK_Pago] PRIMARY KEY CLUSTERED 
(
	[Pag_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Persona]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Persona](
	[Per_Id] [int] IDENTITY(1,1) NOT NULL,
	[Per_Dni] [int] NULL,
	[Per_Nombre] [varchar](50) NOT NULL,
	[Per_ApePaterno] [varchar](50) NOT NULL,
	[Per_ApeMaterno] [varchar](50) NOT NULL,
	[Per_Sexo] [char](1) NULL,
	[Per_Dir] [varchar](50) NULL,
	[Per_Cel] [char](9) NULL,
	[Per_Tel] [varchar](20) NULL,
	[Per_Email] [varchar](50) NOT NULL,
	[Per_FechaNacimiento] [datetime] NULL,
 CONSTRAINT [PK_Persona] PRIMARY KEY CLUSTERED 
(
	[Per_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profesor](
	[Prof_Id] [int] IDENTITY(1,1) NOT NULL,
	[User_Id] [int] NOT NULL,
	[Cur_Id] [int] NOT NULL,
	[Prof_Especialidad] [varchar](50) NULL,
 CONSTRAINT [PK_Profesor] PRIMARY KEY CLUSTERED 
(
	[Prof_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Programacion]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Programacion](
	[Prog_Id] [int] IDENTITY(1,1) NOT NULL,
	[Mod_Id] [int] NOT NULL,
	[Aul_Id] [int] NOT NULL,
	[Hor_Id] [int] NOT NULL,
	[Prog_Nombre] [varchar](100) NOT NULL,
	[Prog_FechaInicio] [datetime] NULL,
 CONSTRAINT [PK_Programacion] PRIMARY KEY CLUSTERED 
(
	[Prog_Id] ASC,
	[Aul_Id] ASC,
	[Hor_Id] ASC,
	[Mod_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Recibo]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recibo](
	[Rec_Id] [int] NOT NULL,
	[User_Id] [int] NOT NULL,
	[Pag_Id] [int] NOT NULL,
 CONSTRAINT [PK_Recibo] PRIMARY KEY CLUSTERED 
(
	[Rec_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoUsuario]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoUsuario](
	[TipoUser_Id] [int] IDENTITY(1,1) NOT NULL,
	[TipoUser_Descrip] [varchar](50) NULL,
	[TipoUser_Nivel] [tinyint] NOT NULL,
 CONSTRAINT [PK_TipoUsuario] PRIMARY KEY CLUSTERED 
(
	[TipoUser_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 11/14/2015 7:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[User_Id] [int] IDENTITY(1,1) NOT NULL,
	[Per_Id] [int] NOT NULL,
	[TipoUser_Id] [int] NOT NULL,
	[User_Nombre] [varchar](50) NULL,
	[User_Pass] [varchar](20) NULL,
	[User_Inactivo] [bit] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Alumno] ON 

INSERT [dbo].[Alumno] ([Alu_Id], [User_Id], [Alu_Apoderado], [Alu_Estado], [Alu_Foto], [Alu_FechaIngreso], [Alu_FechaRegistro]) VALUES (1, 35, N'', 1, NULL, CAST(0x0000A45800000000 AS DateTime), CAST(0x0000A5480091F0F6 AS DateTime))
INSERT [dbo].[Alumno] ([Alu_Id], [User_Id], [Alu_Apoderado], [Alu_Estado], [Alu_Foto], [Alu_FechaIngreso], [Alu_FechaRegistro]) VALUES (2, 36, N'', 1, NULL, CAST(0x0000A45800000000 AS DateTime), CAST(0x0000A54800A0C9EE AS DateTime))
INSERT [dbo].[Alumno] ([Alu_Id], [User_Id], [Alu_Apoderado], [Alu_Estado], [Alu_Foto], [Alu_FechaIngreso], [Alu_FechaRegistro]) VALUES (3, 37, NULL, 1, NULL, CAST(0x0000A45800000000 AS DateTime), CAST(0x0000A54800A19F32 AS DateTime))
INSERT [dbo].[Alumno] ([Alu_Id], [User_Id], [Alu_Apoderado], [Alu_Estado], [Alu_Foto], [Alu_FechaIngreso], [Alu_FechaRegistro]) VALUES (4, 38, NULL, 1, NULL, CAST(0x0000A45800000000 AS DateTime), CAST(0x0000A54D00755927 AS DateTime))
INSERT [dbo].[Alumno] ([Alu_Id], [User_Id], [Alu_Apoderado], [Alu_Estado], [Alu_Foto], [Alu_FechaIngreso], [Alu_FechaRegistro]) VALUES (5, 39, NULL, 1, NULL, CAST(0x0000A45800000000 AS DateTime), CAST(0x0000A54D007C8349 AS DateTime))
SET IDENTITY_INSERT [dbo].[Alumno] OFF
SET IDENTITY_INSERT [dbo].[Author] ON 

INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [Biography]) VALUES (1, N'Jamie', N'Munro', N'...')
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [Biography]) VALUES (2, N'dhfgjh', N'portal', N'soy lo que soy')
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [Biography]) VALUES (3, N'carlos', N'flores', N'werg')
SET IDENTITY_INSERT [dbo].[Author] OFF
SET IDENTITY_INSERT [dbo].[Persona] ON 

INSERT [dbo].[Persona] ([Per_Id], [Per_Dni], [Per_Nombre], [Per_ApePaterno], [Per_ApeMaterno], [Per_Sexo], [Per_Dir], [Per_Cel], [Per_Tel], [Per_Email], [Per_FechaNacimiento]) VALUES (35, 32165487, N'Luis', N'Florez', N'Meza', N' ', N'Barranca beleguia', N'         ', N'', N'luisf@gmail.com', NULL)
INSERT [dbo].[Persona] ([Per_Id], [Per_Dni], [Per_Nombre], [Per_ApePaterno], [Per_ApeMaterno], [Per_Sexo], [Per_Dir], [Per_Cel], [Per_Tel], [Per_Email], [Per_FechaNacimiento]) VALUES (36, 123456789, N'Cesar', N'Perez', N'Contreras', N' ', N'', N'         ', N'', N'cesarc@gmail.com', NULL)
INSERT [dbo].[Persona] ([Per_Id], [Per_Dni], [Per_Nombre], [Per_ApePaterno], [Per_ApeMaterno], [Per_Sexo], [Per_Dir], [Per_Cel], [Per_Tel], [Per_Email], [Per_FechaNacimiento]) VALUES (37, NULL, N'Richard', N'Cavero', N'Canales', NULL, NULL, NULL, NULL, N'richardc@gmail.com', NULL)
INSERT [dbo].[Persona] ([Per_Id], [Per_Dni], [Per_Nombre], [Per_ApePaterno], [Per_ApeMaterno], [Per_Sexo], [Per_Dir], [Per_Cel], [Per_Tel], [Per_Email], [Per_FechaNacimiento]) VALUES (38, NULL, N'Carlos', N'Reyna', N'Rojas', NULL, NULL, NULL, NULL, N'carlosr@gmail.com', NULL)
INSERT [dbo].[Persona] ([Per_Id], [Per_Dni], [Per_Nombre], [Per_ApePaterno], [Per_ApeMaterno], [Per_Sexo], [Per_Dir], [Per_Cel], [Per_Tel], [Per_Email], [Per_FechaNacimiento]) VALUES (39, NULL, N'fghjdfghj', N'ghjfghj', N'fghjfghj', NULL, NULL, NULL, NULL, N'fghjfghj', NULL)
SET IDENTITY_INSERT [dbo].[Persona] OFF
SET IDENTITY_INSERT [dbo].[TipoUsuario] ON 

INSERT [dbo].[TipoUsuario] ([TipoUser_Id], [TipoUser_Descrip], [TipoUser_Nivel]) VALUES (1, N'Alumno', 1)
SET IDENTITY_INSERT [dbo].[TipoUsuario] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([User_Id], [Per_Id], [TipoUser_Id], [User_Nombre], [User_Pass], [User_Inactivo]) VALUES (35, 35, 1, N'usename', N'', NULL)
INSERT [dbo].[Usuario] ([User_Id], [Per_Id], [TipoUser_Id], [User_Nombre], [User_Pass], [User_Inactivo]) VALUES (36, 36, 1, N'usename', N'', NULL)
INSERT [dbo].[Usuario] ([User_Id], [Per_Id], [TipoUser_Id], [User_Nombre], [User_Pass], [User_Inactivo]) VALUES (37, 37, 1, NULL, NULL, NULL)
INSERT [dbo].[Usuario] ([User_Id], [Per_Id], [TipoUser_Id], [User_Nombre], [User_Pass], [User_Inactivo]) VALUES (38, 38, 1, NULL, NULL, NULL)
INSERT [dbo].[Usuario] ([User_Id], [Per_Id], [TipoUser_Id], [User_Nombre], [User_Pass], [User_Inactivo]) VALUES (39, 39, 1, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
/****** Object:  Index [IX_FK_Administrador_Usuario]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Administrador_Usuario] ON [dbo].[Administrador]
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Alumno_Usuario]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Alumno_Usuario] ON [dbo].[Alumno]
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Calificacion_Curso]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Calificacion_Curso] ON [dbo].[Calificacion]
(
	[Cur_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Matricula_Curso]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Matricula_Curso] ON [dbo].[Matricula]
(
	[Cur_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Matricula_Recibo]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Matricula_Recibo] ON [dbo].[Matricula]
(
	[Rec_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Profesor_Curso]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Profesor_Curso] ON [dbo].[Profesor]
(
	[Cur_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Profesor_Usuario1]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Profesor_Usuario1] ON [dbo].[Profesor]
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Programacion_Aula]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Programacion_Aula] ON [dbo].[Programacion]
(
	[Aul_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Programacion_Horario]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Programacion_Horario] ON [dbo].[Programacion]
(
	[Hor_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Recibo_Pago]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Recibo_Pago] ON [dbo].[Recibo]
(
	[Pag_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Usuario_Persona]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Usuario_Persona] ON [dbo].[Usuario]
(
	[Per_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Usuario_Tipo_Usuario]    Script Date: 11/14/2015 7:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Usuario_Tipo_Usuario] ON [dbo].[Usuario]
(
	[TipoUser_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Administrador]  WITH CHECK ADD  CONSTRAINT [FK_Administrador_Usuario] FOREIGN KEY([User_Id])
REFERENCES [dbo].[Usuario] ([User_Id])
GO
ALTER TABLE [dbo].[Administrador] CHECK CONSTRAINT [FK_Administrador_Usuario]
GO
ALTER TABLE [dbo].[Alumno]  WITH CHECK ADD  CONSTRAINT [FK_Alumno_Usuario] FOREIGN KEY([User_Id])
REFERENCES [dbo].[Usuario] ([User_Id])
GO
ALTER TABLE [dbo].[Alumno] CHECK CONSTRAINT [FK_Alumno_Usuario]
GO
ALTER TABLE [dbo].[Calificacion]  WITH CHECK ADD  CONSTRAINT [FK_Calificacion_Curso] FOREIGN KEY([Cur_Id])
REFERENCES [dbo].[Curso] ([Cur_Id])
GO
ALTER TABLE [dbo].[Calificacion] CHECK CONSTRAINT [FK_Calificacion_Curso]
GO
ALTER TABLE [dbo].[Matricula]  WITH CHECK ADD  CONSTRAINT [FK_Matricula_Curso] FOREIGN KEY([Cur_Id])
REFERENCES [dbo].[Curso] ([Cur_Id])
GO
ALTER TABLE [dbo].[Matricula] CHECK CONSTRAINT [FK_Matricula_Curso]
GO
ALTER TABLE [dbo].[Matricula]  WITH CHECK ADD  CONSTRAINT [FK_Matricula_Recibo] FOREIGN KEY([Rec_Id])
REFERENCES [dbo].[Recibo] ([Rec_Id])
GO
ALTER TABLE [dbo].[Matricula] CHECK CONSTRAINT [FK_Matricula_Recibo]
GO
ALTER TABLE [dbo].[ModuloCurso]  WITH CHECK ADD  CONSTRAINT [FK_ModuloCurso_Curso] FOREIGN KEY([Cur_Id])
REFERENCES [dbo].[Curso] ([Cur_Id])
GO
ALTER TABLE [dbo].[ModuloCurso] CHECK CONSTRAINT [FK_ModuloCurso_Curso]
GO
ALTER TABLE [dbo].[ModuloCurso]  WITH CHECK ADD  CONSTRAINT [FK_ModuloCurso_Modulo] FOREIGN KEY([Mod_Id])
REFERENCES [dbo].[Modulo] ([Mod_Id])
GO
ALTER TABLE [dbo].[ModuloCurso] CHECK CONSTRAINT [FK_ModuloCurso_Modulo]
GO
ALTER TABLE [dbo].[Profesor]  WITH CHECK ADD  CONSTRAINT [FK_Profesor_Curso] FOREIGN KEY([Cur_Id])
REFERENCES [dbo].[Curso] ([Cur_Id])
GO
ALTER TABLE [dbo].[Profesor] CHECK CONSTRAINT [FK_Profesor_Curso]
GO
ALTER TABLE [dbo].[Profesor]  WITH CHECK ADD  CONSTRAINT [FK_Profesor_Usuario1] FOREIGN KEY([User_Id])
REFERENCES [dbo].[Usuario] ([User_Id])
GO
ALTER TABLE [dbo].[Profesor] CHECK CONSTRAINT [FK_Profesor_Usuario1]
GO
ALTER TABLE [dbo].[Programacion]  WITH CHECK ADD  CONSTRAINT [FK_Programacion_Aula] FOREIGN KEY([Aul_Id])
REFERENCES [dbo].[Aula] ([Aul_Id])
GO
ALTER TABLE [dbo].[Programacion] CHECK CONSTRAINT [FK_Programacion_Aula]
GO
ALTER TABLE [dbo].[Programacion]  WITH CHECK ADD  CONSTRAINT [FK_Programacion_Horario] FOREIGN KEY([Hor_Id])
REFERENCES [dbo].[Horario] ([Hor_Id])
GO
ALTER TABLE [dbo].[Programacion] CHECK CONSTRAINT [FK_Programacion_Horario]
GO
ALTER TABLE [dbo].[Programacion]  WITH CHECK ADD  CONSTRAINT [FK_Programacion_Modulo] FOREIGN KEY([Mod_Id])
REFERENCES [dbo].[Modulo] ([Mod_Id])
GO
ALTER TABLE [dbo].[Programacion] CHECK CONSTRAINT [FK_Programacion_Modulo]
GO
ALTER TABLE [dbo].[Recibo]  WITH CHECK ADD  CONSTRAINT [FK_Recibo_Pago] FOREIGN KEY([Pag_Id])
REFERENCES [dbo].[Pago] ([Pag_Id])
GO
ALTER TABLE [dbo].[Recibo] CHECK CONSTRAINT [FK_Recibo_Pago]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Persona] FOREIGN KEY([Per_Id])
REFERENCES [dbo].[Persona] ([Per_Id])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Persona]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Tipo_Usuario] FOREIGN KEY([TipoUser_Id])
REFERENCES [dbo].[TipoUsuario] ([TipoUser_Id])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Tipo_Usuario]
GO
USE [master]
GO
ALTER DATABASE [SIGA] SET  READ_WRITE 
GO
