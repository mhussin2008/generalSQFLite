import 'dart:io';

import 'package:sqflite/sqflite.dart';


class dbaseHelper
{
  static final dbaseHelper _instance = dbaseHelper._internal();
  late var databasesPath ;
  late var dbFilePath;
  late var dbExists;
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
    databasesPath = await getDatabasesPath();
    dbFilePath = '$databasesPath/my_dbase.db';
    dbExists = await File(dbFilePath).existsSync();
    db=await openDatabase('my_dbase.db');



  }

}