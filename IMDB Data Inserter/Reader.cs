using IMDB_Data_Inserter.Models;

namespace IMDB_Data_Inserter
{
    static public class Reader
    {
        static string path = @"C:\Users\barto\Documents\Programming\School\IMDB Data Inserter\Data\";

        public static List<Title> GetTitles()
        {
            var list = new List<Title>();

            foreach (string line in File.ReadLines(path + "title.basics.tsv").Take(100000)
                                        .Skip(1))
            {
                string[] values = line.Split('\t');

                if (values.Length == 9)
                {
                    list.Add(new Title()
                    {
                        tconst = values[0],
                        titleType = values[1],
                        primaryTitle = values[2],
                        originalTitle = values[3],
                        isAdult = values[4] == "0" ? false : true,
                        startYear = CheckInt(values[5]),
                        endYear = CheckInt(values[6]),
                        runtimeMinutes = CheckInt(values[7]),
                        genres = values[8] == @"\N" ? null : values[8].Split(",")
                    });
                }
            }

            return list;
        }

        public static List<Name> GetNames()
        {
            var list = new List<Name>();

            foreach (string line in File.ReadLines(path + "name.basics.tsv")
                                        .Skip(1))
            {
                string[] values = line.Split('\t');

                if (values.Length == 6)
                {
                    list.Add(new Name()
                    {
                        nconst = values[0],
                        primaryName = values[1],
                        birthYear = CheckInt(values[2]),
                        deathYear = CheckInt(values[3]),
                        primaryProfessions = values[4] == @"\N" ? null : values[4].Split(","),
                        knownForTitles = values[5] == @"\N" ? null : values[5].Split(",")
                    });
                }
            }

            return list;
        }

        public static List<Crew> GetCrews()
        {
            var list = new List<Crew>();

            foreach (string line in File.ReadLines(path + "title.crew.tsv")
                                        .Skip(1))
            {
                string[] values = line.Split('\t');

                if (values.Length == 3)
                {
                    list.Add(new Crew()
                    {
                        tconst = values[0],
                        dconst = values[1] == @"\N" ? null : values[1].Split(","),
                        wconst = values[2] == @"\N" ? null : values[2].Split(",")
                    });
                }
            }

            Console.WriteLine(list.Count);

            return list;
        }



        // Fix this later
        static int? CheckInt(string value)
        {
            int beforeParse = 0;

            int.TryParse(value, out beforeParse);

            int? result = null;

            if (beforeParse != 0)
            {
                result = beforeParse;
            }

            return result;
        }
    }
}
