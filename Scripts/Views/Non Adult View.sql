CREATE VIEW [Non Adult] AS 
SELECT tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes
FROM Titles
WHERE isAdult = '0'