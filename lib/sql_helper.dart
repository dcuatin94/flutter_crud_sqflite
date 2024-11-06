// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './model/computadora.dart';

class SQLHelper {
/*
getDataBase() function takes 3 arguments and gives us a database which we again return to our future function.
String path of the Database
Version
onCreate Function
*/

  static const String _tableName = "computadoras";

  static Future<Database> getDataBase() async {
    return openDatabase(
      join(await getDatabasesPath(), "computadoras.db"),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, procesador TEXT, discoDuro TEXT, ram TEXT)",
        );
      },
      version: 1,
    );
  }

//============================= START CURD ===================================

//============================================================================
//Insert/Add Method
// First Insert Function Which will take values and add them inside the Database
  static Future<int> insert(Computadora computadora) async {
    int userId = 0;
    Database db = await getDataBase();
    //String path = await getDatabasesPath();
    //print('''getDatabasesPath: ${path}''');

    await db
        .insert(_tableName, computadora.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      userId = value;
    });
    return userId;
  }

//============================================================================
//Get All Method
//After adding data then comes the part where we need data and show it into the UI.
//first there is a need for a database and then db.query method provides all the rows in the provided table inside the query() method.

  static Future<List<Computadora>> getAllComputadoras() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> ComputadorasMap = await db.query(_tableName);
    return List.generate(ComputadorasMap.length, (index) {
      return Computadora(
          id: ComputadorasMap[index]["id"],
          nombre: ComputadorasMap[index]["nombre"] ?? "Desconocido",
          procesador: ComputadorasMap[index]["procesador"],
          discoDuro: ComputadorasMap[index]["discoDuro"],
          ram: ComputadorasMap[index]["ram"]);
    });
  }

//============================================================================
//Get method:
//This will return a Single user by using Where in the SQL query. For this, we need to pass the userID while calling this function.

  static Future<Computadora> getComputadora(int id) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> computadora =
        await db.rawQuery("SELECT * FROM $_tableName WHERE id = $id");
    if (computadora.length == 1) {
      return Computadora(
          id: computadora[0]['id'],
          nombre: computadora[0]['nombre'],
          procesador: computadora[0]['procesador'],
          discoDuro: computadora[0]['discoDuro'],
          ram: computadora[0]['ram']);
    } else {
      return Computadora(nombre: '', procesador: '', discoDuro: '', ram: '');
    }
  }

//============================================================================
//Update Method
//Updating a particular Computadora needs UserId and new values in the function when calling it. Here is the function for that below.
//Need to add an Update query and give it the table and updated values where id = userId.

  static Future<void> update(int id, String nombre, String procesador,
      String discoDuro, String ram) async {
    Database db = await getDataBase();
    db.rawUpdate(
        "UPDATE $_tableName SET nombre = '$nombre', procesador = '$procesador', discoDuro = '$discoDuro', ram = '$ram' WHERE id = '$id'");
  }

//============================================================================
//Delete method

  static Future<void> deleteComputadora(int id) async {
    Database db = await getDataBase();
    await db.rawDelete("DELETE FROM $_tableName WHERE id = '$id'");
  }

  //Now get the ID of the last row inserted:
  static Future<int> lastInsertedRowId(int id) async {
    Database db = await getDataBase();
    await db.execute("select last_insert_rowid()");

    // The row ID is a 64-bit value - cast the Command result to an Int64.
    //Int64 LastRowID64 = (Int64)Command.ExecuteScalar();

    // int lastRowID = (int)LastRowID64;
    return 1;
  }
}
