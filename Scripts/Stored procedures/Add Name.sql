CREATE PROCEDURE addName
		@primaryName varchar(150), 
		@birthYear smallint,
		@deathYear smallint
AS
BEGIN
DECLARE @count int;
DECLARE @newNconst varchar(10);

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
END