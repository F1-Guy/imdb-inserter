namespace IMDB_Data_Inserter.Models
{
    public class Crew
    {
        public string tconst { get; set; }

        public string[]? wconst { get; set; }

        public string[]? dconst { get; set; }

        public override string ToString()
        {
            return $"tconst: {tconst}, wconst: {wconst?.Length}, dconst: {dconst?.Length}";
        }
    }
}
