using IMDB_Data_Inserter.Models;

namespace IMDB_Data_Inserter
{
    public static class Reader
    {
        private static readonly string path = @"..\..\..\..\Data\";

        public static List<Title> GetTitles()
        {
            var list = new List<Title>();

            foreach (string line in File.ReadLines(path + "title.basics.tsv")
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
                        isAdult = values[4] != "0",
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

            return list;
        }

        private static int? CheckInt(string value)
        {
            bool canParse = int.TryParse(value, out int parsed);

            if (canParse) return parsed;

            return null;
        }
    }
}
