USE [master]
GO
/****** Object:  Database [IMDB]    Script Date: 04/04/2023 22.36.51 ******/
CREATE DATABASE [IMDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IMDB', FILENAME = N'H:\Programs\SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\IMDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'IMDB_log', FILENAME = N'H:\Programs\SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\IMDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [IMDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IMDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IMDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IMDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IMDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IMDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IMDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [IMDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [IMDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IMDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IMDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IMDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IMDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IMDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IMDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IMDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IMDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [IMDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IMDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IMDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IMDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IMDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IMDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IMDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IMDB] SET RECOVERY FULL 
GO
ALTER DATABASE [IMDB] SET  MULTI_USER 
GO
ALTER DATABASE [IMDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IMDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IMDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IMDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [IMDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [IMDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'IMDB', N'ON'
GO
ALTER DATABASE [IMDB] SET QUERY_STORE = OFF
GO
USE [IMDB]
GO
/****** Object:  User [user]    Script Date: 04/04/2023 22.36.51 ******/
CREATE USER [user] FOR LOGIN [user] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [user]
GO
/****** Object:  Table [dbo].[Titles]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Titles](
	[tconst] [varchar](10) NOT NULL,
	[titleType] [varchar](50) NOT NULL,
	[primaryTitle] [varchar](500) NOT NULL,
	[originalTitle] [varchar](500) NOT NULL,
	[isAdult] [bit] NOT NULL,
	[startYear] [smallint] NULL,
	[endYear] [smallint] NULL,
	[runtimeMinutes] [int] NULL,
 CONSTRAINT [PK_Titles] PRIMARY KEY CLUSTERED 
(
	[tconst] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Non Adult]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Non Adult] AS 
SELECT tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes
FROM Titles
WHERE isAdult = '0' 
GO
/****** Object:  Table [dbo].[Names]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Names](
	[nconst] [varchar](10) NOT NULL,
	[primaryName] [varchar](150) NOT NULL,
	[birthYear] [smallint] NULL,
	[deathYear] [smallint] NULL,
 CONSTRAINT [PK_Names] PRIMARY KEY CLUSTERED 
(
	[nconst] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Professions]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Professions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[profession] [varchar](100) NULL,
	[nconst] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Professions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Actors]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Actors] AS
SELECT Names.primaryName, Names.deathYear, Professions.profession 
FROM Names JOIN Professions ON Names.nconst = Professions.nconst
WHERE Professions.profession = 'actor' OR Professions.profession = 'actress'
GO
/****** Object:  Table [dbo].[Directors]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Directors](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tconst] [varchar](10) NOT NULL,
	[nconst] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Directors] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[genre] [varchar](50) NULL,
	[tconst] [varchar](10) NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KnownForTitles]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KnownForTitles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nconst] [varchar](10) NOT NULL,
	[tconst] [varchar](10) NOT NULL,
 CONSTRAINT [PK_KnownForTitles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Writers]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Writers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tconst] [varchar](10) NOT NULL,
	[nconst] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Writers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [primaryName_index]    Script Date: 04/04/2023 22.36.51 ******/
CREATE NONCLUSTERED INDEX [primaryName_index] ON [dbo].[Names]
(
	[primaryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [primaryTitle_index]    Script Date: 04/04/2023 22.36.51 ******/
CREATE NONCLUSTERED INDEX [primaryTitle_index] ON [dbo].[Titles]
(
	[primaryTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Directors]  WITH NOCHECK ADD  CONSTRAINT [FK_Directors_Names] FOREIGN KEY([nconst])
REFERENCES [dbo].[Names] ([nconst])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Directors] CHECK CONSTRAINT [FK_Directors_Names]
GO
ALTER TABLE [dbo].[Directors]  WITH NOCHECK ADD  CONSTRAINT [FK_Directors_Titles] FOREIGN KEY([tconst])
REFERENCES [dbo].[Titles] ([tconst])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Directors] CHECK CONSTRAINT [FK_Directors_Titles]
GO
ALTER TABLE [dbo].[Genres]  WITH NOCHECK ADD  CONSTRAINT [FK_Genres_Titles] FOREIGN KEY([tconst])
REFERENCES [dbo].[Titles] ([tconst])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Genres] CHECK CONSTRAINT [FK_Genres_Titles]
GO
ALTER TABLE [dbo].[KnownForTitles]  WITH NOCHECK ADD  CONSTRAINT [FK_KnownForTitles_Names] FOREIGN KEY([nconst])
REFERENCES [dbo].[Names] ([nconst])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KnownForTitles] CHECK CONSTRAINT [FK_KnownForTitles_Names]
GO
ALTER TABLE [dbo].[KnownForTitles]  WITH NOCHECK ADD  CONSTRAINT [FK_KnownForTitles_Titles] FOREIGN KEY([tconst])
REFERENCES [dbo].[Titles] ([tconst])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KnownForTitles] CHECK CONSTRAINT [FK_KnownForTitles_Titles]
GO
ALTER TABLE [dbo].[Professions]  WITH NOCHECK ADD  CONSTRAINT [FK_Professions_Names] FOREIGN KEY([nconst])
REFERENCES [dbo].[Names] ([nconst])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Professions] CHECK CONSTRAINT [FK_Professions_Names]
GO
ALTER TABLE [dbo].[Writers]  WITH NOCHECK ADD  CONSTRAINT [FK_Writers_Names] FOREIGN KEY([nconst])
REFERENCES [dbo].[Names] ([nconst])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Writers] CHECK CONSTRAINT [FK_Writers_Names]
GO
ALTER TABLE [dbo].[Writers]  WITH NOCHECK ADD  CONSTRAINT [FK_Writers_Titles] FOREIGN KEY([tconst])
REFERENCES [dbo].[Titles] ([tconst])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Writers] CHECK CONSTRAINT [FK_Writers_Titles]
GO
/****** Object:  StoredProcedure [dbo].[addName]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addName]
	@primaryName varchar(150), 
	@birthYear smallint,
	@deathYear smallint,
	@profession varchar(300)
AS
BEGIN
	DECLARE @count int;
	DECLARE @newNconst varchar(10);
	DECLARE @professionList TABLE (professionName varchar(50));
	
	-- Split the profession string into individual professions
	WHILE LEN(@profession) > 0
	BEGIN
		DECLARE @commaIndex int = CHARINDEX(',', @profession);
		DECLARE @professionName varchar(50);
		
		IF @commaIndex = 0
		BEGIN
			SET @professionName = @profession;
			SET @profession = '';
		END
		ELSE
		BEGIN
			SET @professionName = SUBSTRING(@profession, 1, @commaIndex - 1);
			SET @profession = SUBSTRING(@profession, @commaIndex + 1, LEN(@profession));
		END
		
		INSERT INTO @professionList (professionName) VALUES (@professionName);
	END
	
	-- Create new nconst based on the last nconst in the database
	SELECT @newNconst = 'nm' + RIGHT('0000000' + CAST(MAX(RIGHT(nconst, 7)) + 1 AS VARCHAR(7)), 7)
	FROM Names
	
	-- In case there are no names
	IF @newNconst is null
	BEGIN 
		SET @newNconst = 'nm0000001'
	END
	
	INSERT INTO Names (nconst, primaryName, birthYear, deathYear)
	VALUES (@newNconst, @primaryName, @birthYear, @deathYear);
	
	-- Insert professions into the profession table
	DECLARE professionCursor CURSOR FOR SELECT professionName FROM @professionList;
	OPEN professionCursor;
	FETCH NEXT FROM professionCursor INTO @professionName;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO Professions (nconst, profession)
		VALUES (@newNconst,  TRIM(@professionName));
		FETCH NEXT FROM professionCursor INTO @professionName;
	END
	CLOSE professionCursor;
	DEALLOCATE professionCursor;
END
GO
/****** Object:  StoredProcedure [dbo].[addTitle]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addTitle]
@titleType varchar(50),
@primaryTitle varchar(450),
@originalTitle varchar(450),
@isAdult bit,
@startYear smallint,
@endYear smallint,
@runtimeMinutes int,
@genre varchar(300)
AS
BEGIN
DECLARE @count int;
DECLARE @newTconst varchar(10);
DECLARE @genreList TABLE (genreName varchar(50));

-- Split the genre string into individual genres
WHILE LEN(@genre) > 0
BEGIN
DECLARE @commaIndex int = CHARINDEX(',', @genre);
DECLARE @genreName varchar(50);

IF @commaIndex = 0
BEGIN
	SET @genreName = @genre;
	SET @genre = '';
END
ELSE
BEGIN
	SET @genreName = SUBSTRING(@genre, 1, @commaIndex - 1);
	SET @genre = SUBSTRING(@genre, @commaIndex + 1, LEN(@genre));
END

INSERT INTO @genreList (genreName) VALUES (@genreName);

END

-- Create new tconst based on the last tconst in the database
SELECT @newTconst = 'tt' + RIGHT('0000000' + CAST(MAX(RIGHT(tconst, 7)) + 1 AS VARCHAR(7)), 7)
FROM Titles

-- In case there are no titles
IF @newTconst is null
BEGIN
SET @newTconst = 'tt0000001'
END

INSERT INTO titles (tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes)
VALUES (@newTconst, @titleType, @primaryTitle, @originalTitle, @isAdult, @startYear, @endYear, @runtimeMinutes);

-- Insert genres into the genre table
DECLARE genreCursor CURSOR FOR SELECT genreName FROM @genreList;
OPEN genreCursor;
FETCH NEXT FROM genreCursor INTO @genreName;
WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO Genres (tconst, genre)
	VALUES (@newTconst,  TRIM(@genreName));
	FETCH NEXT FROM genreCursor INTO @genreName;
END
CLOSE genreCursor;
DEALLOCATE genreCursor;
END
GO
/****** Object:  StoredProcedure [dbo].[deleteName]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteName]
    @nconst varchar(10)
AS
BEGIN
    DELETE FROM names WHERE nconst = @nconst;
END
GO
/****** Object:  StoredProcedure [dbo].[deleteTitle]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteTitle]
    @tconst varchar(10)
AS
BEGIN
    DELETE FROM titles WHERE tconst = @tconst;
END
GO
/****** Object:  StoredProcedure [dbo].[findName]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[findName] (@name VARCHAR(MAX))
AS
BEGIN
    IF (@name IS NULL OR @name = '')
    BEGIN
        RETURN 1
    END

    SELECT nconst, primaryName, birthYear, deathYear
    FROM Names
    WHERE primaryName LIKE '%' + @name + '%'
	ORDER BY primaryName ASC
END
GO
/****** Object:  StoredProcedure [dbo].[findTitle]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[findTitle] (@title VARCHAR(MAX))
AS
BEGIN
    IF (@title IS NULL OR @title = '')
    BEGIN
        RETURN 1
    END

    SELECT tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes
    FROM Titles
    WHERE primaryTitle LIKE '%' + @title + '%'
	ORDER BY primaryTitle ASC
END
GO
/****** Object:  StoredProcedure [dbo].[updateTitle]    Script Date: 04/04/2023 22.36.51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateTitle]
    @tconst varchar(10),
    @titleType varchar(50),
    @primaryTitle varchar(450), 
    @originalTitle varchar(450), 
    @isAdult bit,
    @startYear smallInt,
    @endYear smallInt,
    @runtimeMinutes Int,
    @genre varchar(300)
AS
BEGIN
    DECLARE @genreList TABLE (genreName varchar(50));
    WHILE LEN(@genre) > 0
    BEGIN
        DECLARE @commaIndex int = CHARINDEX(',', @genre);
        DECLARE @genreName varchar(50);

        IF @commaIndex = 0
        BEGIN
            SET @genreName = @genre;
            SET @genre = '';
        END
        ELSE
        BEGIN
            SET @genreName = SUBSTRING(@genre, 1, @commaIndex - 1);
            SET @genre = SUBSTRING(@genre, @commaIndex + 1, LEN(@genre));
        END

        INSERT INTO @genreList (genreName) VALUES (@genreName);

    END

    UPDATE titles
    SET titleType = @titleType,
        primaryTitle = @primaryTitle,
        originalTitle = @originalTitle,
        isAdult = @isAdult,
        startYear = @startYear,
        endYear = @endYear,
        runtimeMinutes = @runtimeMinutes
    WHERE tconst = @tconst;

    -- Delete existing genre information
    DELETE FROM Genres WHERE tconst = @tconst;

    -- Insert new genre information
    DECLARE genreCursor CURSOR FOR SELECT genreName FROM @genreList;
    OPEN genreCursor;
    FETCH NEXT FROM genreCursor INTO @genreName;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO Genres (tconst, genre)
        VALUES (@tconst,  TRIM(@genreName));
        FETCH NEXT FROM genreCursor INTO @genreName;
    END
    CLOSE genreCursor;
    DEALLOCATE genreCursor;
END
GO
USE [master]
GO
ALTER DATABASE [IMDB] SET  READ_WRITE 
GO
