CREATE PROCEDURE addName
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