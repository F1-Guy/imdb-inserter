using IMDB_Data_Inserter.Models;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Text.RegularExpressions;

namespace IMDB_Data_Inserter
{
    public class Inserter
    {
        public static void InsertTitles(SqlConnection connection, List<Title> titles)
        {
            DataTable titleTable = new("Titles");
            DataTable genreTable = new("Genres");

            titleTable.Columns.Add("tconst", typeof(string));
            titleTable.Columns.Add("titleType", typeof(string));
            titleTable.Columns.Add("primaryTitle", typeof(string));
            titleTable.Columns.Add("originalTitle", typeof(string));
            titleTable.Columns.Add("isAdult", typeof(bool));
            titleTable.Columns.Add("startYear", typeof(int));
            titleTable.Columns.Add("endYear", typeof(int));
            titleTable.Columns.Add("runtimeMinutes", typeof(int));

            genreTable.Columns.Add("id", typeof(int));
            genreTable.Columns.Add("genre", typeof(string));
            genreTable.Columns.Add("tconst", typeof(string));


            foreach (Title title in titles)
            {
                DataRow titleRow = titleTable.NewRow();
                titleRow["tconst"] = title.tconst;
                titleRow["titleType"] = title.titleType;
                titleRow["primaryTitle"] = title.primaryTitle;
                titleRow["originalTitle"] = title.originalTitle;
                titleRow["isAdult"] = title.isAdult;
                titleRow["startYear"] = title.startYear == null ? DBNull.Value : title.startYear;
                titleRow["endYear"] = title.endYear == null ? DBNull.Value : title.endYear;
                titleRow["runtimeMinutes"] = title.runtimeMinutes == null ? DBNull.Value : title.runtimeMinutes;
                titleTable.Rows.Add(titleRow);

                if (title.genres != null)
                {
                    foreach (var genre in title.genres)
                    {
                        DataRow row = genreTable.NewRow();
                        row["id"] = DBNull.Value;
                        row["genre"] = genre;
                        row["tconst"] = title.tconst;

                        genreTable.Rows.Add(row);
                    }
                }
                else
                {
                    DataRow row = genreTable.NewRow();
                    row["id"] = DBNull.Value;
                    row["genre"] = DBNull.Value;
                    row["tconst"] = title.tconst;

                    genreTable.Rows.Add(row);
                }
            }
            SqlBulkCopy bulkTitles = new SqlBulkCopy(connection, SqlBulkCopyOptions.KeepNulls, null);
            bulkTitles.DestinationTableName = "Titles";
            bulkTitles.BatchSize = 10000;
            bulkTitles.BulkCopyTimeout = 0;
            bulkTitles.WriteToServer(titleTable);

            SqlBulkCopy bulk = new(connection, SqlBulkCopyOptions.KeepNulls, null);
            bulk.DestinationTableName = "Genres";
            bulk.BulkCopyTimeout = 0;
            bulk.WriteToServer(genreTable);
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

            return;
        }

        public void InsertCrew(SqlConnection connection, List<Crew> crews)
        {
            DataTable WriterTable = new("Writers");
            DataTable DirectorTable = new("Directors");

            WriterTable.Columns.Add("tconst", typeof(string));
            WriterTable.Columns.Add("nconst", typeof(string));

            DirectorTable.Columns.Add("tconst", typeof(string));
            DirectorTable.Columns.Add("nconst", typeof(string));

            return;
        }
    }
}
