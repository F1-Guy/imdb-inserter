using IMDB_Data_Inserter;
using System.Data.SqlClient;

Console.WriteLine("Connecting to database...");

using SqlConnection sqlConn = new("Server=localhost;Database=IMDB;User ID=user;Password=pass123;");

sqlConn.Open();
Console.WriteLine("Connection successful");

Console.WriteLine("Reading titles...");
var titles = Reader.GetTitles();
Console.WriteLine("Data is in memory!");
Console.WriteLine("Bulk inserting titles...");
Inserter.InsertTitles(sqlConn, titles);
GC.Collect();

Console.WriteLine("Reading names...");
var names = Reader.GetNames();
Console.WriteLine("Data is in memory!");
Console.WriteLine("Bulk inserting names...");
Inserter.InsertNames(sqlConn, names);
GC.Collect();

Console.WriteLine("Reading crews...");
var crews = Reader.GetCrews();
Console.WriteLine("Data is in memory!");
Console.WriteLine("Bulk inserting crews...");
Inserter.InsertCrew(sqlConn, crews);

Console.WriteLine("Done!");