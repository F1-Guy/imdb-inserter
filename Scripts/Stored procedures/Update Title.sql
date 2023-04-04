CREATE PROCEDURE updateTitle
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