using IMDB_Data_Inserter;
using System.Data.SqlClient;
using System.Reflection;
using System.Text.RegularExpressions;

//Console.WriteLine("Press 1");
//string action = Console.ReadLine();

Console.WriteLine("Reading...");
//var titles = Reader.GetTitles();
//var names = Reader.GetNames();
var crews = Reader.GetCrews();

Console.WriteLine("Data is in memory!");

using (SqlConnection sqlConn = new SqlConnection(
    "Server=localhost;Database=IMDB;User ID=user;Password=pass123;"))
{
    sqlConn.Open();

    Console.WriteLine("Bulk inserting...");
    //Inserter.InsertTitles(sqlConn, titles);

    //Inserter.InsertNames(sqlConn, names);

    Inserter.InsertCrew(sqlConn, crews);
}

Console.WriteLine("Done!");

void DeleteTitles(SqlConnection sqlConn)
{
    SqlCommand sqlComm = new SqlCommand("DELETE FROM Titles", sqlConn);
    sqlComm.ExecuteNonQuery();
}