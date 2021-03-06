USE [SIGA]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 10/29/2015 10:19:51 PM ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'NT AUTHORITY\SYSTEM'
GO
/****** Object:  Table [dbo].[Administrador]    Script Date: 10/29/2015 10:19:52 PM ******/
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
/****** Object:  Table [dbo].[Alumno]    Script Date: 10/29/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Alumno](
	[Alu_Id] [int] IDENTITY(1,1) NOT NULL,
	[User_Id] [int] NOT NULL,
	[Alu_FechNac] [date] NULL,
	[Alu_Apoderado] [varchar](50) NULL,
	[Alu_FechIngreso] [datetime] NOT NULL,
	[Alu_Estado] [bit] NOT NULL,
	[Alu_Foto] [varchar](200) NULL,
 CONSTRAINT [PK_Alumno] PRIMARY KEY CLUSTERED 
(
	[Alu_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Aula]    Script Date: 10/29/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Aula](
	[Aul_Id] [int] IDENTITY(100,100) NOT NULL,
	[Aul_Capacidad] [varchar](50) NULL,
 CONSTRAINT [PK_Aula] PRIMARY KEY CLUSTERED 
(
	[Aul_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Calificacion]    Script Date: 10/29/2015 10:19:52 PM ******/
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
/****** Object:  Table [dbo].[Curso]    Script Date: 10/29/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Curso](
	[Cur_Id] [int] IDENTITY(1,1) NOT NULL,
	[Mod_Id] [int] NOT NULL,
	[Prog_Id] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Horario]    Script Date: 10/29/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Horario](
	[Hor_Id] [int] IDENTITY(1,1) NOT NULL,
	[Hor_Grupo] [varchar](50) NULL,
	[Hor_Ini] [time](7) NULL,
	[Hor_Dia] [varchar](50) NULL,
	[Hor_Turno] [varchar](50) NULL,
	[Hor_Fin] [time](7) NULL,
 CONSTRAINT [PK_Horario] PRIMARY KEY CLUSTERED 
(
	[Hor_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Matricula]    Script Date: 10/29/2015 10:19:52 PM ******/
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
	[Mat_Fecha] [date] NOT NULL,
	[Mat_Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Matricula] PRIMARY KEY CLUSTERED 
(
	[Mat_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Modulo]    Script Date: 10/29/2015 10:19:52 PM ******/
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
	[Mod_Nivel] [int] NULL,
 CONSTRAINT [PK_Modulo] PRIMARY KEY CLUSTERED 
(
	[Mod_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pago]    Script Date: 10/29/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pago](
	[Pag_Id] [int] IDENTITY(1,1) NOT NULL,
	[Alu_Id] [int] NULL,
	[Pag_Fech] [date] NULL,
 CONSTRAINT [PK_Pago] PRIMARY KEY CLUSTERED 
(
	[Pag_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Persona]    Script Date: 10/29/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Persona](
	[Per_Id] [int] IDENTITY(1,1) NOT NULL,
	[Per_Dni] [int] NOT NULL,
	[Per_Nombre] [varchar](50) NULL,
	[Per_ApePaterno] [varchar](50) NULL,
	[Per_ApeMaterno] [varchar](50) NOT NULL,
	[Per_Sexo] [char](1) NULL,
	[Per_Dir] [varchar](50) NULL,
	[Per_Cel] [char](9) NULL,
	[Per_Tel] [varchar](20) NOT NULL,
	[Per_Email] [varchar](50) NULL,
 CONSTRAINT [PK_Persona] PRIMARY KEY CLUSTERED 
(
	[Per_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 10/29/2015 10:19:52 PM ******/
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
/****** Object:  Table [dbo].[Programacion]    Script Date: 10/29/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Programacion](
	[Prog_Id] [int] IDENTITY(1,1) NOT NULL,
	[Aul_Id] [int] NOT NULL,
	[Hor_Id] [int] NOT NULL,
 CONSTRAINT [PK_Programacion] PRIMARY KEY CLUSTERED 
(
	[Prog_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Recibo]    Script Date: 10/29/2015 10:19:52 PM ******/
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
/****** Object:  Table [dbo].[TipoUsuario]    Script Date: 10/29/2015 10:19:52 PM ******/
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
 CONSTRAINT [PK_Tipo_Usuario] PRIMARY KEY CLUSTERED 
(
	[TipoUser_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 10/29/2015 10:19:52 PM ******/
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
	[User_Nombre] [varchar](50) NOT NULL,
	[User_Pass] [varchar](20) NOT NULL,
	[User_Inactivo] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario_1] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
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
ALTER TABLE [dbo].[Curso]  WITH CHECK ADD  CONSTRAINT [FK_Curso_Modulo] FOREIGN KEY([Mod_Id])
REFERENCES [dbo].[Modulo] ([Mod_Id])
GO
ALTER TABLE [dbo].[Curso] CHECK CONSTRAINT [FK_Curso_Modulo]
GO
ALTER TABLE [dbo].[Curso]  WITH CHECK ADD  CONSTRAINT [FK_Curso_Programacion] FOREIGN KEY([Prog_Id])
REFERENCES [dbo].[Programacion] ([Prog_Id])
GO
ALTER TABLE [dbo].[Curso] CHECK CONSTRAINT [FK_Curso_Programacion]
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
ALTER TABLE [dbo].[Persona]  WITH CHECK ADD  CONSTRAINT [CK_Persona] CHECK  (([Per_Sexo]='M' OR [Per_Sexo]='F'))
GO
ALTER TABLE [dbo].[Persona] CHECK CONSTRAINT [CK_Persona]
GO
/****** Object:  StoredProcedure [dbo].[Profesor.Get]    Script Date: 10/29/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Profesor.Get]
as

select
	 per.Per_Id
	,Per.Per_Dni
	,per.Per_Nombre
	,per.Per_ApePaterno
	,per.Per_ApeMaterno
	,per.Per_Sexo
	,per.Per_Dir
	,per.Per_Cel
	,per.Per_Tel
	,per.Per_Email

	,u.User_Id
	,u.User_Nombre
	,u.User_Pass
	,u.User_Inactivo

	,tu.TipoUser_Id
	,tu.TipoUser_Nivel

	,pro.Prof_Id
	,pro.Cur_Id
	,pro.Prof_Especialidad

from [dbo].[Profesor] pro 
inner join [dbo].[Usuario] u
	on u.User_Id = pro.User_Id
inner join [dbo].[Persona] per
	on per.Per_Id = u.Per_Id
inner join [dbo].[Tipo_Usuario] tu
	on tu.TipoUser_Id = u.TipoUser_Id
GO
/****** Object:  StoredProcedure [dbo].[Profesor.Insert]    Script Date: 10/29/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Profesor.Insert]
		--Person parameters
		 @Per_Dni				INT
		,@Per_Nombre			VARCHAR(500)
		,@Per_ApePaterno		VARCHAR(500)
		,@Per_ApeMaterno		VARCHAR(500)
		,@Per_Sexo				VARCHAR(500)
		,@Per_Dir				VARCHAR(500)
		,@Per_Cel				VARCHAR(500)
		,@Per_Tel				VARCHAR(500)
		,@Per_Email				VARCHAR(500)
		
		--Usuario parameters
		,@TipoUser_ID			INT
		,@User_Nombre			VARCHAR(500)
		,@User_Pass				VARCHAR(16)

		--Profesor parameters
		,@Cur_Id				INT
		,@Prof_Especialidad		VARCHAR(500)

as
	
	DECLARE @PersonaID	INT
	DECLARE @UsuarioID	INT


	INSERT INTO [dbo].[Persona]
	(
		 [Per_Dni]
		,[Per_Nombre]
		,[Per_ApePaterno]
		,[Per_ApeMaterno]
		,[Per_Sexo]
		,[Per_Dir]
		,[Per_Cel]
		,[Per_Tel]
		,[Per_Email]
	)
	select
		 @Per_Dni
		,@Per_Nombre
		,@Per_ApePaterno
		,@Per_ApeMaterno
		,@Per_Sexo
		,@Per_Dir
		,@Per_Cel
		,@Per_Tel
		,@Per_Email


	SET @PersonaID = SCOPE_IDENTITY();


	INSERT INTO [dbo].[Usuario]
	(
		 [Per_Id]
		,[TipoUser_Id]
		,[User_Nombre]
		,[User_Pass]
		,[User_Inactivo]
	)
	select
		 @PersonaID
		,@TipoUser_ID		
		,@User_Nombre		
		,@User_Pass			
		,1

	
	SET @UsuarioID = SCOPE_IDENTITY();


	INSERT INTO [dbo].[Profesor]
	(
		 [User_Id]
		,[Cur_Id]
		--,[Prof_Rpm]
		--,[Prof_Nextel]
		,[Prof_Especialidad]
	)
	SELECT
		 @UsuarioID
		,@Cur_Id
		,@Prof_Especialidad
GO
/****** Object:  StoredProcedure [dbo].[Usuario.Get]    Script Date: 10/29/2015 10:19:52 PM ******/
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
	,@minRowNumber		int				= ''
	,@maxRowNumber		int				= ''

as

/* Test Section

	exec [dbo].[Usuario.Get]
		 @UserID			= 4
		,@PrimerNombre		= ''
		,@ApellidoPaterno	= ''
		,@Email				= ''
		,@TipoUsuario		= 'Todos'
		--,@minRowNumber		= '1'
		--,@maxRowNumber		= '15'

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
			per.Per_Email like  '%' + @Email + '%'
		)
	and (
			@UserID	= 0
			or
			u.User_Id = @UserID
		)
	

--SELECT COUNT(*) as total_records FROM #UsuarioDetails

select * from #UsuarioDetails
--where record_number between @minRowNumber and @maxRowNumber
GO
