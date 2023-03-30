using IMDB_Data_Inserter.Models;
using System.Data;
using System.Data.SqlClient;

namespace IMDB_Data_Inserter
{
    internal class Inserter
    {
        public static void InsertTitles(SqlConnection connection, List<Title> titles)
        {
            DataTable TitleTable = new("Titles");
            DataTable GenreTable = new("Genres");

            TitleTable.Columns.Add("tconst", typeof(string));
            TitleTable.Columns.Add("titleType", typeof(string));
            TitleTable.Columns.Add("primaryTitle", typeof(string));
            TitleTable.Columns.Add("originalTitle", typeof(string));
            TitleTable.Columns.Add("isAdult", typeof(bool));
            TitleTable.Columns.Add("startYear", typeof(int));
            TitleTable.Columns.Add("endYear", typeof(int));
            TitleTable.Columns.Add("runtimeMinutes", typeof(int));

            GenreTable.Columns.Add("tconst", typeof(string));
            GenreTable.Columns.Add("genre", typeof(string));
        }

        public static void InsertNames(SqlConnection connection, List<Name> names)
        {
            DataTable KnownForTable = new("KnownForTitles");
            DataTable NameTable = new("Names");
            DataTable ProfessionTable = new("Professions");

            KnownForTable.Columns.Add("nconst", typeof(string));
            KnownForTable.Columns.Add("tconst", typeof(string));

            NameTable.Columns.Add("nconst", typeof(string));
            NameTable.Columns.Add("primaryName", typeof(string));
            NameTable.Columns.Add("birthYear", typeof(int));
            NameTable.Columns.Add("deathYear", typeof(int));

            ProfessionTable.Columns.Add("nconst", typeof(string));
            ProfessionTable.Columns.Add("profession", typeof(string));
        }

        public void InsertCrew(SqlConnection connection, List<Crew> crews)
        {
            DataTable WriterTable = new("Writers");
            DataTable DirectorTable = new("Directors");

            WriterTable.Columns.Add("tconst", typeof(string));
            WriterTable.Columns.Add("nconst", typeof(string));

            DirectorTable.Columns.Add("tconst", typeof(string));
            DirectorTable.Columns.Add("nconst", typeof(string));
        }
    }
}
