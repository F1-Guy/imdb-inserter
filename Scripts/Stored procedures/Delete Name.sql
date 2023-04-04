CREATE PROCEDURE deleteName
    @nconst varchar(10)
AS
BEGIN
    DELETE FROM names WHERE nconst = @nconst;
END