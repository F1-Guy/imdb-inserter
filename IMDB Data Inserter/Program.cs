using IMDB_Data_Inserter;
using System.Data.SqlClient;

//Console.WriteLine("Press 1");
//string action = Console.ReadLine();

Console.WriteLine("Reading titles...");
var titles = Reader.GetTitles();
Console.WriteLine("Titles are in memory!");

using (SqlConnection sqlConn = new SqlConnection(
    "Server=localhost;Database=IMDB;User ID=user;Password=pass123;"))
{
    sqlConn.Open();

    // Remember to remove this
    //Console.WriteLine("Deleting titles...");
    //DeleteTitles(sqlConn);

    Console.WriteLine("Bulk inserting...");
    Inserter.InsertTitles(sqlConn, titles);
}

Console.WriteLine("Done!");

void DeleteTitles(SqlConnection sqlConn)
{
    SqlCommand sqlComm = new SqlCommand("DELETE FROM Titles", sqlConn);
    sqlComm.ExecuteNonQuery();
}