import 'dart:io';

import 'package:generaldbase/dbHelper/theData.dart';
import 'package:sqflite/sqflite.dart';


class dbaseHelper
{
  static final dbaseHelper _instance = dbaseHelper._internal();
  late var databasesPath ;
  late var dbFilePath;
  bool dbExists=false;
  bool tableExists=false;
  late Database db;


  factory dbaseHelper()  {

    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  dbaseHelper._internal() {
    // initialization logic
   initialize();
  }

  void initialize() async {
    print('started initialization');
    databasesPath = await getDatabasesPath();
    dbFilePath = '$databasesPath/my_dbase.db';
    await File(dbFilePath).existsSync();
    db=await openDatabase('my_dbase.db');
    print('finished initialization');
    if(db.isOpen){dbExists=true;}


  }

  Future<void> tableExistsF() async {
    if(dbExists) {
      var result =
          await db.rawQuery('SELECT * FROM sqlite_master WHERE name="data";');
      //print(tableExists.runtimeType);
      //print(tableExists);
      if(result.isEmpty){tableExists=false;}else{tableExists=true;}
    }else{print('database doesnt exist');return;}
  }

  void createTable() async
  {
    tableExistsF();

      if(tableExists==false){
      await db.execute('CREATE TABLE data '
          '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' name TEXT,'
          'age INTEGER'
          ')');
      print('table created');

    }else{print('data table already exists');}
  }


  void addDatatoTable(List<SingleRecord> txRecords)  {
    var result;
    tableExistsF();
    if(dbExists  && tableExists){
      txRecords.forEach((element) async {
        result = await db.rawInsert(
            'INSERT INTO data (Name, Age) VALUES ("${element.Name}", "${element.Age}")');
        print(result.toString());
      });
    }
  }

  void readFromDatabase() async {
    if(dbExists) {
      await tableExistsF();
      if(tableExists){
      myRecords.recordsList.clear();

      List<Map<String, dynamic?>> showRecords = await db.query('data');
      showRecords.forEach((element) {
        myRecords.recordsList.add(SingleRecord(
            element.values.elementAt(1), element.values.elementAt(2)));
        // print(element.values);
        // print(element.runtimeType);
        print(element.toString());
      });}else{print('table not found');}
    }else{print('database not opened yet');}

  }

  void deleteDataInTable() {
    tableExistsF();
    if(dbExists && tableExists){
      mydbHelper.db.delete('data');
      print('all data in data table were deleted');

    }


  }

  Future<void> deleteTable() async {
    if(dbExists){
     await mydbHelper.db.execute('DROP TABLE IF EXISTS data');
      print('table data deleted ');

    }
  }



}