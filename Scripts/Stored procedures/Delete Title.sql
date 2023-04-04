CREATE PROCEDURE deleteTitle
    @tconst varchar(10)
AS
BEGIN
    DELETE FROM titles WHERE tconst = @tconst;
END