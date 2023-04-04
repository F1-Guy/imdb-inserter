CREATE PROCEDURE updateTitle
    @tconst varchar(10),
    @titleType varchar(50),
    @primaryTitle varchar(450), 
    @originalTitle varchar(450), 
    @isAdult bit,
    @startYear smallInt,
    @endYear smallInt,
    @runtimeMinutes Int
AS
BEGIN
    UPDATE titles
    SET titleType = @titleType,
        primaryTitle = @primaryTitle,
        originalTitle = @originalTitle,
        isAdult = @isAdult,
        startYear = @startYear,
        endYear = @endYear,
        runtimeMinutes = @runtimeMinutes
    WHERE tconst = @tconst;
END