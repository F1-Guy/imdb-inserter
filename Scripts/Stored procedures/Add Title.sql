CREATE PROCEDURE addTitle
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
	VALUES (@newTconst,  LTRIM(@genreName));
	FETCH NEXT FROM genreCursor INTO @genreName;
END
CLOSE genreCursor;
DEALLOCATE genreCursor;
END