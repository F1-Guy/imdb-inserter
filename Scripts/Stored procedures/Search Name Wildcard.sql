CREATE PROCEDURE find_name (@name VARCHAR(MAX))
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