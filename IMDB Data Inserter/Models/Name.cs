namespace IMDB_Data_Inserter.Models
{
    public class Name
    {
        public string nconst { get; set; }
        public string primaryName { get; set; }
        public int? birthYear { get; set; }
        public int? deathYear { get; set; }
        public string[]? primaryProfessions { get; set; }
        public string[]? knownForTitles { get; set; }

        public override string ToString()
        {
            return $"nconst: {nconst}, Name: {primaryName}, Birth: {birthYear}, Death {deathYear}, prof: {primaryProfessions?.Length}, titles: {knownForTitles?.Length}";
        }
    }
}
