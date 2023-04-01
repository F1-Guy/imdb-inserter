USE [IMDB]
GO
/****** Object:  Table [dbo].[Directors]    Script Date: 01/04/2023 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Directors](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tconst] [varchar](50) NOT NULL,
	[nconst] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Directors] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 01/04/2023 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[genre] [varchar](50) NULL,
	[tconst] [varchar](50) NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KnownForTitles]    Script Date: 01/04/2023 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KnownForTitles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nconst] [varchar](50) NOT NULL,
	[tconst] [varchar](50) NOT NULL,
 CONSTRAINT [PK_KnownForTitles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Names]    Script Date: 01/04/2023 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Names](
	[nconst] [varchar](50) NOT NULL,
	[primaryName] [varchar](100) NOT NULL,
	[birthYear] [int] NULL,
	[deathYear] [int] NULL,
 CONSTRAINT [PK_Names] PRIMARY KEY CLUSTERED 
(
	[nconst] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Professions]    Script Date: 01/04/2023 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Professions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[profession] [varchar](100) NULL,
	[nconst] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Professions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Titles]    Script Date: 01/04/2023 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Titles](
	[tconst] [varchar](50) NOT NULL,
	[titleType] [varchar](50) NOT NULL,
	[primaryTitle] [varchar](500) NOT NULL,
	[originalTitle] [varchar](500) NOT NULL,
	[isAdult] [bit] NOT NULL,
	[startYear] [int] NULL,
	[endYear] [int] NULL,
	[runtimeMinutes] [int] NULL,
 CONSTRAINT [PK_Titles] PRIMARY KEY CLUSTERED 
(
	[tconst] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Writers]    Script Date: 01/04/2023 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Writers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tconst] [varchar](50) NOT NULL,
	[nconst] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Writers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Directors]  WITH NOCHECK ADD  CONSTRAINT [FK_Directors_Names] FOREIGN KEY([nconst])
REFERENCES [dbo].[Names] ([nconst])
GO
ALTER TABLE [dbo].[Directors] CHECK CONSTRAINT [FK_Directors_Names]
GO
ALTER TABLE [dbo].[Directors]  WITH NOCHECK ADD  CONSTRAINT [FK_Directors_Titles] FOREIGN KEY([tconst])
REFERENCES [dbo].[Titles] ([tconst])
GO
ALTER TABLE [dbo].[Directors] CHECK CONSTRAINT [FK_Directors_Titles]
GO
ALTER TABLE [dbo].[Genres]  WITH NOCHECK ADD  CONSTRAINT [FK_Genres_Titles] FOREIGN KEY([tconst])
REFERENCES [dbo].[Titles] ([tconst])
GO
ALTER TABLE [dbo].[Genres] CHECK CONSTRAINT [FK_Genres_Titles]
GO
ALTER TABLE [dbo].[KnownForTitles]  WITH CHECK ADD  CONSTRAINT [FK_KnownForTitles_Names] FOREIGN KEY([nconst])
REFERENCES [dbo].[Names] ([nconst])
GO
ALTER TABLE [dbo].[KnownForTitles] CHECK CONSTRAINT [FK_KnownForTitles_Names]
GO
ALTER TABLE [dbo].[KnownForTitles]  WITH CHECK ADD  CONSTRAINT [FK_KnownForTitles_Titles] FOREIGN KEY([tconst])
REFERENCES [dbo].[Titles] ([tconst])
GO
ALTER TABLE [dbo].[KnownForTitles] CHECK CONSTRAINT [FK_KnownForTitles_Titles]
GO
ALTER TABLE [dbo].[Professions]  WITH CHECK ADD  CONSTRAINT [FK_Professions_Names] FOREIGN KEY([nconst])
REFERENCES [dbo].[Names] ([nconst])
GO
ALTER TABLE [dbo].[Professions] CHECK CONSTRAINT [FK_Professions_Names]
GO
ALTER TABLE [dbo].[Writers]  WITH NOCHECK ADD  CONSTRAINT [FK_Writers_Titles] FOREIGN KEY([tconst])
REFERENCES [dbo].[Titles] ([tconst])
GO
ALTER TABLE [dbo].[Writers] CHECK CONSTRAINT [FK_Writers_Titles]
GO
ALTER TABLE [dbo].[Writers]  WITH NOCHECK ADD  CONSTRAINT [FK_Writers_Titles1] FOREIGN KEY([nconst])
REFERENCES [dbo].[Names] ([nconst])
GO
ALTER TABLE [dbo].[Writers] CHECK CONSTRAINT [FK_Writers_Titles1]
GO
