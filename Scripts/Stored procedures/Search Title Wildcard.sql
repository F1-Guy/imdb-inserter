CREATE PROCEDURE find_movie (@title VARCHAR(MAX))
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