import 'dart:io';

import 'package:hive/hive.dart';

class simpleData{
  static bool _initialized=false;
  static late Box? box;
  static var path=Directory.current.path;
  static simpleData _instance=simpleData._internal();

  factory simpleData() {
    return _instance;
  }

  simpleData._internal()  {
    // initialization logic
    _initializeHive();
  }



  static Future<Box<dynamic>?> _initializeHive() async {
    Hive.init(path);
    box = await Hive.openBox('myDataBox');
    if(box!=null){
    _initialized=true;}
    return box;
  }

  static setData(String key,dynamic data) async {
    if(_initialized==false){
      await _initializeHive();
    }
    if(_initialized==true){
      box!.put(key, data);

    }
  }

  static Future<dynamic> getData(String key) async {
    if(_initialized==false){
      await _initializeHive();
    }
    if(_initialized==true){
      return await box!.get(key);
    }
  }

  static void close() {
    if(box!.isOpen){
    box!.close();}
  }


}