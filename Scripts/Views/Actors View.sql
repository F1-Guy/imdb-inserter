CREATE VIEW Actors AS
SELECT Names.primaryName, Names.deathYear, Professions.profession 
FROM Names JOIN Professions ON Names.nconst = Professions.nconst
WHERE Professions.profession = 'actor' OR Professions.profession = 'actress'