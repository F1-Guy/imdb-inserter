using IMDB_Data_Inserter.Models;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Linq;

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
            return;
        }

        public static void InsertNames(SqlConnection connection, List<Name> names)
        {
            DataTable knownForTable = new("KnownForTitles");
            DataTable nameTable = new("Names");
            DataTable professionTable = new("Professions");

            nameTable.Columns.Add("nconst", typeof(string));
            nameTable.Columns.Add("primaryName", typeof(string));
            nameTable.Columns.Add("birthYear", typeof(int));
            nameTable.Columns.Add("deathYear", typeof(int));

            knownForTable.Columns.Add("id", typeof(int));
            knownForTable.Columns.Add("nconst", typeof(string));
            knownForTable.Columns.Add("tconst", typeof(string));

            professionTable.Columns.Add("id", typeof(int));
            professionTable.Columns.Add("profession", typeof(string));
            professionTable.Columns.Add("nconst", typeof(string));

            foreach (Name name in names)
            {
                DataRow nameRow = nameTable.NewRow();
                nameRow["nconst"] = name.nconst;
                nameRow["primaryName"] = name.primaryName;
                nameRow["birthYear"] = name.birthYear == null ? DBNull.Value : name.birthYear;
                nameRow["deathYear"] = name.deathYear == null ? DBNull.Value : name.deathYear;

                nameTable.Rows.Add(nameRow);

                if (name.knownForTitles != null)
                {
                    foreach (var tconst in name.knownForTitles)
                    {
                        DataRow row = knownForTable.NewRow();
                        row["id"] = DBNull.Value;
                        row["nconst"] = name.nconst;
                        row["tconst"] = tconst;

                        knownForTable.Rows.Add(row);
                    }
                }

                if (name.primaryProfessions != null)
                {
                    foreach (var profession in name.primaryProfessions)
                    {
                        DataRow row = professionTable.NewRow();
                        row["id"] = DBNull.Value;
                        row["profession"] = profession;
                        row["nconst"] = name.nconst;


                        professionTable.Rows.Add(row);
                    }
                }

            }

            SqlBulkCopy bulkNames = new(connection, SqlBulkCopyOptions.KeepNulls, null);
            bulkNames.DestinationTableName = "Names";
            bulkNames.BulkCopyTimeout = 0;
            bulkNames.WriteToServer(nameTable);

            SqlBulkCopy bulkKnownFor = new SqlBulkCopy(connection, SqlBulkCopyOptions.KeepNulls, null);
            bulkKnownFor.DestinationTableName = "KnownForTitles";
            bulkKnownFor.BulkCopyTimeout = 0;
            bulkKnownFor.WriteToServer(knownForTable);


            SqlBulkCopy bulkProfessions = new(connection, SqlBulkCopyOptions.KeepNulls, null);
            bulkProfessions.DestinationTableName = "Professions";
            bulkProfessions.BulkCopyTimeout = 0;
            bulkProfessions.WriteToServer(professionTable);
            return;
        }

        public static void InsertCrew(SqlConnection connection, List<Crew> crews)
        {
            DataTable writerTable = new("Writers");
            DataTable directorTable = new("Directors");

            writerTable.Columns.Add("id", typeof(int));
            writerTable.Columns.Add("tconst", typeof(string));
            writerTable.Columns.Add("nconst", typeof(string));

            directorTable.Columns.Add("id", typeof(int));
            directorTable.Columns.Add("tconst", typeof(string));
            directorTable.Columns.Add("nconst", typeof(string));

            foreach(Crew c in crews)
            {
                if(c.wconst != null) 
                {
                    foreach (var wconst in c.wconst)
                    {
                        DataRow row = writerTable.NewRow();
                        row["id"] = DBNull.Value;
                        row["tconst"] = c.tconst;
                        row["nconst"] = wconst;

                        writerTable.Rows.Add(row);
                    }

                }
                if (c.dconst != null)
                {
                    foreach (var dconst in c.dconst)
                    {
                        DataRow row = directorTable.NewRow();
                        row["id"] = DBNull.Value;
                        row["tconst"] = c.tconst;
                        row["nconst"] = dconst;

                        directorTable.Rows.Add(row);
                    }
                }

            }

            SqlBulkCopy bulkWriters = new(connection, SqlBulkCopyOptions.KeepNulls, null);
            bulkWriters.DestinationTableName = "Writers";
            bulkWriters.BulkCopyTimeout = 0;
            bulkWriters.WriteToServer(writerTable);


            SqlBulkCopy bulkDirectors = new(connection, SqlBulkCopyOptions.KeepNulls, null);
            bulkDirectors.DestinationTableName = "Directors";
            bulkDirectors.BulkCopyTimeout = 0;
            bulkDirectors.WriteToServer(directorTable);

            return;
        }
    }
}
